/// on_damage(me, enemy)

var damage = 1;
switch(argument0) {
    case 'wizard': damage = 5; break;
    case 'warrior': damage = 10; break;
    case 'hunter': damage = 7; break;
}
switch(argument1) {
    case 'wizard': damage += 2; break;
    case 'warrior': damage -= 2; break;
    case 'hunter': damage -= 1; break;
}
return damage;
