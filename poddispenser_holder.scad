use <poddispenser_common.scad>


module poddispenser_holder (radius=60, wallthickness=2, wallheight=120) {
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
        }
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=4,h=wallheight+2);
            translate([0,0,wallheight-14.999]) cylinder($fn=20,r=15,h=20);
        }
    }
}

poddispenser_holder();