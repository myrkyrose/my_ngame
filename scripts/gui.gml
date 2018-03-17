/// gui()
var l_window = vec(ui.none, ui.window, ui.message, ui.error, ui.dialog);
for (var i = 0; i < array_length_1d(l_window); i++) {
    if (ui_state & l_window[i]) {
        switch(l_window[i]) {
            case ui.none:
                for (var j = 0, size = 32, xx = 10, yy = window_get_height() - xx - size; j < 2; j++) {
                    if (add_ui_button(j, xx + (size + xx) * j, yy, size, size) == -1) {
                        switch(j) {
                            case 0:
                                ui_state |= ui.window;
                                window_id = windows.inv; 
                            break;
                            case 1:
                                ui_state |= ui.window;
                                window_id = windows.quest;
                            break;
                        }
                    }
                }
            break;
            case ui.window:
                if (!add_ui_window(replace(window_id, 'Inventory', 'Quests'))) {
                    switch(window_id) {
                        case windows.inv:
                        
                        break;
                        case windows.quest:
                        
                        break;
                    }    
                } else ui_state &=~ ui.window;
            break;
        }
    }
}
