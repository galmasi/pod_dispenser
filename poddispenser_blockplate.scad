use <poddispenser_common.scad>

module poddispenser_blockplate (radius=60, wallwidth=2,bearingheight=7,bearingdia=22) {
   difference() {
        union() {
            // base plate
            cylinder($fn=100,r=radius+wallwidth,h=wallwidth);
            // bearing holder
            cylinder($fn=30,r=bearingdia/2+3,h=bearingheight+2);
        }
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=8, h=2*bearingheight);
            // bearing seat
            translate([0,0,wallwidth]) cylinder($fn=40,r=bearingdia/2+0.1,h=bearingheight+1);
            // capsule cutout
            translate([0,-52,-0.01]) 
                    linear_extrude(height=10)
                        capsule_cutout_widebrim();
        }
    }
    rimmedwall(radius, wallwidth, bearingheight);
}

poddispenser_blockplate();
