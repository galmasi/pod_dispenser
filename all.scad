use <poddispenser_base.scad>
use <poddispenser_ejectorhousing.scad>
use <poddispenser_ejector.scad>
use <poddispenser_blockplate.scad>
use <poddispenser_holder.scad>
use <poddispenser_wall.scad>
use <poddispenser_topstabilizer.scad>

color("green" ) rotate([0,0,-105]) poddispenser_base();
translate([0,0,30]) color("teal") poddispenser_ejectorhousing();
translate([0,0,110]) color("cornflowerblue") poddispenser_blockplate();
translate([0,0,130]) color("lightblue") poddispenser_wall();
translate([0,0,180]) color("azure") poddispenser_topstabilizer();

translate([0,-120,100]) color("red") rotate([180,0,0]) poddispenser_ejector();
translate([0,-120,120]) color("red") poddispenser_holder();
