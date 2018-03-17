/// update()
key = 0;
mouse = 0;
var listkeys = vec(ord('D'), ord('A'), ord('S'), ord('W')), listpress = vec(keys.right, keys.left, keys.down, keys.up);
for (var i = 0; i < array_length_1d(listkeys); i++) {
    if (keyboard_check(listkeys[i])) key |= listpress[i];
}
draw();
if (mouse_check_button_pressed(mb_left)) mouse |= mouse_event.lclick;
if (mouse_check_button_pressed(mb_right)) mouse |= mouse_event.rclick;
/*var listcursor = vec(cr_handpoint), listcr = vec(cursors.hover), active = false;
for (var i = 0; i < array_length_1d(listcursor); i++) {
    if (cursor & listcr[i]) {
        window_set_cursor(listcursor[i]);
        active = true;
    }
}
if (!active) window_set_cursor(cr_default);*/

if (keyboard_check_pressed(ord('R'))) game_restart();

//hover_alpha = clamp(hover_alpha + (hover_id - 2 * !hover_id) * .1, 0, 1);
//damage_alpha = clamp(damage_alpha + (is_damage - 2 * !is_damage) * .1, 0, 1);
