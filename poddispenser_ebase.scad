include <poddispenser_common.scad>

buttonside=12; // each side of the button
buttonheight=12; // height from bottom of wires to hole above button
buttonwireheight=5; // length of wires at bottom of button
buttonholedia=12; // diameter of round actual button


module buttonbase() {
    cylinder($fn=50, r=15, h=g_wallthickness);
    translate([0,0,g_wallthickness + buttonwireheight/2])
    cube([buttonside, buttonside, buttonwireheight], center=true);
    
}



module bla() {
difference() {
    union() {
        // bottom
        cylinder($fn=100, r=g_dispenser_radius+20, h=g_wallthickness);
        // wall around holder
        rimmedwall(wallheight=25, radius=g_dispenser_radius+20);
    }
    union() {
        
    }
}
}

buttonbase();