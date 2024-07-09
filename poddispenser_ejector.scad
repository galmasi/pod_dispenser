use <poddispenser_common.scad>

// allows capsules to slide out sideways if permitted by release
// radius is the inner diameter of the pod dispenser's wall (the ejector can't reach that far)

module poddispenser_ejector(radius=60,height=35) {
    m = [[ 1, 0, 0, 0],
         [ 0, 1, -0.5, 0],
         [ 0, 0, 1, 0],
         [ 0, 0, 0, 1]];
    difference() {
        intersection() {
            union() {
                cylinder($fn=30,h=height,r=7);
                for (angle=[0,60,120,180,240,300]) {
                    rotate([0,0,angle]) translate([0,-52,0]) multmatrix(m) 
                    linear_extrude(height=height) 
                        capsule_outline_open();
                }
            }
            cylinder($fn=100, r=radius-2, h=height-4);
        }
        union() {
            // the top screwhole is an 8mm rod, or close enough
            translate([0,0,-1]) cylinder($fn=30,h=height/2,r=4);
            // the bottom axle hole is a 5mm cylinder flattened to 3mm on the side
            translate([0,0,height*0.66])
            intersection() {
                 cylinder($fn=30,h=height,r=2.5);
                cube([5,3,20],center=true);
            }
        }
    }
}

translate([0,0,30]) 
rotate([180,0,0]) poddispenser_ejector();