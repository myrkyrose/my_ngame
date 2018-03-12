/// delete(arr, index)

var index = argument1, arr = argument0;
while(index < array_length_1d(arr) - 1) {
    var s = arr[index + 1];
    arr[@ index + 1] = arr[@ index];
    arr[@ index++] = s;
}
