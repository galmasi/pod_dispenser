use <poddispenser_common.scad>
use <parametric_involute_gear_v5.0.scad>

// allows capsules to slide out sideways if permitted by release
// radius is the inner diameter of the pod dispenser's wall (the ejector can't reach that far)

module screw_cone_plus() {
    cylinder($fn=40,r1=17,r2=10,h=9);
}

module screw_cone_minus() {
    cylinder($fn=40,r1=15,r2=8,h=7);
}

module poddispenser_ejector(radius=60,height=31) {
    m = [[ 1, 0, 0, 0],
         [ 0, 1, 0, 0],
         [ 0, 0, 1, 0],
         [ 0, 0, 0, 1]];
    intersection() {
        difference() {
            union() {
                // support for screw 
                screw_cone_plus();
                // support for bottom screw
                translate([0,0,height]) rotate([180,0,0]) screw_cone_plus();
                // support for axle
                cylinder($fn=30,h=height,r=7);
                // ejector assembly
                for (angle=[0,60,120,180,240,300]) {
                    rotate([0,0,angle]) {
                        translate([0,-52,0]) multmatrix(m) 
                            linear_extrude(height=height, scale=[1,0.5]) 
                                capsule_outline_open();
                        translate([0,0,height/2]) cube([2,33,height], center=true);
                    }
                }
            }
            union() {
                // axle hole
                translate([0,0,-1]) cylinder($fn=30,h=height*2,r=3.8);
                // space for top screw
                translate([0,0,-0.01]) screw_cone_minus();
                // space for bottom screw
                translate([0,0,height+0.01]) rotate([180,0,0]) screw_cone_minus();
            }
        }
        // cutoff cylinder
        cylinder($fn=100, r=radius-2, h=height);
    }
}

translate([0,0,31]) 
rotate([180,0,0]) poddispenser_ejector(height=31);



