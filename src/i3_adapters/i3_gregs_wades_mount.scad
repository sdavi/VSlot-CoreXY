// I3 gregs wades mount
// Author: sdavi


include <configuration.scad>
include <dimensions.scad>


screw_spacing = 50;
screw=M3;

height =40;
width = 30+50+10;

//mount();
bowden_mount();
//frame_arm();
//frame_arm2();

module frame_arm2(){

	width=10;
	h=25+15;
	
	difference(){
		union(){
			translate([0,0,-h/2+10/2])cube([width,20,h]);
			hull(){	
				cube([width,20,10]);
				translate([45,38,0]) cylinder(d=12, h=10, $fn=60);
			}

		//translate([-width/2,0,-25/2])cube([width,35,10]);
	}

		translate([-0.1,10,-8]) rotate([0,90,0]) cylinder(d=M5, h=40, $fn=30);
		translate([-0.1,10,18]) rotate([0,90,0]) cylinder(d=M5, h=40, $fn=30);
		translate([4,10,18]) rotate([0,90,0]) cylinder(d=11, h=20, $fn=30);
		translate([4,10,-8]) rotate([0,90,0]) cylinder(d=11, h=40, $fn=30);

		//tube
		translate([45,38,0]) cylinder(d=6.8, h=10, $fn=60);



	}



}



module frame_arm(){

	width=30;
	


	difference(){
		union(){
			hull(){	
				translate([-width/2,0,0])cube([width,5,10]);
				translate([0,38,0]) cylinder(d=12, h=10, $fn=60);
			}

		translate([-width/2,0,0])cube([width,35,10]);
	}

		translate([-width/2+3+3/2,-0.1,5]) rotate([-90,0,0]) cylinder(d=M3, h=40, $fn=30);
		translate([+width/2-3-3/2,-0.1,5]) rotate([-90,0,0]) cylinder(d=M3, h=40, $fn=30);
		translate([-width/2+3+3/2,35,5]) rotate([-90,0,0]) cylinder(d=8, h=20, $fn=30);
		translate([+width/2-3-3/2,35,5]) rotate([-90,0,0]) cylinder(d=8, h=40, $fn=30);

		//tube
		translate([0,38,0]) cylinder(d=6.8, h=10, $fn=60);


		translate([-5,0,0])cube([10,25,10]);

	}



}

module bowden_mount(){
	pneumatic_thread = 9; //1/8 BSP
	pneumatic_height = 5.5;
	plate_length = 50;
	plate_width = 10;
	plate_height = 6;
//bowden holder
	difference(){
		union(){
			cube([plate_length, plate_width, plate_height]);
			translate([0,5,0])cylinder(d=10, h=plate_height, $fn=60);
			translate([plate_length,5,0])cylinder(d=10, h=plate_height, $fn=60);
			
			hull(){
				translate([plate_length/2, plate_width/2, 0]) cylinder(d=pneumatic_thread+8, h=pneumatic_height+5, $fn=60);
				translate([plate_length/2-15, 0, 0]) cube([30,plate_width, 1]);
			}
				
		}

		translate([0,5,-0.1]) cylinder(d=M3, h=plate_height+0.2, $fn=30);
		translate([50,5,-0.1]) cylinder(d=M3, h=plate_height+0.2, $fn=30);

		//feed hole
		translate([plate_length/2, plate_width/2, -0.1]) cylinder(d=3.2, h=30, $fn=60);
		//pneumatic hole
		translate([plate_length/2, plate_width/2, 5]) cylinder(d=pneumatic_thread, h=30, $fn=60);

		
	}


}

module mount(){
	difference(){
		union(){
			cube([20, 19, height]);
			translate([0,-5,height-12]) cube([width, 19+5, 12]);
			//translate([8,0,0]) rotate([0, -20, 0]) cube([width, 19, 12]);
			translate([0,19,0]) tri();	
	
		}
	
		translate([10,19+0.1,9.8]) scale([0.7, 1.1, 0.65]) tri();	
	
		//frame screw
		translate([10, -0.1, 10]) rotate([-90,0,0]) cylinder(d=frame_screw, h=29+0.2, $fn=60);
		translate([10, -5.1, 30]) rotate([-90,0,0]) cylinder(d=frame_screw, h=29+0.2, $fn=60);
		translate([10, -5.1, 30]) rotate([-90,0,0]) cylinder(d=12, h=5.1, $fn=60);
	
		//wades screws
		translate([30, -5.1, height-12/2])rotate([-90,0,0]) cylinder(d=screw, h=30, $fn=60);
		translate([30+50, -5.1, height-12/2])rotate([-90,0,0]) cylinder(d=screw, h=30, $fn=60);
	
	
	
	}
}

module tri(){
	rotate([90,0,0])linear_extrude(height=19, slices = 20)
			polygon( points=[[20,0],
				[width,height-12],
             [20,height-12],
				[20,0]] 
			);		
}

