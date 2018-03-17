/// add_ui_window(title)

var xx = 0, yy = 0, width = window_get_width(), height = window_get_height(), title = argument0;

draw_set_colour($ff0000);
draw_rectangle(xx, yy, xx + width, yy + 24, false);
draw_set_colour($ffffff);
draw_rectangle(xx, yy + 24, xx + width, yy + height, false);
draw_set_colour($f00fff);
draw_rectangle(xx + width - 24, yy, xx + width - 8, yy + 16, false);
draw_set_colour($000000);
draw_text(xx + 8, yy + 32, title);
if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xx + width - 24, yy, xx + width - 8, yy + 16)) {
    if (mouse & mouse_event.lclick) {
        return true;
        mouse &=~ mouse_event.lclick;
    }
}


return false;
