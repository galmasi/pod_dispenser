use <poddispenser_common.scad>


module poddispenser_holder (wallheight=40) {
    difference() {
        union() {
            // six holding channels
            for (angle=[0,60,120,180,240,300]) {
                rotate([0,0,angle]) 
                    translate([0,-52,0])
                        linear_extrude(height=wallheight) 
                            difference() {
                                capsule_cutout_outer();
                                capsule_cutout();
                            }
            }
            // axle 
            cylinder($fn=30, r=6, h=wallheight);
            screw_cone_plus();
        }
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=4,h=wallheight+2);
            screw_cone_minus();
        }
    }
}

poddispenser_holder();