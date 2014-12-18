// y_idler ends 
// Author: sdavi


//Idler Ends BoM
//16x M5x8mm bolt
//4x M4x??m Bolt + nut
//8x M4 washer
//8x F624ZZ bearing

include <../configuration.scad>
include <../dimensions.scad>

//use <y_motor_end.scad>




im_using_hidden_corner_connectors = 1; // if using hidden corner connectors
hcc=[9,22,1]; //to avoid hidden corner connectors;

//add extra lenths if using hidden corner conenctors
extra_l=max(t_nut_length+im_using_hidden_corner_connectors*(hcc[1]), t_nut_length*2); 
extra_w = max(40, im_using_hidden_corner_connectors*(hcc[1])+t_nut_length);

y_block_length = 20+extra_l;//big enough to hold 2 frame screws
y_block_width = 20+extra_w; 
y_block_height = 4;

y_block_total_height = 4+4+min_beltbearing_height;


echo("block length:", y_block_length);
echo("block width:", y_block_width);
echo("block height:", y_block_height);

echo("Total Height:", y_block_height*2+min_beltbearing_height);





//y_idler_ends_print();
//%motor_mount();
//y_motor_end_idler();

//%illustration();
//support();



module y_idler_ends_print(){
	difference(){
		//bottom
		y_motor_end_idler();
		translate([0,0,y_block_total_height-9.9])cube([y_block_width, y_block_length, 10]);
	
	}
	
	translate([0,-5,y_block_total_height])rotate([180,0,0])intersection(){
		y_motor_end_idler();
		translate([0,0,y_block_total_height-9.9])cube([y_block_width, y_block_length, 10]);
	
	}
}













//calculate positions for bearings

inner_bearing_pos = [	nema17_width/2+20+GT2_pulley_geared_diameter/2+(GT2_belt_thickness-GT2_belt_tooth_height)+belt_bearing[2]/2, 
						y_bearing_block_width/2+xy_bearing_distance,
						0];

outer_bearing_pos = [	inner_bearing_pos[0]-belt_bearing[2]-GT2_belt_thickness-6, 
							inner_bearing_pos[1]-5, 
							0 ];







module y_motor_end_idler(){
	difference(){
		cube([y_block_width, y_block_length,y_block_total_height]);

		//remove for frame corner
		translate([-0.1, -0.1, -0.1])cube([20.1, 20.1, y_block_total_height+0.2]);
		//remove frame lengths
		translate([0,-0.1,y_block_total_height/2-20/2]) cube([y_block_width+0.1, 20.2, 20]);
		translate([-0.1,-0.1,y_block_total_height/2-20/2]) cube([20.2, y_block_length+0.2, 20]);
		
		//belt area

		translate([20,20,y_block_total_height/2-min_beltbearing_height/2]) 
			cube([y_block_width-20+0.1, y_block_length-20+0.1, min_beltbearing_height]);


		bearing_holes();

		//frame screws

		if(im_using_hidden_corner_connectors==0){
			translate([10,20+t_nut_length/2,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height+0.2);
			translate([10,20+t_nut_length+t_nut_length/2,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height+0.2);
		
			translate([20+t_nut_length/2+3,10,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height+0.2);
			translate([20+t_nut_length+t_nut_length/2+6,10,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height+0.2);

		} else {
			//hidden corner connectors get in the way, avoid them
//hcc=[9,22,1]; //to avoid hidden connectors;

			//top, has hidden conenctors
			translate([10,y_block_length-t_nut_length/2,y_block_total_height/2]) 
				cylinder(d=frame_screw, h=y_block_total_height/2+0.1);
			translate([y_block_width-t_nut_length/2,10,y_block_total_height/2]) 
				cylinder(d=frame_screw, h=y_block_total_height/2+0.1);

			//make cutout for hidden connector so sits flush
			translate([20-0.1, 20/2-hcc[0]/2, y_block_total_height/2+20/2-0.1])
				cube([hcc[1]+0.1, hcc[0], hcc[2]+0.1]);
			translate([20/2-hcc[0]/2, 20-0.1, y_block_total_height/2+20/2-0.1])
				cube([hcc[0], hcc[1]+0.1, hcc[2]+0.1]);


			//bottom
			translate([10,20+t_nut_length/2,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height/2);
			translate([10,20+t_nut_length+t_nut_length/2,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height/2);
		
			translate([20+t_nut_length/2+3,10,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height/2);
			translate([20+t_nut_length+t_nut_length/2+6,10,-0.1]) 
				cylinder(d=frame_screw, h=y_block_total_height/2);

			
		}



	}
}


module bearing_holes(){
	//belt bearing holes

	//bearing inner
	translate(inner_bearing_pos)  translate([0,0,-0.1])cylinder(d=belt_bearing[0]+0.2, h=y_block_total_height+0.2, $fn=60);
	//bearing outer
	translate(outer_bearing_pos) translate([0,0,-0.1])  cylinder(d=belt_bearing[0]+0.2, h=y_block_total_height+0.2, $fn=60);
	//bearing outer padding space
	translate(outer_bearing_pos) translate([0,0,y_block_height]) cylinder(d=belt_bearing[1]*1.8, h=min_beltbearing_height, $fn=30);

	
	

}

module illustration(){
		visualise_high = 0; //high (1) or low bearing (0)

//frames
			%color("grey")translate([0,0,-20]) 
				cube([20,20,70]);
			%color("grey")%translate([0,0,y_block_total_height/2-10]) cube([100, 20,20]);
			%color("grey")%translate([0,0,y_block_total_height/2-10]) cube([20,150, 20]);

//bearings
	
		%color("green")translate(inner_bearing_pos)
			translate([0,0,y_block_total_height/2-10+m4_washer_thickness]){ 
				if( visualise_high == 0){
					cylinder(d=belt_bearing[1], h=belt_bearing[2], $fn=60); //bottom
				} else {

					translate([0,0,belt_bearing[2]+m4_washer_thickness*2])
						cylinder(d=belt_bearing[1], h=belt_bearing[2], $fn=60); //top
				}
			}

		%color("green")translate(outer_bearing_pos)
			translate([0,0,y_block_total_height/2-10+m4_washer_thickness]) {
					
				if(visualise_high == 0){
					cylinder(d=belt_bearing[1], h=belt_bearing[2], $fn=60);//bottom	

				} else {
					translate([0,0,belt_bearing[2]+m4_washer_thickness*2])
						cylinder(d=belt_bearing[1], h=belt_bearing[2], $fn=60); //top				
				}

			}

//nema17
		%color("yellow") rotate([0,180,0])
			translate([	-nema17_width/2-20,
							nema17_width/2+20+50,
							-(min_beltbearing_height+y_block_height*2)-46]) 
			nema17();	
			
		%translate([nema17_width/2+20,nema17_width/2+20+50,y_block_height+m4_washer_thickness+belt_bearing[2]/2 + visualise_high*(belt_bearing[2]+m4_washer_thickness*2)])
			pulley(bottom=visualise_high);

//belts
		%color("DimGray") translate(inner_bearing_pos) 
			translate([-belt_bearing[2]/2-GT2_belt_thickness,0,y_block_height+m4_washer_thickness+belt_bearing[2]/2-GT2_belt_width/2 +visualise_high*(belt_bearing[2]+m4_washer_thickness*2)]) cube([GT2_belt_thickness, 50, GT2_belt_width]);
		

	//rod holder 
	//%color("red")translate([20,0,y_block_height*2+min_beltbearing_height+frame_spacer_height])mirror([0,0,1])y_rod_holder();

}



//modle of nema17 for illustration
module nema17(){


	union(){
		translate([-nema17_width/2, -nema17_width/2, 0])
			cube_fillet([nema17_width, nema17_width, nema17_height], vertical=[3,3,3,3]);
		translate([0,0,48]) {
			cylinder(d=22, h=2, $fn=60); //rasied center bit
			cylinder(d=5, h=22+2, $fn=60); //shaft
		}

		

	
	}
	


}


//pulley bottom = 1 or 0
module pulley(bottom = 1){
		//pulley GT2 20 tooth
		//pulley height = 16, diameter = 16, bottom=1mm, top=7+0.5;


		rotate([0,bottom*180,0])translate([0,0,-1-(16-7.5-1)/2]){
			color("orange")  cylinder(d=16, h=1, $fn=60);
			color("orange") translate([0,0,16-7.5]) cylinder(d=16, h=7.5, $fn=60);	
			color("yellow") translate([0,0,1]) cylinder(d=12.2, h=16-1-7.5, $fn=60);
		}
}

