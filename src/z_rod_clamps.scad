// z_rod clamps
// Author: sdavi


include <configuration.scad>
include <dimensions.scad>


clamp_length = 35;
clamp_width = 35;
clamp_height = 20;


z_rod_clamp(cut=0);
translate([clamp_width+5, 0, 0]) z_rod_clamp(cut=0);

translate([0, clamp_length+5, 0])z_rod_clamp(cut=1);
translate([clamp_width+5, clamp_length+5, 0])z_rod_clamp(cut=1);

//frame screw: M5x40
//double t-nut (20mm spacing)


module z_rod_clamp(cut=0){
	if(cut==0) z_rod_clamp_base();
	else {
		difference(){
			z_rod_clamp_base(cut=cut);
			translate([0,22,-0.1])cube([clamp_width, clamp_length, clamp_height+0.2]);
		}
		translate([0,5,0]) intersection(){
			z_rod_clamp_base(cut=cut);
			translate([0,22,-0.1])cube([clamp_width, clamp_length, clamp_height+0.2]);
		}

	}

}


module z_rod_clamp_base(cut){

	

	difference(){
		cube([clamp_width, clamp_length, clamp_height]);
	

		
		//rod hole;
		if(cut==1) translate([clamp_width/2, 22, -0.1]) cylinder(d=z_bearing[0]+0.2, h=clamp_height+0.2,$fn=30);
		else translate([clamp_width/2, 22, -0.1]) cylinder(d=z_bearing[0]+0.3, h=clamp_height+0.2,$fn=30);
	
		//double t-nut, 20mm spacing
		//frame screws
		translate([clamp_width/2-10, -0.1, clamp_height/2])
			rotate([-90,0,0])cylinder(d=frame_screw, h=clamp_length+0.2, $fn=60);
		translate([clamp_width/2+10, -0.1, clamp_height/2])
			rotate([-90,0,0])cylinder(d=frame_screw, h=clamp_length+0.2, $fn=60);


			
	}

}
