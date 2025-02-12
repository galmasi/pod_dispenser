/* ************************************************************************** */
// global variables
// dispenser [inner] radius: the dispenser is cylindrical ...
// thickness of most walls and structures
/* ************************************************************************** */

g_dispenser_radius=60;
g_wallthickness=2;

/* ************************************************************************** */
// definitions for axle bearing
/* ************************************************************************** */

g_bearingheight=7;
g_bearingdia=22;

/* ************************************************************************** */
/* cutout for capsule viewed sideways. This cutout is comfortably larger      */
/* than needed to pass the capsule                                            */
/* ************************************************************************** */

module capsule_cutout() {
    polygon(points=[[-20,0],[20,0],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}

/* ************************************************************************** */
/* a 2mm wide wall around the cutout                                          */
/* ************************************************************************** */

module capsule_cutout_outer() {
    polygon(points=[[-22,-2],[22,-2],[22,5],[17,6],[15,28],[7,37],[1,37],[1,47],[-1,47],[-1,37],[-7,37],[-15,28],[-17,6],[-22,5]]);
}

/* ************************************************************************** */
/* ************************************************************************** */

module capsule_cutout_widebrim() {
    polygon(points=[[-20,-5],[20,-5],[20,3],[15,4],[13,26],[5,35],[-5,35],[-13,26],[-15,4],[-20,3]]);
}

/* ************************************************************************** */
// inner + outer capsule, open at the end
/* ************************************************************************** */

module capsule_outline_open() {
    polygon(points=[[20,0],[20,3],[15,4],[13,26],[5,35],
                            [-5,35],[-13,26],[-15,4],[-20,3],[-20,-2],
                            [-22,-2],[-22,5],[-17,6],[-15,28],[-7,37],
                            [-1,37],[-1,65],[1,65],[1,37],
                            [7,37],[15,28],[17,6],[22,5],[22,-2],[20,-2]]);
    
    
}

/* ************************************************************************** */
/* rimmed outer wall around object.
/* ************************************************************************** */

module rimmedwall(wallheight=60, radius=g_dispenser_radius) {
    difference() {
        union() {
            cylinder($fn=100,r=radius+g_wallthickness,h=wallheight);
            translate([0,0,wallheight-3]) cylinder($fn=100,r1=radius+g_wallthickness,r2=radius+g_wallthickness+1,h=4);
	    // ridges on the wall to improve printing
	    for (angle=[0:30:360])
	        rotate([0,0,angle])
	            translate([radius, 0, 1])
		        cylinder($fn=20,r=g_wallthickness+1,h=wallheight-1);
        }
        union() {
            translate([0,0,-1]) cylinder($fn=100,r=radius,h=wallheight+3);
            translate([0,0,wallheight]) cylinder($fn=100,r=radius+g_wallthickness,h=3);
        }
    }
}

/* ************************************************************************** */
// bearing seat
/* ************************************************************************** */

module bearingholder_plus() {
    cylinder($fn=30,r=g_bearingdia/2+3,h=g_bearingheight+2);
}

/* ************************************************************************** */
/* bearing cutout
/* ************************************************************************** */
module bearingholder_minus() {
     translate([0,0,g_wallthickness]) cylinder($fn=40,r=g_bearingdia/2+0.1,h=g_bearingheight+1);
}



/* ************************************************************************** */
/* a pair of object that leave holes for screws on the axle */
/* ************************************************************************** */

module screw_cone_plus() {
    cylinder($fn=40,r1=17,r2=10,h=9);
}

module screw_cone_minus() {
    translate([0,0,1]) cylinder($fn=40,r1=15,r2=8,h=6);
    cylinder($fn=50,r=15,h=1);
}


/* ************************************************************************** */
// definitions for the VMA401 stepper motor
// motorheight is the height of the vma401 stepper motor, all the way to the useful part of the axle
// motoroffset is how offcenter the vma401 axle is
// motordia is the diameter of the vma401 motor
/* ************************************************************************** */

g_motorheight=23;
g_motordia=28;
g_motoroffset=8;
g_motorflapdepth=3;

// ********************************************
// represents the motor itself
// centered around the motor's axle
// motor's gear is at height g_motorheight to g_motorheight+5
// ********************************************

module vm401_motor () {
    // motor cylinder
    translate([g_motoroffset,0,0]) cylinder($fn=30,r=g_motordia/2+0.5,h=g_motorheight+0.02);
    // motor cutout
    translate([g_motoroffset+g_motordia/2,0,g_motorheight/2+0.01]) cube([10,16,g_motorheight+0.02],center=true);
    translate([g_motoroffset+g_motordia/2-2,0,g_motorheight/2+0.01]) cube([4,19,g_motorheight+0.02],center=true);
    // wire guide
    translate([g_motoroffset+g_motordia/2,0,g_motorheight/2+0.01]) cube([20, 6, g_motorheight+0.02], center=true);
    // motor screw flaps
    translate([g_motoroffset,0,g_motorheight-g_motorflapdepth/2+0.02]) cube([8,42,g_motorflapdepth], center=true);
}

