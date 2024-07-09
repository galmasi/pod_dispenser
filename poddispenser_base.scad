// radius is the inner radius (less the thickness of the wall)
// motorheight is the height of the vma401 stepper motor
// motoroffset is how offcenter the vma401 axle is
// motordia is the diameter of the vma401 motor

module poddispenser_base (radius=60, wallheight=40, motorheight=21, motordia=28, motoroffset=7, wallthickness=2) {
    difference() {
        union() {
            // foot
            difference() {
                cylinder($fn=100,r2=radius+wallthickness,r1=radius+20,h=motorheight);
                translate([0,0,-0.001]) cylinder($fn=100, r2=radius, r1=radius+18, h=motorheight-4);
            }
            //  wall on top + rim
            translate([0,0,motorheight]) difference() {
                union() {
                    cylinder($fn=100,r=radius+wallthickness,h=wallheight);
                    translate([0,0,wallheight-3]) cylinder($fn=100,r1=radius+wallthickness,r2=radius+wallthickness+1,h=4);
                    
                }
                union() {
                    translate([0,0,-1]) cylinder($fn=100,r=radius,h=wallheight+3);
                    translate([radius,0,0]) cube([10,6,25],center=true);
                    translate([0,0,wallheight]) cylinder($fn=100,r=radius+wallthickness,h=3);
                }
            }
            // rim
            // support structure for foot
            for (x=[30,45,60])
            difference()  {
                cylinder($fn=40, r=x, h=motorheight);
                translate([0,0,-0.001]) cylinder($fn=40, r=x-2, h=motorheight);
            }
            // holds the motor
            translate([motoroffset, 0,0]) cylinder($fn=40,r=25,h=motorheight);
        }
        union() {
            // motor cylinder
            translate([motoroffset,0,-1]) cylinder($fn=30,r=motordia/2+0.5,h=motorheight+2);
            // motor cutout
            translate([motoroffset+motordia/2,0,motorheight/2]) cube([10,16,motorheight+2],center=true);
            translate([motoroffset+motordia/2-2,0,motorheight/2]) cube([4,19,motorheight+2],center=true);
            // wire guide
            translate([radius/2,0,motorheight]) cube([radius+8, 6, 7], center=true);
            // motor screw flaps
            translate([motoroffset,0,motorheight]) cube([8,42,2], center=true);
            // capsule exit
            translate([-radius, 0, motorheight+21.001]) cube([40,40,42], center=true);
            // exit ramp
            translate([-radius, 0, motorheight+18]) rotate([0,-10,0]) cube([40,40,42], center=true);

        }
    }
}

poddispenser_base();