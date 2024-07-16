
// approximates a capsule 
module capsule_cutout() {
    polygon(points=[[-20,0],[20,0],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}

// ouline of capsule + 2mm wall
module capsule_cutout_outer() {
    polygon(points=[[-22,-2],[22,-2],[22,5],[17,6],[15,28],[7,37],[1,37],[1,47],[-1,47],[-1,37],[-7,37],[-15,28],[-17,6],[-22,5]]);
}

// inner + outer capsule, open at the end
module capsule_outline_open() {
    polygon(points=[[20,0],[20,3],[15,4],[13,26],[5,35],
                            [-5,35],[-13,26],[-15,4],[-20,3],[-20,-2],
                            [-22,-2],[-22,5],[-17,6],[-15,28],[-7,37],
                            [-1,37],[-1,65],[1,65],[1,37],
                            [7,37],[15,28],[17,6],[22,5],[22,-2],[20,-2]]);
    
    
}

//module bearing() {
//    cylinder($fn=50,r=9,h=6);
//    translate([0,0,5.99]) cylinder($fn=50,r=11.5,h=8+6);
//}

module axle() {
    cylinder($fn=30,r=4.5,h=100, center=true);
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
//     difference() {
//        cylinder($fn=100,r=radius+2,h=height);
//        translate([0,0,-1]) cylinder($fn=100,r=radius,h=height+2);
//     }   
}



// allows capsules to slide out sideways if permitted by release
module ejector_assembly(radius=60,height=40) {
    m = [[ 1, 0, 0, 0],
         [ 0, 1, -0.5, 0],
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
            cylinder($fn=100, r=radius-2, h=height-4);
        }
        union() {
            translate([0,0,-1]) cylinder($fn=30,h=height/3,r=4.5);
            translate([0,0,height*0.66]) cylinder($fn=30,h=height,r=2.3);
            translate([0,0,height-5]) cylinder($fn=30,r=22,h=3);
        }
    }
}



module capsule_release(radius=60, height=40) {
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

// fixes: made 62 wide to match tops, added 0.5mm to motor cylinder, added extra cutout
module base(radius=60, motorheight=21, motordia=28,motoroffset=7) {
    difference() {
        // footer
        union() {
            difference() {
                cylinder($fn=100,r2=radius+2,r1=radius+20,h=motorheight);
                translate([0,0,-0.001]) cylinder($fn=100, r2=radius, r1=radius+18, h=motorheight-4);
            }
            for (x=[30,40,50,60])
            difference()  {
                cylinder($fn=40, r=x, h=motorheight);
                translate([0,0,-0.001]) cylinder($fn=40, r=x-2, h=motorheight);
            }
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
        }
    }
}

base();
//standing_column_v2();

// ejector_assembly();
// translate([120,120,0]) capsule_release();