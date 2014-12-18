// Belt Bearing Spacer
// Author: sdavi


include <configuration.scad>


bearing_height = (belt_bearing[2]+m4_washer_thickness*2);

height = min_beltbearing_height-bearing_height;

echo ("Spacer height:", height);

difference(){
	cylinder(d=belt_bearing[1]-3, h=height,$fn=30);
	translate([0,0,-0.1])cylinder(d=belt_bearing[0]+0.6, h=height+0.2,$fn=20);
}