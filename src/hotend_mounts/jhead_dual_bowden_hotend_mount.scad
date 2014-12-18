// jhead Hotend Bowden Mount
// Author: sdavi

//Inspired by imrahil's jhead mount: http://www.thingiverse.com/thing:148536
//and sauce71's E3D FanfanfanDuct: https://www.youmagine.com/designs/e3d-fanfanfanduct#!design-information

//Designed to fit verical X-Carriage using the 30mm spaced mounting holes
//uses 3 25mm fans


//Fan half attaches with 3x35mm M3 screws

include <../configuration.scad>


pneumatic_thread = 9/2; //1/8 BSP
//pneumatic_thread = 5.5/2; //6mm thread


//30mm distance between jheads

//mounting_plate();


jhead_mount_fan();
jhead_mount();
//calibration();

//bowden_holder2(); //ziptie
//bowden_holder();


module jhead_mount_fan(){
	//fan end only
	translate([0, -15, 0]){
   	 intersection() {
   	   mounting_plate();
   	   separator();
   	 }
 	}
}

module jhead_mount(){
	// carriage end only
	difference() {
	    mounting_plate();
	    separator();//
	}
}










padding = 0.1; //if holes print small can make them a bit bigger

jhead_top_diameter = 16 + padding; 
jhead_top_height = 4.8+0.9; //5.7 small gap
jhead_recess_diameter = 12.1 + padding;
jhead_recess_height = 4.5;



//*** mounting plate settings***
mounting_screws_distance = 30; //distance between mounting screws on X-carriage
mounting_screw_diameter = 3.2;
//

plate_width = 50+18;
plate_length = 32;
plate_depth = 9;

bowden_thickness = 6.8;


extra_length=45-6;
delta_length=extra_length-plate_length;
arm_width=plate_depth;

//fan shroud
sSize = 27;	
sDepth = 10;
sDia = 22; 



module fanShroud(left=1, right=1){

	

	difference(){
		union(){

			linear_extrude(height = sSize, center = false, convexity = 10, twist = 0){
				hull(){
					square([sSize,5]);
					translate([sSize/2,sDepth])circle(d=sDia+4);
				}
			}

			//tabs for cooling fans
			if(left==1){
				translate([5,0,6])rotate([0,180-30,0])coolingFin();
			}
			if(right==1){
				translate([5+17,0,6])mirror([1,0,0])rotate([0,180-30,0])coolingFin();	
			}


		}
		translate([sSize/2, 5-0.1 ,sSize/2 ])rotate([90,0,0])cylinder(d=22, h=5, $fn=60);//entry
		color("green")translate([sSize/2,sDepth+18/2, 0])cylinder(d=12, h=sSize); //smaller for bottom
		color("green")translate([sSize/2,sDepth+18/2, 3])cylinder(d=18, h=sSize); //larger for main


		translate([0,sDepth+22/4,0])cube([35,10,35]);//chop jdhead end
		translate([0,-5,0])cube([35,5,35]); //chop fan end
		translate([0,0,sSize-(sSize-25)/2])cube([35,25,2]); //chop top to be flush with fan

		hull(){
			translate([sSize/2, 6 ,sSize/2 ])rotate([90,0,0])cylinder(d=22, h=1, $fn=60);
			translate([sSize/2,sDepth, 2+8])cylinder(d=18, h=10);
		}
	
		//screw holes 
		translate([sSize/2-20/2, -0.1 ,sSize/2-20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);
		translate([sSize/2+20/2, -0.1 ,sSize/2-20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);
		translate([sSize/2-20/2, -0.1 ,sSize/2+20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);
		translate([sSize/2+20/2, -0.1 ,sSize/2+20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);

	}
}


module coolingFin(){	
	difference(){
		cube([15, 11, 4]);
		
		translate([10,11/2,0]) cylinder(d=2.5, h=4);
	}
	
}




module bowden_holder(){

	//bowden holder
	difference(){
		union(){


			hull(){ //
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 6], top=[0,0,0,0]);
				translate([plate_width/2-33/2,plate_length-5,-15]) 
					cube([33,5,15]);
			}
			
			hull(){ //top part
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 6], top=[0,0,0,0]);
				translate([plate_width/2,plate_length/2, 0]) 
					cylinder(d=6+6, h=6, $fn=20);
				
			}
		}
		// tube holder hole
		translate([plate_width/2,plate_length/2,0])
			cylinder(d=6.5, h=6+0.2, $fn=20);

		translate([plate_width/2-25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
		translate([plate_width/2+25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
	}

}

module bowden_holder2(){

	//bowden holder with zipties
	difference(){
		union(){


			hull(){ //
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 8], top=[0,0,0,0]);
				translate([plate_width/2-33/2,plate_length-5,-15]) 
					cube([33,5,15]);
			}
			
			hull(){ //top part
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 8], top=[0,0,0,0]);
				translate([plate_width/2,plate_length/2, 0]) 
					cylinder(d=6+6, h=8, $fn=20);
				
			}
		}
		// tube holder hole
		translate([plate_width/2,plate_length/2,0])
			cylinder(d=6.5, h=8+0.2, $fn=20);

		//zip tie
		translate([plate_width/2,plate_length/2,8/2-2]){
			difference(){
				cylinder(d=6.5+15, h=4, $fn=35);
				cylinder(d=6.5+15-4, h=4, $fn=35);

			}
		}



		translate([plate_width/2-10,plate_length/2-10,0]) cube([20,10,10]);

		translate([plate_width/2-25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
		translate([plate_width/2+25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
	}

}

/*
	Calibration piece to ensure mount for hotend will fit (this should be a tight fit)
*/
module calibration(){
	difference(){
		cube([jhead_top_diameter+2, jhead_top_diameter+2, plate_depth]);
		translate([(jhead_top_diameter+2)/2,(jhead_top_diameter+2)/2,0]) hotend_mount();
		cube([jhead_top_diameter+2, (jhead_top_diameter+2)/2, plate_depth]);
	}

}


module jhead_Mount() {

  translate([0, -15, 0]){
    intersection() {
      mounting_plate();
      separator();
    }
  }

  difference() {
    mounting_plate();
    separator();
  }
}



module mounting_plate(){

	difference(){
		union(){
			translate([0,plate_length-extra_length,0])cube_fillet([plate_width, extra_length, plate_depth], center=false, vertical=[3,3,3,3], $fn=60);
		
			//cabletie blocks
//			translate([-arm_width/2,0-10/2-0.3,0]) 
			translate([-arm_width/2,0-7,0]) 
				cube_fillet([arm_width, 12, plate_depth], vertical=[0,0,0,0], $fn=12);
			translate([plate_width-arm_width/2,0-7,0]) 
				cube_fillet([arm_width, 12, plate_depth], vertical=[0,0,0,0], $fn=12);
				
			//pneumatic rounded triangle
			hull(){
				translate([0,plate_length-7,plate_depth]) 
					cube_fillet([plate_width,7,7+1.7], vertical=[3,3,3,3]);
					hull(){
						translate([plate_width/2-15,plate_length/2,plate_depth])  
							cylinder(r=20/2, h=7+1.7, $fn=20);
						translate([plate_width/2+15,plate_length/2,plate_depth])  
							cylinder(r=20/2, h=7+1.7, $fn=20);

					}
			}
			
					
			translate([plate_width/2-sSize/2-15,-10+3,-25-1]) fanShroud(right=0);
			translate([plate_width/2-sSize/2+15,-10+3,-25-1]) fanShroud(left=0);
		
			//join both fans
			translate([plate_width/2-1.5,-10+3, -25-1]) cube([3,3,27]);

			//small support for fan part to print without supports
			//translate([-arm_width/2,-7,0]) cube([3, 2, plate_depth]);


		} //end union

		//x-carriage holes
		translate([plate_width/2, plate_length-10, plate_depth/2]) rotate([-90,0,0]){
			translate([-mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_diameter/2, h=10+0.1, center=false);
			translate([+mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_diameter/2, h=10+0.1, center=false);
		}

		//countersunk holes for carriage screws
		translate([plate_width/2, plate_length/2+jhead_top_diameter/2, plate_depth/2]) rotate([90,0,0]){
			color("green")translate([-mounting_screws_distance/2, -0.5/2, 0])
				cylinder(r=m3_washer_diameter/2, h=3+4, center=true, $fn=32);
			translate([+mounting_screws_distance/2, -0.5/2, 0]) 
				cylinder(r=m3_washer_diameter/2, h=3+4, center=true, $fn=32);
		}


		//fan section mounting holes(leave a 0.2 layer to print easy without support, just drill out)
		translate([plate_width/2, -7+3.2, plate_depth/2]) rotate([-90,0,0]){
			cylinder(r=m3_diameter/2, h=plate_length+10);

			translate([-mounting_screws_distance/2-12, 0, 0]) 
				cylinder(r=m3_diameter/2, h=plate_length+10, center=false);
			translate([+mounting_screws_distance/2+12, 0, 0]) 
				cylinder(r=m3_diameter/2, h=plate_length+10, center=false);
		}
		
		//fan section countersink mounting holes
		translate([plate_width/2, -7-0.1, plate_depth/2]) rotate([-90,0,0]){
			cylinder(r=m3_washer_diameter/2, h=3, $fn=60);

			translate([-mounting_screws_distance/2-12, 0, 0]) 
				cylinder(r=m3_washer_diameter/2, h=3, center=false, $fn=60);
			translate([+mounting_screws_distance/2+12, 0, 0]) 
				cylinder(r=m3_washer_diameter/2, h=3, center=false, $fn=60);
		}

		//fan section nut traps holes
		translate([plate_width/2, plate_length-4, plate_depth/2]) rotate([-90,0,0]){

			cylinder(d=m3_nut_diameter_horizontal, h=4+0.1, center=false, $fn=6);

			translate([-mounting_screws_distance/2-12, 0, 0]) 
				cylinder(d=m3_nut_diameter_horizontal, h=4+0.1, center=false, $fn=6);
			translate([+mounting_screws_distance/2+12, 0, 0]) 
				cylinder(d=m3_nut_diameter_horizontal, h=4+0.1, center=false,$fn=6);
		}		

	

		//cable grooves for ziptie 
		translate([-arm_width/2,0-0.3,0]) 
			cylinder(r=6/2, h=plate_depth, center=false);  
		translate([plate_width+arm_width/2,0-0.3,0]) 
			cylinder(r=6/2, h=plate_depth, center=false);  

		//cable ziptie left
		translate([-arm_width/2+1,0-0.3,plate_depth/2-5/2]){
 			difference(){
				cylinder(r=8, h=5, center=false);  
				cylinder(r=6, h=5, center=false);  
			}
		}
		//cable ziptie right
		translate([plate_width+arm_width/2+1,0-0.3,plate_depth/2-5/2]){
 			difference(){
				cylinder(r=8, h=5, center=false);  
				cylinder(r=6, h=5, center=false);  
			}
		}






		translate([plate_width/2-15, plate_length/2, 0]) hotend_mount();
		translate([plate_width/2+15, plate_length/2, 0]) hotend_mount();


		//pneumatic holes
		translate([plate_width/2-15,plate_length/2,jhead_recess_height+jhead_top_height])
			cylinder(r=pneumatic_thread, h=10, $fn=20);
		translate([plate_width/2+15,plate_length/2,jhead_recess_height+jhead_top_height])
			cylinder(r=pneumatic_thread, h=10, $fn=20);



		//hole for the thermistor wires
		translate([plate_width/2-15, 3, -6])cylinder(d=9, h=plate_depth+6, $fn=60);
		translate([plate_width/2+15, 3, -6])cylinder(d=9, h=plate_depth+6, $fn=60);

		
	}//end difference


}

module roundedArmJoint(){
	difference(){
				cube([6/2, 6/2, plate_depth]);
				translate([6/2,0,0]) 
					cylinder(r=6/2, h=plate_depth, center=false, $fn=60);

			}
}


module hotend_mount(){

//cutout for jhead  tight fit
		
	cylinder(r=jhead_recess_diameter/2, h=jhead_recess_height, center=false, $fn=60);
	translate([0,0,jhead_recess_height])
		cylinder(r=jhead_top_diameter/2, h=jhead_top_height, center=false, $fn=60);

}


module separator() {
  translate([-10, -7, -50]){
		cube([plate_width+20, 7+plate_length/2, 50+jhead_recess_height+jhead_top_height]);
	//cylinder(r=150/2, h=jhead_recess_height+jhead_top_height+35, center=true, $fn=64); 
  }
}







