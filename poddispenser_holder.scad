use <poddispenser_common.scad>


module poddispenser_holder (radius=60, height=120) {
    for (angle=[0,60,120,180,240,300]) {
        rotate([0,0,angle]) 
        translate([0,-52,0]) linear_extrude(height=height) 
        difference() {
            capsule_cutout_outer();
            capsule_cutout();
        }    
    }
    difference() {
        cylinder($fn=30, r=6, h=height);
        translate([0,0,-1]) cylinder($fn=20,r=4,h=height+2);
    }
//     difference() {
//        cylinder($fn=100,r=radius+2,h=height);
//        translate([0,0,-1]) cylinder($fn=100,r=radius,h=height+2);
//     }   
}

poddispenser_holder();