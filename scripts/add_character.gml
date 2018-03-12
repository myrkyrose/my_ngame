/// add_character(skin, name, class)


var map = ds_map_create();
map[? 'skin_id'] = argument0;
map[? 'max_hp'] = ds_map_find_value(skin[map[? 'skin_id']], 'hp');
map[? 'hp'] = map[? 'max_hp'];
map[? 'name'] = argument1;
map[? 'class_id'] = argument2;
map[? 'head'] = -1;
map[? 'body'] = -1;
map[? 'weapon'] = -1;
return map;

/*
/// add_character(sprite, name, hp, damage, class)


var map = ds_map_create();
map[? 'sprite'] = argument0;
map[? 'name'] = argument1;
map[? 'max_hp'] = argument2;
map[? 'hp'] = map[? 'max_hp'];
map[? 'damage'] = argument3;
map[? 'class'] = argument4;
map[? 'is_attack'] = -1;
map[? 'delta'] = 0;
map[? 'is_delta'] = false;
return map;
