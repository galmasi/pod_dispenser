include <poddispenser_common.scad>
// radius is the inner radius (less the thickness of the wall)


// ********************************************
// represents the motor itself
// ********************************************

module vm401_motor () {
    // motor cylinder
    translate([g_motoroffset,0,0]) cylinder($fn=30,r=g_motordia/2+0.5,h=g_motorheight+0.02);
    // motor cutout
    translate([g_motoroffset+g_motordia/2,0,g_motorheight/2+0.01]) cube([10,16,g_motorheight+0.02],center=true);
    translate([g_motoroffset+g_motordia/2-2,0,g_motorheight/2+0.01]) cube([4,19,g_motorheight+0.02],center=true);
    // wire guide
    translate([g_motoroffset+g_motordia/2,0,g_motorheight/2+0.01]) cube([20, 6, g_motorheight+0.02], center=true);
    // motor screw flaps
    translate([g_motoroffset,0,g_motorheight-g_motorflapdepth/2+0.02]) cube([8,42,g_motorflapdepth], center=true);
}

// ********************************************
// pod dispenser base
// ********************************************


module poddispenser_ejectorhousing (wallheight=40, radius=g_dispenser_radius) {
    difference() {
        union() {
            // foot
            difference() {
                cylinder($fn=100,r2=radius+g_wallthickness,r1=radius+20,h=g_motorheight);
                translate([0,0,-0.001]) cylinder($fn=100, r2=radius, r1=radius+18, h=g_motorheight-4);
            }
            //  wall on top + rim
            translate([0,0,g_motorheight]) rimmedwall(wallheight=wallheight);

            // support structure for foot
            for (x=[g_bearingdia/2+g_wallthickness+2+0.1, 30,45,60])
            difference()  {
                cylinder($fn=40, r=x, h=g_motorheight);
                translate([0,0,-0.001]) cylinder($fn=40, r=x-2, h=g_motorheight);
            }
            // holds the VMA401 motor
            translate([45-g_motoroffset, 0,0]) cylinder($fn=40,r=24,h=g_motorheight);
            
            // holds the bearing
            translate([0,0,g_motorheight-g_bearingheight-g_wallthickness]) bearingholder_plus();
        }
        union() {
            // motor
            // 48 mm off center because of the 12 and 84 toothed gears
            // engineered to have exactly 12 and 84 mm diameters respectively 
            // (look at poddispenser_gears.scad)
            translate([48,0,-0.01]) rotate([0,0,180]) vm401_motor();

            //capsule exit
            translate([-radius, 0, g_motorheight+21.001]) cube([40,40,42], center=true);
            // exit ramp
            translate([-radius, 0, g_motorheight+18]) rotate([0,-10,0]) cube([40,40,42], center=true);
            
            // bearing seat
            translate([0,0,g_motorheight-g_bearingheight]) bearingholder_minus();

	    // axle hole
            cylinder($fn=30,r=8,h=50);
        }
    }
}

poddispenser_ejectorhousing();