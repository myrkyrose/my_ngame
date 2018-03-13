/// init()

key = 0;
cursor = 0;
enum keys {
    up = 1,
    down = 2,
    left = 4,
    right = 8
};
enum cursors {
    hover = 1,
    pointer = 2
};

attack_id = -1;
attack_delta = 0;
attack_isdelta = false;
attack_enemy = false;

randomize();

names = vec('Donald', 'Robert', 'Jeck', 'Kevin');
class = vec('hunter', 'warrior', 'wizard');

count_body = 0;
count_skin = 0;
// броня:
add_body('Frog Armor', 2, add_sprite(textFaces, 0, 9, 10, 8, 5, 0));
add_body('Pig Armor', 5, add_sprite(textFaces, 10, 9, 10, 8, 5, 0));
// рассы:
add_skin('Frog', 50, add_sprite(textFaces, 0, 0, 12, 9, 6, 9), add_sprite(textFaces, 0, 9, 10, 8, 5, 0));
add_skin('Pig', 75, add_sprite(textFaces, 12, 0, 16, 9, 8, 9), add_sprite(textFaces, 10, 9, 10, 8, 5, 0));
add_skin('People', 20, add_sprite(textFaces, 28, 0, 12, 11, 6, 11), add_sprite(textFaces, 20, 9, 10, 8, 5, 0));
is_battle = false;
battle_id = -1;
battle_count = 0;
stack = ds_list_create();
old_stack = ds_list_create();
stack_change = 0;
count_enemy = 0;
count_player = 5;
for (var i = 0; i < count_player; i++) control_pl[i] = add_character(irandom(count_skin - 1), names[irandom(array_length_1d(names) - 1)], class[irandom(array_length_1d(class) - 1)]);
pl_x = 50;
pl_y = 50;
pl_sprite = add_sprite(textDefault, 0, 0, 16, 22, 8, 20);
var map = ds_map_create();
map[? 'max_hp'] = 100;
map[? 'hp'] = map[? 'max_hp'];
map[? 'damage'] = 1;
map[? 'name'] = 'player';
map[? 'sprite'] = add_sprite(textDefault, 0, 0, 16, 22, 8, 20);
map[? 'special'] = vec('fire', 'water');

var list;
for (var i = 0; i < 3; i++) {
    list[i] = add_character(irandom(count_skin - 1), names[irandom(array_length_1d(names) - 1)], class[irandom(array_length_1d(class) - 1)]);//ds_map_create();
    //ds_map_copy(list[i], rand[irandom(array_length_1d(rand) - 1)]);
}

add_enemy(add_sprite(textDefault, 0, 0, 16, 22, 8, 20), 100, 100, list);
/*var nlist;
var rand = vec(add_character(spr[0], names[irandom(array_length_1d(names) - 1)], 20, 10, 'hunter'),
               add_character(spr[1] , names[irandom(array_length_1d(names) - 1)], 40, 8, 'warrior'),
               add_character(spr[2] , names[irandom(array_length_1d(names) - 1)], 15, 5, 'wizard')
);
for (var i = 0; i < 4; i++) {
   nlist[i] = ds_map_create();
    ds_map_copy(nlist[i], rand[irandom(array_length_1d(rand) - 1)]);
}
add_enemy(add_sprite(textDefault, 0, 0, 16, 22, 8, 20), -20, 100, nlist);
*/
is_shadow = false;
shadow_alpha = 0;
surf_shadow = surface_create(view_wview, view_hview);

is_pause = false;
