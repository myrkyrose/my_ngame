/// draw()
is_pause = is_shadow;

/*var map = skin[1];
draw_sprite(map[? 'head'], 0, 50, 50);
draw_sprite(map[? 'body'], 0, 50, 50);*/


if (!is_battle) {
    // игрок:
    if (!is_pause) {
        pl_x += sign((key & keys.right) - (key & keys.left)) * 4;
        pl_y += sign((key & keys.down) - (key & keys.up)) * 4;
    }
    draw_sprite(pl_sprite, 0, pl_x, pl_y);
    view_xview = pl_x - view_wview / 2;
    view_yview = pl_y - view_hview / 2;
    for (var i = 0, map; i < count_enemy; i++) { // враги:
        map = enemy[i];
        draw_sprite(map[? 'sprite'], 0, map[? 'x'], map[? 'y']);
        if (point_distance(pl_x, pl_y, map[? 'x'], map[? 'y']) <= 30 && !is_pause) { // начало битвы:
            is_shadow = true;
            battle_id = i;
            break;
        }
    }
    if (shadow_alpha >= 1) {
        is_battle = true;
        var map = enemy[battle_id];
        battle_count = array_length_1d(map[? 'enemy']);
        view_xview = map[? 'x'] - 25 - view_wview / 2;
        view_yview = map[? 'y'] - view_hview / 2;
        pl_x = map[? 'x'] - 50;
        pl_y = map[? 'y'];
        is_shadow = false;
    }
} else { // битва:
    var pos = vec(vec(0, 0), vec(25, 40), vec(25, -40), vec(25, 0), vec(-10, -40), vec(-10, 40)), c_enemy = enemy[battle_id], enemy_list = c_enemy[? 'enemy'];
    if (battle_count) {
        if (count_player) {
            draw_set_valign(fa_center);
            draw_set_halign(fa_center);
            draw_set_colour($ffffff);
            if (!ds_list_empty(stack)) {
                var l = stack[| 0];
                for (var i = 0, nmap, npos; i < battle_count; i++) { // враги:
                    nmap = enemy_list[i];
                    npos = pos[i];
                    if (nmap[? 'hp'] > 0) {
                        var xx = 0, yy = 0;
                        if (nmap[? 'is_attack'] != -1) {
                            var nnpos = pos[nmap[? 'is_attack']];
                            xx = pl_x - nnpos[0];
                            yy = pl_y + nnpos[1];
                            switch(nmap[? 'is_delta']) {
                                case false:
                                    if (nmap[? 'delta'] < 1) nmap[? 'delta'] += .2;
                                        else nmap[? 'is_delta'] = true;
                                break;
                                case true:
                                    if (nmap[? 'delta'] > 0) nmap[? 'delta'] -= .1;
                                        else {
                                            var en_r = control_pl[nmap[? 'is_attack']];
                                            nmap[? 'is_delta'] = false;
                                            en_r[? 'hp'] -= nmap[? 'damage'];
                                            ds_list_add(stack, ds_list_find_value(stack, 0));
                                            ds_list_delete(stack, 0);
                                            nmap[? 'is_attack'] = -1;
                                            l[1] = -1;
                                        }
                                break;
                            }
                        }
                        //draw_sprite(nmap[? 'sprite'], 0, c_enemy[? 'x'] + npos[0] - ((c_enemy[? 'x'] + npos[0]) - xx) * nmap[? 'delta'], c_enemy[? 'y'] + npos[1] - ((pl_y + npos[1]) - yy) * nmap[? 'delta']);
                        //draw_text_transformed(c_enemy[? 'x'] + npos[0] - ((c_enemy[? 'x'] + npos[0]) - xx) * nmap[? 'delta'], c_enemy[? 'y'] + npos[1] - sprite_get_height(nmap[? 'sprite']) - 4 - ((pl_y + npos[1]) - yy) * nmap[? 'delta'], nmap[? 'name'] + '[' + string(nmap[? 'hp']) + '/' + string(nmap[? 'max_hp']) + ']', .25, .25, 0);
                        if (!l[0]) { // ход игрока:
                            if (point_in_rectangle(mouse_x, mouse_y, c_enemy[? 'x'] + npos[0] - 8, c_enemy[? 'y'] + npos[1] - 4, c_enemy[? 'x'] + npos[0] + 8, c_enemy[? 'y'] + npos[1] + 4)) {                                
                                cursor |= cursors.hover;
                                draw_text_transformed(mouse_x + 20, mouse_y + 10, '-' + string(ds_map_find_value(control_pl[l[1]], 'damage')), .25, .25, 0);
                                if (mouse_check_button_pressed(mb_left)) {
                                    var pl = control_pl[l[1]];
                                    if (pl[? 'is_attack'] == -1) pl[? 'is_attack'] = i;
                                }
                            }
                        } else { // ход врага:
                            if (l[1] == i && nmap[? 'is_attack'] == -1) {
                                
                                var is_find = false;
                                for (var j = 0; j < count_player; j++) {
                                    var pl = control_pl[j];
                                    if (pl[? 'hp'] < pl[? 'max_hp']) {
                                        nmap[? 'is_attack'] = j;
                                        is_find = true;
                                        break;
                                    }
                                }
                                if (!is_find) {
                                    var rand = irandom(count_player - 1), pl = control_pl[rand];
                                    nmap[? 'is_attack'] = rand;
                                }
                            }
                        }
                    } else {
                        for (var j = 0, r; j < ds_list_size(stack); j++) {
                            r = stack[| j];
                            if (r[0]) {
                                if (r[1] == battle_count - 1) {
                                    ds_list_delete(stack, j);
                                    j = 0;
                                }
                            }
                        }
                        delete(enemy_list, i);
                        battle_count--;
                    }
                }
                for (var i = 0, nmap, npos; i < count_player; i++) { // союзники:
                    nmap = control_pl[i];
                    npos = pos[i];
                    if (nmap[? 'hp'] > 0) {
                        var xx = 0, yy = 0;
                        if (!ds_list_empty(stack)) {
                            var l = stack[| 0];
                            if (!l[0] && l[1] == i) {
                                if (nmap[? 'is_attack'] != -1) {
                                    var nnpos = pos[nmap[? 'is_attack']];
                                    xx = c_enemy[? 'x'] + nnpos[0];
                                    yy = c_enemy[? 'y'] + nnpos[1];
                                    switch(nmap[? 'is_delta']) {
                                        case false:
                                            if (nmap[? 'delta'] < 1) nmap[? 'delta'] += .2;
                                                else nmap[? 'is_delta'] = true;
                                        break;
                                        case true:
                                            if (nmap[? 'delta'] > 0) nmap[? 'delta'] -= .1;
                                                else {
                                                    var en_r = enemy_list[nmap[? 'is_attack']];
                                                    nmap[? 'is_delta'] = false;
                                                    en_r[? 'hp'] -= nmap[? 'damage'];
                                                    ds_list_add(stack, ds_list_find_value(stack, 0));
                                                    ds_list_delete(stack, 0);
                                                    nmap[? 'is_attack'] = -1;
                                                }
                                        break;
                                    }
                                }
                                draw_rectangle(pl_x - npos[0] - 8, pl_y + npos[1] - 4, pl_x - npos[0] + 8, pl_y + npos[1] + 4, true);
                            }
                        }
                        var m_skin = skin[nmap[? 'skin_id']], body_h = sprite_get_height(m_skin[? 'body']);
                        draw_sprite(m_skin[? 'head'], 0, pl_x - npos[0], pl_y + npos[1] - body_h);
                        draw_sprite(m_skin[? 'body'], 0, pl_x - npos[0], pl_y + npos[1] - body_h);
                        //draw_sprite(nmap[? 'sprite'], 0, pl_x - npos[0] - ((pl_x - npos[0]) - xx) * nmap[? 'delta'], pl_y + npos[1] - ((pl_y + npos[1]) - yy) * nmap[? 'delta']);
                        //draw_text_transformed(pl_x - npos[0] - ((pl_x - npos[0]) - xx) * nmap[? 'delta'], pl_y + npos[1] - sprite_get_height(nmap[? 'sprite']) - 4 - ((pl_y + npos[1]) - yy) * nmap[? 'delta'], nmap[? 'name'] + '[' + string(nmap[? 'hp']) + '/' + string(nmap[? 'max_hp']) + ']', .25, .25, 0)
                    } else {
                        
                        for (var j = 0, r; j < ds_list_size(stack); j++) {
                            r = stack[| j];
                            if (!r[0]) {
                                if (r[1] == count_player - 1) {
                                    ds_list_delete(stack, j);
                                    j = 0;
                                }
                            }
                        }
                        delete(control_pl, i);
                        count_player--;
                    }
                }
                for (var i = 0, l, nmap; i < ds_list_size(stack); i++) {
                    l = stack[| i];
                    switch(l[0]) {
                        case false: // друзья:
                            nmap = control_pl[l[1]];
                            //draw_sprite_stretched(nmap[? 'sprite'], 0, view_xview + 8 + 12 * i, view_yview + view_hview * .8, 8, 8);
                            draw_set_colour($ffffff);
                            draw_text_transformed(view_xview + 8 + 12 * i + 6, view_yview + view_hview * .8 + 10, nmap[? 'name'] + string(l[1]), .1, .1, 0);
                        break;
                        case true: // друзья:
                            nmap = enemy_list[l[1]];
                            //draw_sprite_stretched(nmap[? 'sprite'], 0, view_xview + 8 + 12 * i, view_yview + view_hview * .8, 8, 8);
                            draw_set_colour($ff0000);
                            draw_text_transformed(view_xview + 8 + 12 * i + 6, view_yview + view_hview * .8 + 10, nmap[? 'name'] + string(l[1]), .1, .1, 0);
                        break;
                    }
                }
            } else { // генерация:
                var f_counter = count_player, e_counter = battle_count;
                while(ds_list_size(stack) < (count_player + battle_count - 1)) {
                    for (var i = 0, count = 0; i < ds_list_size(old_stack); i++) { 
                        if (old_stack[| i] == stack_change) {
                            switch(stack_change) {
                                case false: 
                                    count = clamp(count + 1, 0, count_player - 1); break;
                                case true: 
                                    
                                    count = clamp(count + 1, 0, battle_count - 1); 
                                break;
                            }
                        }
                    }
                    ds_list_add(stack, vec(stack_change, count));
                    ds_list_add(old_stack, stack_change);
                    stack_change =! stack_change;
                }
            }
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        } else {
            show_message('вы проиграли!');
            game_restart();
        }
    } else {
        show_message('вы победили!');
        is_battle = false;
        delete(enemy, battle_id);
        count_enemy--;
        battle_id = -1;
        ds_list_clear(stack);
        ds_list_clear(old_stack);
    }
}

if (is_shadow || shadow_alpha > 0) { // затемнение экрана:
    if (surface_exists(surf_shadow)) {
        surface_set_target(surf_shadow);
        draw_clear_alpha(c_black, shadow_alpha);
        
        shadow_alpha = clamp(shadow_alpha - (1 + (-is_shadow * 2)) * .1, 0, 1);
        surface_reset_target();
        draw_surface(surf_shadow, view_xview, view_yview);
    } else surf_shadow = surface_create(view_wview, view_hview);
}

