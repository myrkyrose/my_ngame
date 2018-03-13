/// draw()
is_pause = is_shadow;
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
                        var xx = 0, yy = 0, current = false;
                        if (attack_id != -1 && attack_enemy && l[1] == i) {
                            var nnpos = pos[attack_id];
                            current = true;
                            xx = pl_x - nnpos[0];
                            yy = pl_y + nnpos[1];
                            switch(attack_isdelta) {
                                case false:
                                    if (attack_delta < 1) attack_delta += .2;
                                        else attack_isdelta = true;
                                break;
                                case true:
                                    if (attack_delta > 0) attack_delta -= .1;
                                        else {
                                            var other_enemy = control_pl[attack_id], damage = nmap[? 'damage'];
                                            if (nmap[? 'weapon'] != -1) damage = ds_map_find_value(weapon[nmap[? 'weapon']], 'damage');
                                            if (other_enemy[? 'body'] != -1) {
                                                var other_body = body[other_enemy[? 'body']];
                                                damage -= other_body[? 'armor'];
                                            }
                                            other_enemy[? 'hp'] -= clamp(damage, 0, 999);
                                            attack_id = -1;
                                            attack_isdelta = false;
                                            ds_list_add(stack, ds_list_find_value(stack, 0));
                                            ds_list_delete(stack, 0);
                                            l[1] = -1;
                                        }
                                break;
                            }
                        }
                        draw_character(nmap, c_enemy[? 'x'] + npos[0] + (xx - (c_enemy[? 'x'] + npos[0])) * attack_delta * current, c_enemy[? 'y'] + npos[1] + (yy - (c_enemy[? 'y'] + npos[1])) * attack_delta * current, -1);
                        if (!l[0]) { // ход игрока:
                            if (point_in_rectangle(mouse_x, mouse_y, c_enemy[? 'x'] + npos[0] - 8, c_enemy[? 'y'] + npos[1] - 4, c_enemy[? 'x'] + npos[0] + 8, c_enemy[? 'y'] + npos[1] + 4) && attack_id == -1) {
                                cursor |= cursors.hover;
                                var nnmap = control_pl[l[1]], damage = nnmap[? 'damage'];
                                if (nnmap[? 'weapon'] != -1) damage = ds_map_find_value(weapon[nnmap[? 'weapon']], 'damage');
                                draw_text_transformed(mouse_x + 4, mouse_y + 1, '-' + string(damage), .25, .25, 0);
                                if (mouse_check_button_released(mb_left)) {
                                    attack_id = i;
                                    attack_enemy = false;
                                }
                            }
                        } else { // ход врага:
                            if (l[1] == i && attack_id == -1) {
                                var is_find = false;
                                for (var j = 0; j < count_player; j++) {
                                    var pl = control_pl[j];
                                    if (pl[? 'hp'] < pl[? 'max_hp']) {
                                        attack_id = j;
                                        is_find = true;
                                        break;
                                    }
                                }
                                if (!is_find) attack_id = irandom(count_player - 1);
                                attack_enemy = true;
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
                        var xx = 0, yy = 0, current = false;
                        if (!ds_list_empty(stack)) {
                            var l = stack[| 0];
                            if (!l[0] && l[1] == i) {
                                if (attack_id != -1 && !attack_enemy) {
                                    var nnpos = pos[attack_id];
                                    current = true;
                                    xx = c_enemy[? 'x'] + nnpos[0];
                                    yy = c_enemy[? 'y'] + nnpos[1];
                                    switch(attack_isdelta) {
                                        case false:
                                            if (attack_delta < 1) attack_delta += .2;
                                                else attack_isdelta = true;
                                        break;
                                        case true:
                                            if (attack_delta > 0) attack_delta -= .1;
                                                else {
                                                    var other_enemy = enemy_list[attack_id], damage = nmap[? 'damage'];
                                                    if (nmap[? 'weapon'] != -1) damage = ds_map_find_value(weapon[nmap[? 'weapon']], 'damage');
                                                    if (other_enemy[? 'body'] != -1) {
                                                        var other_body = body[other_enemy[? 'body']];
                                                        damage -= other_body[? 'armor'];
                                                    }
                                                    other_enemy[? 'hp'] -= clamp(damage, 0, 999);
                                                    attack_id = -1;
                                                    attack_isdelta = false;
                                                    ds_list_add(stack, ds_list_find_value(stack, 0));
                                                    ds_list_delete(stack, 0);
                                                }
                                        break;
                                    }
                                }
                                draw_rectangle(pl_x - npos[0] - 8, pl_y + npos[1] - 4, pl_x - npos[0] + 8, pl_y + npos[1] + 4, true);
                            }
                        }
                        draw_character(nmap, pl_x - npos[0] + (xx - (pl_x - npos[0])) * attack_delta * current, pl_y + npos[1] + (yy - (pl_y + npos[1])) * attack_delta * current, 1);
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
                var xx = view_xview + view_wview * .5 - 1.5 * 12, spr = vec(sprStep_friend, sprStep_enemy);
                for (var i = 0, l, nmap, pos = vec(ds_list_size(stack) - 1, 0, clamp(1, 0, ds_list_size(stack) - 1)); i < 3; i++) { // итог хода:
                    l = stack[| pos[i]];
                    switch(l[0]) {
                        case false: nmap = control_pl[l[1]]; break;
                        case true: nmap = enemy_list[l[1]]; break;
                    }
                    var m_skin = skin[nmap[? 'skin_id']];
                    draw_sprite_stretched_ext(spr[l[0]], 0, xx + 12 * i - 1, view_yview + 16 - 1, 10, 10, c_white, 1 - !i * .75);
                    draw_sprite_stretched_ext(m_skin[? 'head'], 0, xx + 12 * i, view_yview + 16, 8, 8, c_white, 1 - !i * .75);
                }
            } else { // генерация:
                var f_counter = count_player, e_counter = battle_count;
                while(ds_list_size(stack) < (count_player + battle_count)) {
                    switch(stack_change) {
                        case false:
                            if (f_counter != 0)
                            ds_list_add(stack, vec(stack_change, count_player - f_counter--));
                        break;
                        case true:
                            if (e_counter != 0)
                            ds_list_add(stack, vec(stack_change, battle_count - e_counter--));
                        break;
                    }
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

