
// a polygon that approximates a coffee pod (comfortably larger than a pod)
module capsule_cutout() {
    polygon(points=[[-20,0],[20,0],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}

// open the downward looking face of the capsule polygon.
// used in places where the capsule is ejected
module capsule_cutout_openface() {
    union() {
        capsule_cutout();
        polygon(points=[[-20,0],[20,0],[20,-40],[-20,-40]]);
    }
}


module materialsaver() {
    polygon(points=[[-6,0],[-3,0],[-3,-8],[3,-8],[3,0],[6,0],[0,15]]);
}

// a hexagonal pattern of coffeecup pod cutouts, plus some material saver
module standing_column_cutouts(height=80) {
    linear_extrude(h=height)
    for (angle=[0,60,120,180,240,300]) {
        rotate([0,0,angle]) translate([0,-52,0]) capsule_cutout();
        rotate([0,0,angle+30]) translate([0,-48,0]) materialsaver();
    }
    
}

module standing_column(height=80) {
    difference() {
        cylinder($fn=100,r=60,h=height);
        union() {
            translate([0,0,-1]) standing_column_cutouts(height);
            translate([0,0,-1]) cylinder($fn=8,r=4,h=height+2);
        }
    }
}

// height of this thing has to be an exact coffee cup.
module selector() {
    standing_column(height=40);
}


module ejector_base(height=30) {
    angle=45;
    m = [[ 1, 0, 0, 0],
         [ 0, 1, -0.3, 0],
         [ 0, 0, 1, 0],
         [ 0, 0, 0, 1]];
    translate([0,0,height])
    rotate([180,0,30])
    difference() {
        cylinder($fn=100,r=60,h=height);
        translate([0, 0,-1]) multmatrix(m) linear_extrude(h=height) translate([0,-52,0]) capsule_cutout_openface();
    }
}



translate ([0,0,74]) standing_column();
translate([0,0,32]) rotate([0,0,$t*100]) selector();
ejector_base();
