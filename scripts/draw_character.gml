/// draw_character(map, x, y, dir)
var map = argument0, m_skin = skin[map[? 'skin_id']], body_h = sprite_get_height(m_skin[? 'body']),
    xx = argument1, yy = argument2, dir = argument3;

draw_sprite(m_skin[? 'head'], 0, xx, yy - body_h);
if (map[? 'body'] != -1) { // одеяние:
    var m_body = body[map[? 'body']];
    draw_sprite_ext(m_body[? 'sprite_index'], 0, xx, yy - body_h, dir, 1, 0, c_white, 1);
} else draw_sprite(m_skin[? 'body'], 0, xx, yy - body_h);
if (map[? 'weapon'] != -1) { // оружие:
    var m_weapon = weapon[map[? 'weapon']];
    draw_sprite_ext(m_weapon[? 'sprite_index'], 0, xx + sprite_get_width(m_skin[? 'body']) * .9 * dir, yy - body_h * .5 + sin(current_time * .0035), dir, 1, 0, c_white, 1);

}
// имя персонажа:
draw_set_valign(fa_bottom);
draw_set_halign(fa_center);
draw_set_colour($ffffff);

draw_text_transformed(xx, yy - body_h * 2.75, map[? 'name'] + '[' + string(map[? 'hp']) + '/' + string(map[? 'max_hp']) + ']', .2, .2, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
