// Endstop Holder for ReprapDiscount Hall-effect Endstop
// Author: sdavi 

include <configuration.scad>
include <dimensions.scad>

include <lib/endstop_holder.scad>

switch_length = 27;
switch_width = 10.5;
switch_holes = [5, 22]; //17mm spacing


endstop_holder(diameter=12); //attach to 12mm rod

//endstop_holder_frame();

translate([29,0,9]) magnetHolder();


magnet_d = 4; //magnet diameter
magnet_h = 2; //magnet height

length = 16;
height = magnet_h + 10;
width = magnet_d*2;


module endstop_holder_frame(){
	
	middle = 24-m3_washer_diameter*2;
	
	echo(middle);
	difference(){
		union(){
			cube([24, 5, 20+8]);
	
			translate([24/2-middle/2, 0,0])cube([middle, 15, 24]);
			translate([24/2-middle/2, 0,24])cube([middle, 15+20, 4]);
		}



		translate([0, 0,0])cube([25, 15, 5]);

	//frame screw
		translate([24/2, 15+10, 20-0.1]) cylinder(d=frame_screw, h=15.2);
		//translate([24/2, 15+10, 20-0.1]) cylinder(d=10, h=4);


		//mounting slots

		translate([24/2-17/2,-0.1,0]){
			translate([0,0, 3+5]) rotate([-90,0,0]) cylinder(d=M3, h=9.2, $fn=30);
			translate([0,0, 28-3]) rotate([-90,0,0]) cylinder(d=M3, h=9.2, $fn=30);

			translate([-M3/2,0,3+5]) cube([M3, 9.2, 28-6-5]);
			//make sure width for nuts
			translate([-m3_nut_diameter_horizontal/2,5,5]) cube([m3_nut_diameter_horizontal, 2.8, 28-6]);

		}
		translate([24/2+17/2,-0.1,0]){
			translate([0,0, 3+5]) rotate([-90,0,0]) cylinder(d=M3, h=9.2, $fn=30);
			translate([0,0, 28-3]) rotate([-90,0,0]) cylinder(d=M3, h=9.2, $fn=30);

			translate([-M3/2,0,3+5]) cube([M3, 9.2, 28-6-5]);
			//make sure width for nuts
			translate([-m3_nut_diameter_horizontal/2,5,5]) cube([m3_nut_diameter_horizontal, 2.8, 28-6]);

		}
		

	}


}




//magnet holder for t/v-slot
module magnetHolder(){

		difference(){
			union(){
				hull(){
					translate([10,8,-9])cylinder(d=length, h=10, $fn=60);
					translate([10-length/2,-6,-9])cube([length+0.5, 1, 10]);
				}
				translate([10,-2,0]) rotate([0,0,90]) magnetbase();			
			}
			translate([10,8,-9+3])cylinder(d=10.5, h=10, $fn=60);
			translate([10, 8, -9.1]) cylinder(d=M5, h=20, $fn=30 );
	}
}


module magnetbase(){
	difference(){
			hull(){
	  		  	cube([width,length,.5], center=true);
	  	  		cylinder(r=magnet_d/2+2,h=height);
		}
		translate([0,0,height-magnet_h]) cylinder(r=magnet_d/2+0.2, h=magnet_h+0.1, $fn=60);
	}
}