use <poddispenser_common.scad>

module poddispenser_blockplate (radius=60, wallwidth=2) {
    difference() {
        cylinder($fn=100,r=radius+wallwidth,h=wallwidth);
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=6, h=2*wallwidth);
            // capsule cutout
            translate([0,-52,-0.01]) linear_extrude(height=10) capsule_cutout();
	}
    }
}

poddispenser_blockplate();
