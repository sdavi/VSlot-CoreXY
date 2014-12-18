// z-carriage
// Author: sdavi


include <../configuration.scad>
include <../dimensions.scad>


z_bearing_block_width = z_bearing[1] + 15 + 15; // 15 to cater for head of M5 screw
z_bearing_block_depth = 34.8/2; // if printed at 0.3mm and for 40mm screws
z_bearing_block_length = 70;

bed_arm_length = z_bearing_block_width+34;
bed_arm_width = 20;

//M5x40 to attach to arm
//M4x??


//z_carriage(arm=0);
//z_carriage(arm=1);

//mirrored end
//translate([-5-z_bearing_block_width,0,5+z_bearing_block_length])z_carriage(arm=0);
//translate([-5,0,0])mirror([1,0,0])z_carriage(arm=1);


//illustration
//%color("red")translate([z_bearing_block_width/2, 0,z_bearing_block_length/2-z_bearing[2]/2]) cylinder(d=z_bearing[1], h=z_bearing[2], $fn=30);
//rod
//%color("gray")translate([z_bearing_block_width/2, 0,-30]) cylinder(d=z_bearing[0], h=100, $fn=30);


module z_carriage(arm=1){

	bearing_lip = z_bearing_block_length/2-z_bearing[2]/2 - 0.3;


	difference(){
		union(){
			cube([z_bearing_block_width, z_bearing_block_depth, z_bearing_block_length]);
			if(arm==1){

				translate([0,0,z_bearing_block_length-30])  //arm
					cube([bed_arm_length, z_bearing_block_depth, bed_arm_width]);

				//brace support
				translate([z_bearing_block_width, 0, z_bearing_block_length-30])
					rotate([-90,0,0])linear_extrude(height=z_bearing_block_depth, slices = 20)
					polygon( points=[[0,0],
							    		[20,0],
					              	[0,20]] 
					);						
			}
		} // end union

		//cutout for bearing
		
		translate([z_bearing_block_width/2, 0,-0.1]) cylinder(d=z_bearing[0]+4, h=z_bearing_block_length+0.2, $fn=30);
		
		translate([z_bearing_block_width/2, 0,bearing_lip]) cylinder(d=z_bearing[1]+0.2, h=z_bearing_block_length-bearing_lip*2, $fn=30);




			//Arm screws (M5)
			translate([0,0,z_bearing_block_length-20]){
				translate([15/2,-0.1,0]) rotate([-90,0,0]) cylinder(d=frame_screw, h=z_bearing_block_depth+0.2, $fn=60);
				translate([15+z_bearing[1]+15/2,-0.1,0]) rotate([-90,0,0]) cylinder(d=frame_screw, h=z_bearing_block_depth+0.2, $fn=60);
				translate([15+z_bearing[1]+15/2+t_nut_length,-0.1,0]) rotate([-90,0,0]) cylinder(d=frame_screw, h=z_bearing_block_depth+0.2, $fn=60);
				translate([15+z_bearing[1]+15/2+t_nut_length*2,-0.1,0]) rotate([-90,0,0]) cylinder(d=frame_screw, h=z_bearing_block_depth+0.2, $fn=60);
	
			}


		//block screws
		translate([15/2, -0.1, z_bearing_block_length-5]) { //top
			rotate([-90,0,0]) cylinder(d=M4, h=z_bearing_block_depth+0.2, $fn=60);
			translate([15+z_bearing[1], 0,0])rotate([-90,0,0]) cylinder(d=M4, h=z_bearing_block_depth+0.2, $fn=60);
		}

		/*translate([15/2, -0.1, z_bearing_block_length/2]) { //center
			rotate([-90,0,0]) cylinder(d=M4, h=z_bearing_block_depth+0.2, $fn=60); 
			translate([15+z_bearing[1], 0,0])rotate([-90,0,0]) cylinder(d=M4, h=z_bearing_block_depth+0.2, $fn=60); 
		}*/

		translate([15/2, -0.1, 5]) {//bottom
			rotate([-90,0,0]) cylinder(d=M4, h=z_bearing_block_depth+0.2, $fn=60); 	
			translate([15+z_bearing[1],0,0])rotate([-90,0,0]) cylinder(d=M4, h=z_bearing_block_depth+0.2, $fn=60); 
		}
				



	} //end difference


}

