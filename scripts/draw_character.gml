/// draw_character(map, x, y, dir, id)
var map = argument0, m_skin = skin[map[? 'skin_id']], body_h = sprite_get_height(m_skin[? 'body']),
    xx = argument1, yy = argument2, dir = argument3, _id = argument4;

draw_sprite_ext(m_skin[? 'head'], 0, xx, yy - body_h, dir, 1, 0, c_white, 1);
if (map[? 'body'] != -1) { // одеяние:
    var m_body = body[map[? 'body']];
    draw_sprite_ext(m_body[? 'sprite_index'], 0, xx, yy - body_h, dir, 1, 0, c_white, 1);
} else draw_sprite_ext(m_skin[? 'body'], 0, xx, yy - body_h, dir, 1, 0, c_white, 1);
if (map[? 'head'] != -1) { // головной убор:
    var m_head = head[map[? 'head']];
    draw_sprite_ext(m_head[? 'sprite_index'], 0, xx, yy - body_h - sprite_get_height(m_skin[? 'head']) * .5, dir, 1, 0, c_white, 1);
}
if (map[? 'weapon'] != -1) { // оружие:
    var m_weapon = weapon[map[? 'weapon']];
    draw_sprite_ext(m_weapon[? 'sprite_index'], 0, xx + sprite_get_width(m_skin[? 'body']) * .9 * dir, yy - body_h * .5 + sin(current_time * .0035), dir, 1, 0, c_white, 1);
}
    //if (point_in_rectangle(mouse_x, mouse_y, xx - sprite_get_width(m_skin[? 'body']) * .5, yy - body_h - sprite_get_height(m_skin[? 'head']), xx + sprite_get_width(m_skin[? 'body']) * .5, yy)) {
        //hover_id = true;
        //cursor |= cursors.hover;
        draw_sprite_ext(spr_health, 0, xx, yy - body_h - sprite_get_height(m_skin[? 'head']) - 4, 1, 1, 0, c_white, 1);
        //draw_set_alpha(hover_alpha);
        draw_set_colour($ffffff);
        draw_set_valign(fa_center);
        draw_text_transformed(xx + 8, yy - body_h - sprite_get_height(m_skin[? 'head']) - 4, floor(map[? 'old_hp']), .25, .25, 0);
        draw_set_valign(fa_top);
        map[? 'old_hp'] -= (map[? 'old_hp'] - map[? 'hp']) * .2;
        //draw_set_alpha(1);
    //}


// имя персонажа:
/*draw_set_valign(fa_bottom);
draw_set_halign(fa_center);
draw_set_colour($ffffff);

draw_text_transformed(xx, yy - body_h * 2.75, map[? 'name'] + '[' + string(map[? 'hp']) + '/' + string(map[? 'max_hp']) + ']', .2, .2, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);*/
