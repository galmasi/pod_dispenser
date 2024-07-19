include <poddispenser_common.scad>
// radius is the inner radius (less the thickness of the wall)



// represents the motor itself
module motor () {
    // motor cylinder
    translate([motoroffset,0,0]) cylinder($fn=30,r=motordia/2+0.5,h=motorheight+0.02);
    // motor cutout
    translate([motoroffset+motordia/2,0,motorheight/2+0.01]) cube([10,16,motorheight+0.02],center=true);
    translate([motoroffset+motordia/2-2,0,motorheight/2+0.01]) cube([4,19,motorheight+0.02],center=true);
    // wire guide
    translate([motoroffset+motordia/2,0,motorheight/2+0.01]) cube([20, 6, motorheight+0.02], center=true);
    // motor screw flaps
    translate([motoroffset,0,motorheight-motorflapdepth/2+0.02]) cube([8,42,motorflapdepth], center=true);
}



module poddispenser_base (radius=60, wallheight=40, wallthickness=2) {
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
                    //translate([radius,0,0]) cube([10,6,25],center=true);
                    translate([0,0,wallheight]) cylinder($fn=100,r=radius+wallthickness,h=3);
                }
            }
            // support structure for foot
            for (x=[bearingdia/2+wallwidth+1, 30,45,60])
            difference()  {
                cylinder($fn=40, r=x, h=motorheight);
                translate([0,0,-0.001]) cylinder($fn=40, r=x-2, h=motorheight);
            }
            // holds the motor
            translate([45-motoroffset, 0,0]) cylinder($fn=40,r=24,h=motorheight);
            
            // holds the bearing
            translate([0,0,motorheight-bearingheight-wallwidth])
                cylinder($fn=30, r=bearingdia/2+wallwidth+1, h=bearingheight+wallwidth);
        }
        union() {
            // motor
            translate([45,0,-0.01]) rotate([0,0,180]) motor();
            //capsule exit
            translate([-radius, 0, motorheight+21.001]) cube([40,40,42], center=true);
            // exit ramp
            translate([-radius, 0, motorheight+18]) rotate([0,-10,0]) cube([40,40,42], center=true);
            
            // bearing hole
            translate([0,0,motorheight-bearingheight])
                cylinder($fn=30,r=bearingdia/2,h=bearingheight+0.01);
            // axle hole
            cylinder($fn=30,r=4,h=50);

        }
    }
}

poddispenser_base();
    



//motormount();