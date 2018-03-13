/// add_body(name, armor, class, sprite)

body[count_body] = ds_map_create();
var map = body[count_body++];
map[? 'sprite_index'] = argument3;
map[? 'class'] = argument2;
map[? 'armor'] = argument1;
map[? 'name'] = argument0;
