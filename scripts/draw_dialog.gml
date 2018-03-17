///draw_dialog()

var width = 64, height = 24;
for (var i = 0, map; i < count_dialog; i++) {
    map = dialog[i];
   // , str = string_copy(map[? 'str'], 0, map[? 'pos']), h = string_height_ext(str, -1, width - 4) / font_get_size(fnt);
    //if (h > height) height = h + 4;
    for (var j = 0; j < 2; j++) {
        draw_background_part(textDialog, 16 * j, 0, 8, 8, map[? 'x'] - width * .5 + (width - 8) * j, map[? 'y'] - height);
        draw_background_part(textDialog, 16 * j, 16, 8, 8, map[? 'x'] - width * .5 + (width - 8) * j, map[? 'y'] - 8);
        draw_background_part_ext(textDialog, 8, 16 * j, 8, 8, map[? 'x'] - width * .5 + 8, map[? 'y'] - height + (height - 8) * j, (width - 16) / 8, 1, c_white, 1);
        draw_background_part_ext(textDialog, 16 * j, 8, 8, 8, map[? 'x'] - width * .5 + (width - 8) * j, map[? 'y'] - height + 8,1, (height - 16) / 8, c_white, 1);
    }
    draw_background_part_ext(textDialog, 8, 8, 8, 8, map[? 'x'] - width * .5 + 8, map[? 'y'] - height + 8, (width - 16) / 8, (height - 16) / 8, c_white, 1);
    draw_background_part_ext(textDialog, 24, 0, 8, 5, map[? 'x'] + width * .5 - 8, map[? 'y'] + 2 + sin(current_time * .002), 1, 1, c_white, 1);
    //draw_set_colour($000000);
    
    //draw_text_ext_transformed(map[? 'x'] + 2 - width * .5, map[? 'y'] + 2 - height, str, -1, width * font_get_size(fnt) / 2 - 4, .25, .25, 0);
    //if (map[? 'pos'] < string_length(map[? 'str'])) map[? 'pos'] += .25;
}
