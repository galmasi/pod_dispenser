use <poddispenser_common.scad>

module poddispenser_topstabilizer (radius=60, wallwidth=2,bearingheight=7,bearingdia=22) {
    difference() {
        // bearing holder
        cylinder($fn=30,r=bearingdia/2+3,h=bearingheight+2);
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=8, h=2*bearingheight);
            // bearing
            translate([0,0,wallwidth]) cylinder($fn=40,r=bearingdia/2+0.1,h=bearingheight+1);
        }
    }
    for (angle=[0,60,120,180,240,300])
        rotate([0,0,angle])
            translate([radius/2+bearingdia/4,0,bearingheight/2]) 
                cube([radius-bearingdia/2,3,bearingheight], center=true);
    rimmedwall(radius, wallwidth, bearingheight);
}

poddispenser_topstabilizer();
