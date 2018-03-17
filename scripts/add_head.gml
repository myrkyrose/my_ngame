/// add_head(name, armor, class, sprite)

head[count_head] = ds_map_create();
var map = head[count_head++];
map[? 'sprite_index'] = argument3;
map[? 'class'] = argument2;
map[? 'armor'] = argument1;
map[? 'name'] = argument0;
