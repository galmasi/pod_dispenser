include <poddispenser_common.scad>

buttonside=12; // each side of the button
buttonheight=14; // height from bottom of wires to hole above button
buttonwireheight=5; // length of wires at bottom of button
buttonholedia=12; // diameter of round actual button

g_bottom_radius = g_dispenser_radius + 20 - g_wallthickness;



module buttonbase() {
    difference() {
        union() {
            cylinder($fn=50, r=17, h=buttonheight+g_wallthickness);
            translate([10,0,(buttonheight+g_wallthickness)/2]) cube([20,34,buttonheight+g_wallthickness], center=true);
        }
        union() {
            translate([0,0,g_wallthickness]) cylinder($fn=50, r=15, h=buttonheight+0.01);
            translate([15,0,buttonheight/2+ g_wallthickness]) cube([30,30,buttonheight+0.01], center=true);
        }
    }
    translate([0,0,g_wallthickness + buttonwireheight/2])
        cube([buttonside, buttonside, buttonwireheight], center=true);
    for (i=[-1,1])
        translate([i*(buttonside/2+1),0,g_wallthickness + buttonwireheight/2+1])
            cube([2, buttonside, buttonwireheight+2], center=true);    
}

module buttoncover(){
    difference() {
        union() {
            cylinder($fn=50, r=17, h=g_wallthickness);
            translate([10,0,g_wallthickness/2]) cube([20,34,g_wallthickness],center=true);
        }
        union() {
            translate([0,0,-0.01]) cylinder($fn=50,r=buttonholedia/2+0.3,h=g_wallthickness+0.02);
            translate([g_dispenser_radius+35, 0, -0.01]) cylinder($fn=100, r=g_bottom_radius + g_wallthickness, h=g_wallthickness+0.02);
        }
    }
}






module poddispenser_base(wallheight=25) {
    difference() {
    union() {
        // bottom
        cylinder($fn=100, r=g_bottom_radius, h=g_wallthickness);
        // wall around holder
        rimmedwall(wallheight=wallheight, radius=g_bottom_radius);
        // hold the bearing
        scale([1,1,2.5]) bearingholder_plus();
    }
    union() {
        // attach the bearing from _below_
        translate([0,0,-6]) scale([1.05,1.05,2.4]) bearingholder_minus();
        // hole for the axle
        cylinder($fn=20,r=8,h=30);
        // hole for the USB wire
        rotate([0,0,15])
            translate([0,g_dispenser_radius+20,wallheight/2])
                rotate([90,0,0])
                    cylinder($fn=30,h=40,r=2.5,center=true);
        // hole for pusbutton wires
       rotate([0,0,15])
            translate([-g_dispenser_radius-20,0,8])
                rotate([0,90,0])
                    cylinder($fn=30,h=40,r=2,center=true);        
    }
    }
    rotate([0,0,15]) translate([-g_dispenser_radius-35,0,0]) buttonbase();
}

//translate([80,80,0]) buttoncover();
poddispenser_base();