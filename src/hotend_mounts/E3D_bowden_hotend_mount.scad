// E3D Hotend Bowden Mount
// Author: sdavi

//Inspired by: http://www.thingiverse.com/thing:148536

//Designed to fit the vertical X-Carriage using the 30mm spaced mounting holes

include <../configuration.scad>




E3D_Mount(arms=0);
//calibration();




padding = 0.1; //if holes print small can make them a bit bigger

//dimension taken from: http://files.e3d-online.com/Drawings/E3D_Heat_Sink.jpg
e3d_top_diameter = 16 + padding; 
e3d_top_height = 3.7;
e3d_recess_diameter = 12 + padding;
e3d_recess_height = 5.6;

e3d_shroud_width = 32; 

//*** mounting plate settings***
mounting_screws_distance = 30; //prusa i3 has 30 and 20 between mounting screws on X-carriage
//will use the 30mm distance 
mounting_screw_diameter = 3;
//
plate_width = 50;
//plate_length = 28; //same as gregs wade
plate_length = e3d_shroud_width;
plate_depth = 9;


//screws
m3_diameter = 3.6;
m3_washer_diameter = 6.9;
m4_diameter = 4.7;
m4_nut_diameter = 7.6;
m4_nut_diameter_horizontal = 8.15;


//*** Arm mount for accessories, fans, etc ***
arm_depth=plate_depth;
arm_width= arm_depth;
arm_screw_distance=46;
arm_length=arm_screw_distance+m4_diameter/2;







//mounting_plate();

/*
	Calibration piece to ensure mount for hotend will fit (this should be a tight fit)

*/
module calibration(){
	difference(){
		cube([e3d_top_diameter+2, e3d_top_diameter+2, plate_depth]);
		translate([(e3d_top_diameter+2)/2,(e3d_top_diameter+2)/2,0]) hotend_mount();
		cube([e3d_top_diameter+2, (e3d_top_diameter+2)/2, plate_depth]);
	}

}


module E3D_Mount(arms=1) {

  translate([0, -15, 0]){
    intersection() {
      mounting_plate(arms);
      separator();
    }
  }

  difference() {
    mounting_plate(arms);
    separator();
  }
}



module mounting_plate(arms=1){

	difference(){
		union(){
			cube_fillet([plate_width, plate_length, plate_depth], center=false, vertical=[3,3,3,3], $fn=60);
		
			//arms for Fan Mount, cabletie 
			translate([-arm_width/2,plate_length/2-10/2-0.3,0]) 
				cube_fillet([arm_width, 10, arm_depth], vertical=[0,0,0,0], $fn=12);

				//arms
			if(arms == 1){
				translate([-arm_width/2,plate_length-arm_length,0]) 
					cube_fillet([arm_width, arm_length-plate_length+5, arm_depth], vertical=[0,0,0,0], $fn=12);
				translate([plate_width-arm_width/2,plate_length-arm_length,0]) 
					cube_fillet([arm_width, arm_length-plate_length+5, arm_depth], vertical=[0,0,0,0], $fn=12);

				//rounded arm end
				translate([0,plate_length-arm_length,0]) 
					cylinder(r=(arm_width/2), h=plate_depth, center=false, $fn=60);
				translate([plate_width,plate_length-arm_length,0]) 
					cylinder(r=(arm_width/2), h=plate_depth, center=false, $fn=60);

				//rounded arm joint
				translate([arm_width/2,-6/2,0]) roundedArmJoint();
				translate([plate_width-arm_width/2-3,0,0]) rotate([0,0,-90]) 
					roundedArmJoint();

			}




				


		}

		//x-carriage holes
		translate([plate_width/2, plate_length/2, plate_depth/2]) rotate([90,0,0]){
			translate([-mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_diameter/2, h=plate_length+0.1, center=true);
			translate([+mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_diameter/2, h=plate_length+0.1, center=true);
		}

		//countersunk holes for carriage screws
		translate([plate_width/2, 7/2, plate_depth/2]) rotate([90,0,0]){
			translate([-mounting_screws_distance/2, -0.5/2, 0])
				cylinder(r=m3_washer_diameter/2, h=7+0.1+0.5, center=true, $fn=32);
			translate([+mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_washer_diameter/2, h=7+0.1, center=true, $fn=32);
		}

		//cable groove
		translate([-arm_width/2,plate_length/2-0.3,0]) 
			cylinder(r=6/2, h=arm_depth, center=false);  
		//cable ziptie
		translate([-arm_width/2+1,plate_length/2-0.3,plate_depth/2-5/2]){
 			difference(){
				cylinder(r=8, h=5, center=false);  
				cylinder(r=6, h=5, center=false);  
			}
		}

		//holes for accessory mount. 
		translate([0, plate_length-arm_screw_distance, arm_depth/2])	 rotate([0,90,0]){	
			cylinder(r=m4_diameter/2, h=arm_width+0.1, center=true);  
			cylinder(h=3.5,r=m4_nut_diameter_horizontal/2,$fn=6, center=true); 
			rotate([0,-90,0]) translate([0,0,5/2]) cube([3.5, m4_nut_diameter, 5], center=true);
		}
		translate([plate_width, plate_length-arm_screw_distance, arm_depth/2])	 rotate([0,90,0]){	
			cylinder(r=m4_diameter/2, h=arm_width+0.1, center=true);  
			cylinder(h=3.5,r=m4_nut_diameter_horizontal/2,$fn=6, center=true); 
			rotate([0,-90,0]) translate([0,0,5/2]) cube([3.5, m4_nut_diameter, 5], center=true);
		}

		translate([plate_width+arm_width/2,arm_width/2,0]) 
			cylinder(r=(arm_width/2), h=plate_depth, center=false, $fn=60);
		translate([-arm_width/2,arm_width/2,0]) 
			cylinder(r=(arm_width/2), h=plate_depth, center=false, $fn=60);
		



		translate([plate_width/2, plate_length/2, 0]) hotend_mount();


		
	}


}

module roundedArmJoint(){
	difference(){
				cube([6/2, 6/2, plate_depth]);
				translate([6/2,0,0]) 
					cylinder(r=6/2, h=plate_depth, center=false, $fn=60);

			}
}


module hotend_mount(){

//cutout for E3D (and maybe J-Head too??) - tight fit
		
	cylinder(r=e3d_recess_diameter/2, h=e3d_recess_height, center=false, $fn=60);
	translate([0,0,e3d_recess_height])
		cylinder(r=e3d_top_diameter/2, h=e3d_top_height, center=false, $fn=60);

}


module separator() {
  translate([plate_width/2, -35, plate_depth/2]){
	cylinder(r=100/2, h=plate_depth + 1, center=true, $fn=64); 
  }
}





