/// add_ui_button(text, x, y, width, height, closed[false])

for (var i = 0, arg, action = 0; i < argument_count; i++) arg[i] = argument[i];
if (argument_count < 6) arg[5] = false;
var is_hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), arg[1], arg[2], arg[1] + arg[3], arg[2] + arg[4]);
if (is_hover) {
    action = sign((mouse & mouse_event.rclick) - (mouse & mouse_event.lclick));
    switch(action) {
        case -1: mouse &=~ mouse_event.lclick; break;
        case 1: mouse &=~ mouse_event.rclick; break;
    }
}
draw_set_colour($ff00ff * is_hover + $00ffff * !is_hover);
draw_rectangle(arg[1], arg[2], arg[1] + arg[3], arg[2] + arg[4], false);
draw_set_colour($000000);
draw_set_valign(fa_center);
draw_set_halign(fa_center);
draw_text(arg[1] + arg[3] * .5, arg[2] + arg[4] * .5, arg[0]);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

return action;
