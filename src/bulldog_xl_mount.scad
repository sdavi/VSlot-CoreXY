//Bulldog Mount
//Author: sdavi

//based on tjb1's Bulldog XL Extruder Mount : http://www.thingiverse.com/thing:301490

include <configuration.scad>


height = 20;
center_hole = 36.5+0.5;

difference(){
	union(){
		cube([nema17_width, nema17_width, height]);
		translate([-15,0,0])cube([nema17_width+30, 5.1, height]);
	}

	translate([nema17_width/2, nema17_width/2, -0.1]){

		//center hole
		cylinder(d=center_hole, h=height+0.2, $fn=60);

		//nema holes
		translate([nema17_holes/2, nema17_holes/2, 0])
			cylinder(d=M3, h=height+0.2, $fn=60);
		translate([-nema17_holes/2, nema17_holes/2, 0])
			cylinder(d=M3, h=height+0.2, $fn=60);
		translate([-nema17_holes/2, -nema17_holes/2, 0])
			cylinder(d=M3, h=height+0.2, $fn=60);
		translate([nema17_holes/2, -nema17_holes/2, 0])
			cylinder(d=M3, h=height+0.2, $fn=60);

	}

	//mount to frame screwns
	translate([-15/2, -0.1, height/2])rotate([-90,0,0])
		cylinder(d=frame_screw, h=10, $fn=30 );
	translate([nema17_width+15/2, -0.1, height/2])rotate([-90,0,0])
		cylinder(d=frame_screw, h=10, $fn=30 );

}