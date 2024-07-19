
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


bearingheight=7;
bearingdia=22;
wallwidth=2;

// motorheight is the height of the vma401 stepper motor, all the way to the useful part of the axle
// motoroffset is how offcenter the vma401 axle is
// motordia is the diameter of the vma401 motor

motorheight=23;
motordia=28;
motoroffset=7;
motorflapdepth=4;

module bearingholder_plus() {
    cylinder($fn=30,r=bearingdia/2+3,h=bearingheight+2);
}

module bearingholder_minus() {
     translate([0,0,wallwidth]) cylinder($fn=40,r=bearingdia/2+0.1,h=bearingheight+1);
}