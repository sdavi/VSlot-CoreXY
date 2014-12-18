// Adapter for i3 y-carriage
// Author: sdavi


include <configuration.scad>
include <dimensions.scad>



small=1; //only use first hole on i3 plate 

difference(){
	union(){
		cube([170/2+(33-5)/2+15/2-10-small*25, 15, 20]);
		translate([95/2, -15 ,0] ) cube_fillet([19, 15*2+15, 20], vertical=[3,0,0,3]);	
		translate([170/2+(33-5)/2+15/2-10-small*(25), 15/2, 0]) cylinder(d=15, h=20, $fn=60);


	}
	cube([95/2, 15, 20]);

	translate([170/2+(33-5)/2, 15/2, 0]) cylinder(d=M5, h=20, $fn=60);
	translate([170/2-(33-5)/2, 15/2, 0]) cylinder(d=M5, h=20, $fn=60);

	translate([95/2-0.1,-15/2, 20/2]) rotate([0,90,0]) cylinder(d=frame_screw, h=20, $fn=60);
	translate([95/2-0.1,15+15/2, 20/2]) rotate([0,90,0]) cylinder(d=frame_screw, h=20, $fn=60);


}