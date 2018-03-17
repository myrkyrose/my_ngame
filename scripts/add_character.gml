/// add_character(skin, name, class)

var map = ds_map_create();
map[? 'skin_id'] = argument0;
map[? 'max_hp'] = ds_map_find_value(skin[map[? 'skin_id']], 'hp');
map[? 'damage'] = 1;
map[? 'hp'] = map[? 'max_hp'];
map[? 'old_hp'] = map[? 'hp'];
map[? 'name'] = argument1;
map[? 'class_id'] = argument2;
map[? 'head'] = irandom(count_head) - 1;
map[? 'body'] = irandom(count_body) - 1;
map[? 'weapon'] = irandom(count_weapon) - 1;
map[? 'active'] = true;
map[? 'level'] = 1;
map[? 'xp'] = 0;
map[? 'skill'] = vec(-1, -1, -1);
return map;
