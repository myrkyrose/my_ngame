/// init()

randomize();

window_id = 0;
key = 0;
mouse = 0;
enum keys {
    up = 1,
    down = 2,
    left = 4,
    right = 8
};
enum ui {
    none = 1,
    window = 2,
    message = 4,
    error = 8,
    dialog = 16
};
ui_state = ui.none;
enum windows {
    inv = 1,
    quest = 2,
    trade = 3
};
enum mouse_event {
    hover = 1,
    lclick = 2,
    rclick = 4
};

attack_id = -1;
attack_delta = 0;
attack_isdelta = false;
attack_enemy = false;

spr_slot = add_sprite(textGui, 0, 0, 16, 16, 0, 0);
spr_health = add_sprite(textGui, 16, 0, 7, 6, 4.5, 3);



names = vec('Donald', 'Robert', 'Jeck', 'Kevin');
class = vec('hunter', 'warrior', 'wizard');

count_body = 0;
count_skin = 0;
count_weapon = 0;
count_enemy = 0;
count_player = 5;
count_head = 0;

// броня:
add_body('Iron Armor', 2, 0, add_sprite(textBody, 0, 0, 14, 9, 7, 1));
add_body('Hunter Armor', 1, 1, add_sprite(textBody, 14, 0, 11, 8, 6, 0));
add_body('Wizard Mantia', 1, 2, add_sprite(textBody, 25, 0, 12, 8, 6, 0));
add_body('Wizard Armor', 2, 2, add_sprite(textBody, 0, 9, 13, 8, 13 / 2 + 2, 0));
add_body('Silver Armor', 3, 1, add_sprite(textBody, 0, 17, 16, 12, 8, 1));
add_body('Dragon Armor', 5, 2, add_sprite(textBody, 16, 8, 28, 11, 14, 3));
// шлем:
add_head('Iron Helmet', 1, 0, add_sprite(textHead, 0, 0, 10, 8, 5, 8));
// оружие:
add_weapon('Wizard Trof', 2, 2, add_sprite(textWeapon, 0, 0, 8, 15, 4, 15));
add_weapon('Advance Wizard Trof', 3, 2, add_sprite(textWeapon, 8, 0, 8, 15, 4, 15));
add_weapon('Prof Wizard Trof', 5, 2, add_sprite(textWeapon, 16, 0, 8, 15, 4, 15));
// рассы:
add_skin('Frog', 15, add_sprite(textFaces, 0, 0, 12, 9, 6, 9), add_sprite(textFaces, 0, 9, 10, 8, 5, 0));
add_skin('Pig', 20, add_sprite(textFaces, 12, 0, 16, 9, 8, 9), add_sprite(textFaces, 10, 9, 10, 8, 5, 0));
//add_skin('People', 20, add_sprite(textFaces, 28, 0, 12, 11, 6, 11), add_sprite(textFaces, 20, 9, 10, 8, 5, 0));
//add_skin('Shadow', 10, add_sprite(textFaces, 40, 0, 14, 11, 7, 11), add_sprite(textFaces, 20, 9, 10, 8, 5, 0));

is_battle = false;
battle_id = -1;
stack = ds_list_create();

for (var i = 0; i < count_player; i++) control_pl[i] = add_character(irandom(count_skin - 1), names[irandom(array_length_1d(names) - 1)], class[irandom(array_length_1d(class) - 1)]);
pl_x = 50;
pl_y = 50;
pl_sprite = add_sprite(textFaces, 0, 0, 12, 9, 6, 9);

var list;
for (var i = 0; i < 3; i++) list[i] = add_character(irandom(count_skin - 1), names[irandom(array_length_1d(names) - 1)], class[irandom(array_length_1d(class) - 1)]);
add_enemy(add_sprite(textFaces, 0, 0, 12, 9, 6, 9), 150, 100, list);
list = 0;
for (var i = 0; i < 3; i++) list[i] = add_character(irandom(count_skin - 1), names[irandom(array_length_1d(names) - 1)], class[irandom(array_length_1d(class) - 1)]);
add_enemy(add_sprite(textFaces, 0, 0, 12, 9, 6, 9), 50, 100, list);

is_shadow = false;
shadow_alpha = 0;
surf_shadow = surface_create(view_wview, view_hview);

is_pause = false;
