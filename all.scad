use <poddispenser_base.scad>
use <poddispenser_ejector.scad>
use <poddispenser_holder.scad>

color("green") poddispenser_base();
translate([0,0,28+30]) color("red") rotate([180,0,0]) poddispenser_ejector();
translate([0,0,28+30+5]) color("blue") poddispenser_holder();
