include <poddispenser_common.scad>

module poddispenser_topstabilizer () {
    difference() {
        // bearing holder
        bearingholder_plus();
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=8, h=2*g_bearingheight);
            // bearing
            bearingholder_minus();
        }
    }
    // spokes
    for (angle=[0,60,120,180,240,300])
        rotate([0,0,angle])
            translate([g_dispenser_radius/2+g_bearingdia/4+0.1,0,g_bearingheight/2]) 
                cube([g_dispenser_radius-g_bearingdia/2,3,g_bearingheight], center=true);
    rimmedwall(g_bearingheight);
}

poddispenser_topstabilizer();
