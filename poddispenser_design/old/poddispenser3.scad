
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


module standing_column_v3(radius=69, height=80) {
    for (angle=[0,45,90,135,180,225,270,315]) {
        rotate([0,0,angle]) 
        translate([0,8-radius,0]) linear_extrude(height=height) 
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

standing_column_v3();
