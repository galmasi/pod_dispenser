use <parametric_involute_gear_v5.0.scad>

gearthick=3;
hubthick=5;

// diameter = teet * pitch / 180 = 25
translate([10, 0, 0])
difference() {
    gear (number_of_teeth = 20,
          circular_pitch = 180,
          gear_thickness  = gearthick,
          rim_thickness   = gearthick,
          hub_thickness   = hubthick,
          bore_diameter   = 1,
          twist=0,
          circles         = 0);
    intersection() {
      cylinder($fn=30,h=3*hubthick,r=2.5,center=true);
      cube([5,3,hubthick*3],center=true);
    }
}

// diameter = 200
translate([0, 0, 10])
gear (number_of_teeth=200,
      circular_pitch=180,
      gear_thickness  = gearthick,
          rim_thickness   = gearthick,
          hub_thickness   = hubthick,
          bore_diameter   = 1,
          twist=0,
          circles         = 0);
  