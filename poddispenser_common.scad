// approximates a capsule 
module capsule_cutout() {
    polygon(points=[[-20,0],[20,0],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}

// ouline of capsule + 2mm wall
module capsule_cutout_outer() {
    polygon(points=[[-22,-2],[22,-2],[22,5],[17,6],[15,28],[7,37],[1,37],[1,47],[-1,47],[-1,37],[-7,37],[-15,28],[-17,6],[-22,5]]);
}

module capsule_cutout_widebrim() {
    polygon(points=[[-20,-5],[20,-5],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}


// inner + outer capsule, open at the end
module capsule_outline_open() {
    polygon(points=[[20,0],[20,3],[15,4],[13,26],[5,35],
                            [-5,35],[-13,26],[-15,4],[-20,3],[-20,-2],
                            [-22,-2],[-22,5],[-17,6],[-15,28],[-7,37],
                            [-1,37],[-1,65],[1,65],[1,37],
                            [7,37],[15,28],[17,6],[22,5],[22,-2],[20,-2]]);
    
    
}


// rimmed wall

module rimmedwall(radius=60,wallthickness=2,wallheight=60) {
    difference() {
        union() {
            cylinder($fn=100,r=radius+wallthickness,h=wallheight);
            translate([0,0,wallheight-3]) cylinder($fn=100,r1=radius+wallthickness,r2=radius+wallthickness+1,h=4);
        }
        union() {
            translate([0,0,-1]) cylinder($fn=100,r=radius,h=wallheight+3);
            translate([0,0,wallheight]) cylinder($fn=100,r=radius+wallthickness,h=3);
        }
    }
}