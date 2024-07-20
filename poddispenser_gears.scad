use <poddispenser_common.scad>
use <parametric_involute_gear_v5.0.scad>

// large gear, glued to ejector
translate([51,0,0]) {
    gear (number_of_teeth = 84,
          circular_pitch = 180,
          gear_thickness  = 4,
          rim_thickness   = 4,
          hub_thickness   = 4,
          bore_diameter   = 28,
          twist=0,
          circles         = 0);
    difference() {
        translate([0,0,3.5])
            cylinder($fn=50, r=15, h=1);
        cylinder($fn=50, r=14, h=30);
    }
}

/*
// small gear, attached to motor
gearthick=3;
hubthick=5;

difference() {
    gear (number_of_teeth = 12,
          circular_pitch = 180,
          gear_thickness  = 2,
          rim_thickness   = 5,
          hub_thickness   = 2,
          bore_diameter   = 1,
          twist=0,
          circles         = 0);
    intersection() {
      cylinder($fn=30,h=3*hubthick,r=2.5,center=true);
      cube([5,3,hubthick*3],center=true);
    }
}
*/