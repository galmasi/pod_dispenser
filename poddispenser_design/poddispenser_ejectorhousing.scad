include <poddispenser_common.scad>

// ********************************************
// pod dispenser ejector pod assembly
// ********************************************

module poddispenser_ejectorhousing (wallheight=40, radius=g_dispenser_radius) {
    adapterheight=10;
    difference() {
        union() {
            // foot
            difference() {
                cylinder($fn=100,r2=radius+g_wallthickness,r1=radius+20,h=adapterheight);
                translate([0,0,-0.001]) cylinder($fn=100, r2=radius, r1=radius+18, h=adapterheight-4);
            }
            //  wall on top + rim
            translate([0,0,adapterheight]) rimmedwall(wallheight=wallheight);

            // support structure for foot
            for (x=[g_bearingdia/2+g_wallthickness+2+0.1, 30,45,60,75])
            intersection() {
                difference()  {
                    cylinder($fn=40, r=x, h=adapterheight);
                    translate([0,0,-0.001]) cylinder($fn=40, r=x-2, h=adapterheight+0.01);
                }
                cylinder($fn=100,r2=radius+g_wallthickness,r1=radius+20,h=adapterheight);
            }
            
            // holds the bearing
            translate([0,0,0]) bearingholder_plus();
            // surrounds the gear hole
            translate([44.5,18.5,0]) cylinder($fn=50,r=12, h=adapterheight);
        }
        union() {
            //capsule exit
            translate([-radius, 0, adapterheight+21.001]) cube([40,40,42], center=true);
            // exit ramp
            translate([-radius, 0, adapterheight+18]) rotate([0,-10,0]) cube([40,40,42], center=true);
            // bearing seat
            translate([0,0,adaptorheight-g_bearingheight]) bearingholder_minus();
	        // central axle hole
            cylinder($fn=30,r=8,h=50);
            // gear hole
            translate([44.5,18.5,-0.01]) cylinder($fn=50,r=10, h=80);
        }
    }
}

poddispenser_ejectorhousing();