include <poddispenser_common.scad>
include <poddispenser_gears.scad>

buttonside=12; // each side of the button
buttonheight=14; // height from bottom of wires to hole above button
buttonwireheight=5; // length of wires at bottom of button
buttonholedia=12; // diameter of round actual button

g_bottom_radius = g_dispenser_radius + 20 - g_wallthickness;


basewallheight=31;

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




module poddispenser_base(wallheight=20) {
  difference() {
    union() {
        // bottom
        cylinder($fn=100, r=g_bottom_radius, h=g_wallthickness);

        // wall
        rimmedwall(wallheight=wallheight, radius=g_bottom_radius);

        // central bearing
        cylinder($fn=40, r=15,h=wallheight);

        // motor ; motor gear
        translate([0-g_motoroffset, 40,0]) cylinder($fn=40,r=23,h=g_motorheight);
        //color("red") translate([0,40,g_motorheight]) motorgear();
        
        // second gear, distance 6+18=24 from motor axle, position [24, 40]
        translate([30,38,0]) cylinder($fn=50, r=7,h=g_motorheight);
        //color("red") translate([30,38,g_motorheight+1]) gear_byfour();
                
        // ejector's gear
        //color("green") translate([0,0, 30]) ejectorgear();
    }
    union() {        
        // central axle shaft
        cylinder($fn=20,r=8,h=wallheight+1);
        
        // central bearing: hole from _below_
        translate([0,0,-0.01]) cylinder($fn=40,r=g_bearingdia/2+0.1,h=18);
        translate([0,0,17.9]) cylinder($fn=40,r1=g_bearingdia/2, r2=g_bearingdia/3, h=5);
        
        // central bearing: from above
        translate([0,0, wallheight-g_bearingheight-1+0.01])
            cylinder($fn=40,r=g_bearingdia/2+0.1,h=g_bearingheight+1);
        
        // motor
        translate([0,40,0]) rotate([0,0,180]) vm401_motor();

        // axle shaft for second gear
        translate([30,38,5]) cylinder($fn=30, r=2.5,h=g_motorheight);

        // axle shaft for third gear
        //translate([44.5,18.5,5]) cylinder($fn=30,r=2.5, h=g_motorheight-5);

        // hole for the USB wire
        rotate([0,0,-135])
            translate([0,g_dispenser_radius+20,wallheight/3])
                rotate([90,0,0])
                    cylinder($fn=30,h=40,r=2.5,center=true);

        // hole for pusbutton wires
        rotate([0,0,-45])
            translate([-g_dispenser_radius-20,0,8])
                rotate([0,90,0])
                    cylinder($fn=30,h=40,r=2,center=true);
    }
  }
  rotate([0,0,-45]) translate([-g_dispenser_radius-35,0,0]) buttonbase();  
}

translate([80,80,0]) buttoncover();
poddispenser_base(basewallheight);
