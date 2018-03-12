/// update()
key = 0;
cursor = 0;
var listkeys = vec(ord('D'), ord('A'), ord('S'), ord('W')), listpress = vec(keys.right, keys.left, keys.down, keys.up);
for (var i = 0; i < array_length_1d(listkeys); i++) {
    if (keyboard_check(listkeys[i])) key |= listpress[i];
}

draw();


var listcursor = vec(cr_handpoint), listcr = vec(cursors.hover), active = false;
for (var i = 0; i < array_length_1d(listcursor); i++) {
    if (cursor & listcr[i]) {
        window_set_cursor(listcursor[i]);
        active = true;
    }
}
if (!active) window_set_cursor(cr_default);

if (keyboard_check_pressed(ord('R'))) game_restart();
