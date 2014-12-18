// z nut holder
// Author: sdavi


include <configuration.scad>
include <dimensions.scad>

width = 95;
length = z_bearing[1] + 15 + 15;// same size as the carriage ends
height = 35;

//Trapezoidal but with flange 
t_nut_flange_diameter = 42; //D3
t_nut_flange_height = 10;// b2
t_nut_sleeve_diameter = 25; //D2
t_nut_total_height = 25;//b1

t_nut();


module t_nut(){

	difference(){

		union(){

			//cube([width, length, height]);
			cube([width, length, 19]);// for 25mm screw

		}// end union

		translate([width/2, length/2,-0.1]){
			//flange cutout
			cylinder(d=t_nut_flange_diameter+0.4, h=t_nut_flange_height+0.1, $fn=60);

			//sleeve cutout
			cylinder(d=t_nut_sleeve_diameter+0.3, h=height+0.2, $fn=60);
		}
	
		flange_mounting_holes();
		holes();
	} // end difference


}

module flange_mounting_holes(){
	screw_distance = 35;
	xh=cos(30)*screw_distance/2;
	yh=sin(30)*screw_distance/2;
	translate([width/2, length/2,-0.1]){
		for(p=[
				[0,screw_distance/2],
				[0, -screw_distance/2],
				[-xh,yh],
				[-xh,-yh],
				[xh,yh],
				[xh,-yh]
				]){
			translate([p[0], p[1], 0])
				cylinder(d=M5, h=height+0.2, $fn=30);
		}


	}


}

module holes(){
	//min dist 15 for tee nuts

	translate([10,length/2-10, -0.1]){
		cylinder(d=frame_screw, h=height, $fn=60);
		translate([width-20,0,0])cylinder(d=frame_screw, h=height, $fn=60);
	}
	translate([10,length/2+10, -0.1]){
		cylinder(d=frame_screw, h=height, $fn=60);
		translate([width-20,0,0])cylinder(d=frame_screw, h=height, $fn=60);
	}

}

