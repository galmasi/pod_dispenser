include <poddispenser_common.scad>

module poddispenser_blockplate () {
   difference() {
        union() {
            // base plate
            cylinder($fn=100,r=g_dispenser_radius+g_wallthickness,h=g_wallthickness);
            // bearing holder
            bearingholder_plus();
        }
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=8, h=2*g_bearingheight);
            // bearing seat
            bearingholder_minus();
            // capsule cutout
            translate([0,-52,-0.01]) 
                    linear_extrude(height=10)
                        capsule_cutout_widebrim();
        }
    }
    rimmedwall(g_bearingheight);
}

poddispenser_blockplate();
