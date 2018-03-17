/// add_ui_healthbar(x, y, hp, max_hp, zoom = 1)
var xx = argument[0], yy = argument[1], hp = argument[2], mhp = argument[3], zoom = 1, surf = surface_create(sprite_get_width(spr_health) * 3, sprite_get_height(spr_health)),
    n_surf = surface_create(max(hp / mhp * surface_get_width(surf), 1), surface_get_height(surf));
if (argument_count > 4) zoom = argument[4];
if (surface_exists(surf)) {
    surface_set_target(surf);
    draw_sprite_tiled_ext(spr_health, 0, 0, 0, 1, 1, make_colour_rgb(25, 25, 25), 1);
    surface_reset_target();
    draw_surface_ext(surf, xx, yy, zoom, zoom, 0, c_white, 1);
    if (surface_exists(n_surf) && hp > 0) {
        surface_set_target(n_surf);
        draw_sprite_tiled(spr_health, 0, 0, 0);
        surface_reset_target();
        draw_surface_ext(n_surf, xx, yy, zoom, zoom, 0, c_white, 1);
    }
}
