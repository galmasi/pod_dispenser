
// a polygon that approximates a coffee pod (comfortably larger than a pod)
module capsule_cutout() {
    polygon(points=[[-20,0],[20,0],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}

module capsule_cutout_outer() {
    polygon(points=[[-22,-2],[22,-2],[22,5],[17,6],[15,28],[7,37],[1,37],[1,47],[-1,47],[-1,37],[-7,37],[-15,28],[-17,6],[-22,5]]);
}

// open the downward looking face of the capsule polygon.
// used in places where the capsule is ejected
module capsule_cutout_openface() {
    union() {
        capsule_cutout();
        polygon(points=[[-20,0],[20,0],[20,-40],[-20,-40]]);
    }
}

module capsule_outline_open() {
    polygon(points=[[20,0],[20,3],[15,4],[13,26],[5,35],
                            [-5,35],[-13,26],[-15,4],[-20,3],[-20,-2],
                            [-22,-2],[-22,5],[-17,6],[-15,28],[-7,37],
                            [-1,37],[-1,65],[1,65],[1,37],
                            [7,37],[15,28],[17,6],[22,5],[22,-2],[20,-2]]);
    
    
}

module bearing() {
    cylinder($fn=50,r=9,h=6);
    translate([0,0,5.99]) cylinder($fn=50,r=11.5,h=8+6);
}

module axle() {
    cylinder($fn=30,r=4.5,h=100, center=true);
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

module standing_column_v2(radius=60, height=80) {
    for (angle=[0,60,120,180,240,300]) {
        rotate([0,0,angle]) 
        translate([0,-52,0]) linear_extrude(height=height) 
        difference() {
            capsule_cutout_outer();
            capsule_cutout();
        }    
    }
    difference() {
        cylinder($fn=30, r=6, h=height);
        translate([0,0,-1]) cylinder($fn=20,r=4,h=height+2);
    }
     difference() {
        cylinder($fn=100,r=radius+2,h=height);
        translate([0,0,-1]) cylinder($fn=100,r=radius,h=height+2);
     }   
}

// height of this thing has to be an exact coffee cup.
module selector() {
    standing_column(height=40);
}


module ejector_base(radius=60,height=30,height2=30) {
    angle=45;
    m = [[ 1, 0, 0, 0],
         [ 0, 1, -0.3, 0],
         [ 0, 0, 1, 0],
         [ 0, 0, 0, 1]];
    translate([0,0,height])
    rotate([180,0,30])
    difference() {
        cylinder($fn=100,r=radius,h=height);
        translate([0, 0,-1]) multmatrix(m) linear_extrude(h=height) translate([0,-52,0]) capsule_cutout_openface();
    }
    
    translate([0,0,height])
    difference() {
        cylinder($fn=100, r=radius, h=height2);
        translate([0,0,-0.001]) cylinder($fn=100, r=radius-2, h=height2+0.002);
    }
}

// middle box. stands still, axis revolves around it.

module ejector_mid(radius=62,capsuleheight=37,ejectorheight=40) {
    difference() {
        cylinder($fn=100, r=radius, h=ejectorheight);
        union() {
            translate([0,0,1.5]) cylinder($fn=100, r=radius-2, ejectorheight);
            translate([0,-52,-1]) linear_extrude(height=3) capsule_cutout();
            axle();
            translate([0,0,14]) rotate([180,0,0])  bearing();
        }
    }
    // capsule cutout
    translate([0,-52,0]) linear_extrude(height=capsuleheight) 
    difference() {
        capsule_cutout_outer();
        capsule_cutout();
    }
    difference() {
        cylinder($fn=50,r=16,h=capsuleheight);
        union() {
            translate([0,0,capsuleheight-14+0.01]) bearing();
            translate([0,0,14]) rotate([180,0,0])  bearing();
            axle();
        }
    }
}

module ejector2(radius=60,height=40) {
    m = [[ 1, 0, 0, 0],
         [ 0, 1, -0.3, 0],
         [ 0, 0, 1, 0],
         [ 0, 0, 0, 1]];
    difference() {
        intersection() {
            union() {
                cylinder($fn=30,h=height,r=7);
                for (angle=[0,60,120,180,240,300]) {
                    rotate([0,0,angle]) translate([0,-52,0]) multmatrix(m) 
                    linear_extrude(height=height) 
                        capsule_outline_open();
                }
            }
            cylinder($fn=100, r=radius, h=height);
        }
        union() {
            translate([0,0,-1]) cylinder($fn=30,h=height/3,r=4.5);
            translate([0,0,height*0.66]) cylinder($fn=30,h=height,r=2.3);
            //translate([0,0,height/2]) cylinder($fn=30,r=22,h=height/2);
        }
    }
}



// director plate. sits below middle box, ejects capsule when in position.
module director_plate(radius=58, height=2) {
    difference() {
        cylinder($fn=100, r=radius, h=height);
        axle();
        translate([0,-52,-0.01]) linear_extrude(height=10) capsule_cutout();
    }
}


module base(height=20) {
    difference() {
        cylinder($fn=100, r=60, h=height);
        union() {
            // axle hole
            translate([0,0,-1]) cylinder($fn=20, r=4, h=height+2);
            // upper screw
            translate([0,0,-0.01]) cylinder($fn=20, r=8, h=6);
            // lower screw
            translate([0,0,height-6+0.01]) cylinder($fn=20, r=8, h=6);
            // weight savers
            // leg holders
        }
    }
}


module base2(radius=60, height=40) {
    difference() {
        cylinder($fn=100,r=radius+2,h=height);
        union() {
            // cavity for base
            translate([0,0,2]) cylinder($fn=100,r=radius,h=height+2);
            // axle hole
            translate([0,0,-1]) cylinder($fn=20,r=6, h=height);
            // capsule cutout (horizontal)
            translate([0,-52,-0.01]) linear_extrude(height=10) capsule_cutout();
            // capsule cutout (vertical)
            rotate([0,0,30]) translate([0, -radius, height/2+2]) cube([40,40,40], center=true);
        }
    }   
}

//translate ([0,0,74]) standing_column();
//translate([0,0,32]) rotate([0,0,$t*100]) selector();
//ejector_mid();
//translate([0,0,38]) director_plate();
//bearing();

//base();

//standing_column_v2();

//ejector2();
 base2();