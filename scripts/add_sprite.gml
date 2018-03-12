/// add_sprite(background, left, top, width, height, xoffset, yoffset)
var back = argument0, left = argument1, top = argument2, xoffset = argument5, yoffset = argument6,
    width = argument3, height = argument4, surf = surface_create(background_get_width(back), background_get_height(back)), spr;
surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_background(back, 0, 0);
    spr = sprite_create_from_surface(surf, left, top, width, height, 0, 0, xoffset, yoffset);
surface_reset_target();
surface_free(surf);
return spr;
