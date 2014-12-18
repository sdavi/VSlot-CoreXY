// X-Carriage
// Author: sdavi

include <../configuration.scad>


//BoM

//Wheels (can also use 3 wheels instead of 4)
//4x M5x45 screw
//4x M5 nyloc nut
//4x v-slot wheel
//4x eccentric spacer
//4x spacer

//Hotend mount
//2x M3x?? screw
//2x M3 nut



//configuration

number_wheels = 4; // 4 or 3
mount_spacing = [30]; //[30], [50], [30,50], //mounting options for different hotend/extruder/etc plates
mount_diameter = M3; //mounting screws
mount_nuttrap_diameter=6.6;
//end configuration

//x_carriage_top();
//x_carriage_bottom();


//%illustration();

//x_carriage();
//belt_clamp();


belt_padding = 0.3; //either side of the belt width cutouts

flange_thickness=1.1; //thickness of flange on bearing


wheel_edge_inset = 4.5+vslot_wheel_hole/2;

v_wheel_spacing = 39.7; // spacing used on openbuilds plates. One hole is 5mm and the other hole is 7.2 for the eccentric spacer.

min_h_wheel_spacing= vslot_wheel[0]+5;
min_carriage_width = min_h_wheel_spacing+wheel_edge_inset*2; //4.5 padding around wheel holes

echo("Min Wheel Spacing: ", min_h_wheel_spacing);
echo("Min Carriage Width: ", min_carriage_width);

carriage_width = max(min_carriage_width, maxInVec(mount_spacing)+10);
carriage_length = v_wheel_spacing+wheel_edge_inset*2;
carriage_height = 7;

h_wheel_spacing = carriage_width-wheel_edge_inset*2;

echo("Carriage Width: ", carriage_width);
echo("Carriage Length: ", carriage_length);


//[x,y,size]
wheel_holes = [
				  [carriage_width/2-h_wheel_spacing/2, carriage_length/2+v_wheel_spacing/2,vslot_wheel_eccentric], //eccentric
				  [carriage_width/2+h_wheel_spacing/2, carriage_length/2+v_wheel_spacing/2,vslot_wheel_eccentric],//eccentric
				  [carriage_width/2-h_wheel_spacing/2, carriage_length/2-v_wheel_spacing/2, vslot_wheel_hole],
				  [carriage_width/2+h_wheel_spacing/2, carriage_length/2-v_wheel_spacing/2, vslot_wheel_hole]
				];

//tensioner_holes_y=[carriage_length/2-1, carriage_length/2+min_beltbearing_height/2];
//tensioner_holes_x=[-6+10/2, carriage_width+6-10/2];
//tensioner_length = 11;


module x_carriage(){

	x_carriage_bottom();
	translate([0,0,carriage_height+6.35+10.23+6.35])
		x_carriage_top();

}


module illustration(){


	//vslot x-axis
	translate([-20, carriage_length/2-20/2, carriage_height+6.35+10.23/2-20/2])
		cube([40+carriage_width, 20,20]);


	//belts front
		translate([-20, carriage_length/2+m4_washer_thickness+flange_thickness, carriage_height+6.35+10.23/2-20/2-5-GT2_belt_thickness])		
			cube([20, GT2_belt_width,GT2_belt_thickness]);

		translate([carriage_width, carriage_length/2-m4_washer_thickness-belt_bearing[2]+flange_thickness, carriage_height+6.35+10.23/2-20/2-5-GT2_belt_thickness])		
			cube([20, GT2_belt_width,GT2_belt_thickness]);


	//wheels
	//23.89 & 10.23
	color("red"){
		//for(p=wheel_holes){
		for(i=[0:number_wheels-1]){

			translate([wheel_holes[i][0], wheel_holes[i][1], carriage_height]){
				
				if(number_wheels == 3 && i==2){
					translate([h_wheel_spacing/2,0,0])
						cylinder(d=8, h=6.35, $fn=60);//spacer/eccentric spacer
					translate([h_wheel_spacing/2,0,6.35]) 
						cylinder(d=23.89, h=10.23, $fn=30);
					translate([h_wheel_spacing/2,0,6.35+10.23])
						cylinder(d=8, h=6.35, $fn=60);//spacer/eccentric spacer
				}else {
					cylinder(d=8, h=6.35, $fn=60);//spacer/eccentric spacer
					translate([0,0,6.35]) cylinder(d=23.89, h=10.23, $fn=30);
					translate([0,0,6.35+10.23])cylinder(d=8, h=6.35, $fn=60);//spacer/eccentric spacer

				}
			}
		}

	}

}

module x_carriage_bottom(){

	difference(){
		union(){
			x_carriage_main();
			create_accessory_mounts();
		}

		cut_mounting_holes();
		cut_belt_holes();
	}

}
/*
module x_carriage_top_clamps(){
	intersection(){
		x_carriage_top(clamps=true);
		translate([0,0,0.2])clamp_cutter();
	}

}*/



module x_carriage_top(){

	union(){
		difference(){
			union(){
				x_carriage_main();
				
				translate([carriage_width/2-4-4, carriage_length/2-min_beltbearing_height/2-8,carriage_height])
					cube_fillet([8+8,min_beltbearing_height+6+8, 11], top=[6,0,6,0]);
			
				//clamp runway (belts will want to pull clamp downwards)
				translate([-6, carriage_length/2-min_beltbearing_height/2-3,carriage_height])
					cube_fillet([carriage_width+12,min_beltbearing_height+4, 3], top=[2,0,2,0]);



				/*translate([carriage_width/2-4-4, carriage_length/2-min_beltbearing_height/2-8,carriage_height])
					cube_fillet([16,5+4, 11], top=[3,0,3,0]);

				translate([carriage_width/2-4-4, carriage_length/2+min_beltbearing_height/2-3,carriage_height])
					cube_fillet([16,5+4, 11], top=[3,0,3,0]);*/

				create_accessory_mounts();

			}	
			cut_belt_holes(carriage_top=true);
			cut_tensioner_holes();
		}
	}
}


	
module belt_clamp(){

	t_length = min_beltbearing_height+6;


	belt_y=
				[t_length/2+m4_washer_thickness+flange_thickness-0.4, //top
				t_length/2-m4_washer_thickness-belt_bearing[2]+flange_thickness-0.4]//bottom
		;
	
	extra=3;

	difference(){
		hull(){
			translate([0,-extra/2,0])cube_fillet([6, t_length+extra, 8], top=[3,0,3,0], bottom=[3,0,3,0]);
			
			translate([0,4,8]) cube_fillet([6,min_beltbearing_height-1.5, 7], top=[3,0,3,0]);


		}


		for(y=[0,1]){
			translate([-0.1, belt_y[y]+1, 8/2-(GT2_belt_thickness*2-GT2_belt_tooth_height)/2-0.2])
				cube([6.2, 0.4+GT2_belt_width+0.4, GT2_belt_thickness*2-GT2_belt_tooth_height+0.4]);

				translate([-0.1, belt_y[y]+1+y*-2, 8+7/2-2])belt(len=7, width=GT2_belt_width+3, top=0, extra_thickness=0);
				//slot for belt
				translate([-0.1, belt_y[y]+1+y*-4, 8+7/2+1-2.3])cube([7,GT2_belt_width+5, GT2_belt_thickness-GT2_belt_tooth_height+0.1]);
					


		}
	
		//tensioner hole
		//translate([clamp_len-8, clamp_height/2, clamp_wid/2]) rotate([0,90,0])cylinder(d=M3, h=8.2, $fn=60);	
	
		
		translate([-0.1, 2.5,8/2]){
			rotate([0,90,0])cylinder(d=M3, h=10, $fn=60);
			rotate([0,90,0])cylinder(d=6.6, h=3, $fn=6);//nuttrap
		}
/*
		translate([-0.1, t_length/2-0.5,8/2]){ //middle
			rotate([0,90,0])cylinder(d=M3, h=10, $fn=60);
			rotate([0,90,0])cylinder(d=6.6, h=3, $fn=6); //nuttrap
		}
*/
		
		translate([-0.1, t_length-2.5,8/2]){
			rotate([0,90,0])cylinder(d=M3, h=10, $fn=60);
			rotate([0,90,0])cylinder(d=6.6, h=3, $fn=6); //nuttrap
		}

	
	} // end difference
	

} //end module
	

module cut_tensioner_holes(){

	//tensioner
	padding = 1;

	h = carriage_height+2+GT2_belt_thickness;


	//pos_y=[carriage_length/2-m4_washer_thickness-belt_bearing[2]+flange_thickness+GT2_belt_width-clamp_wid-padding, carriage_length/2+m4_washer_thickness+flange_thickness-padding];// top an bottom

	//pos_x=[-6.1, carriage_width+6-10.1];//left and right

	for(x=[0,1]){ //left and right
			//middle
			//translate([carriage_width/2-8-0.1+x*(16.1-6), carriage_length/2-1,carriage_height+11/2+2])
				//rotate([0,90,0])cylinder(d=M3, h=6+x*0.1, $fn=60);


		for(y=[0,1]){ //top and bottom
		
			translate([carriage_width/2-8-0.1+x*(16.1-6), carriage_length/2-min_beltbearing_height/2-4+2.5+y*(min_beltbearing_height+6-3-3+1),carriage_height+11/2+2])
				rotate([0,90,0])cylinder(d=3.2, h=6+x*0.1, $fn=60);
		}			

	}//end for x
}

module x_carriage_main(){

	difference(){
		hull(){
			cube([carriage_width, carriage_length, carriage_height]);
			translate([-6,carriage_length/2-min_beltbearing_height/2-4,0])cube_fillet([6, min_beltbearing_height+8, carriage_height], top=[0,0,0,0]);
			translate([carriage_width,carriage_length/2-min_beltbearing_height/2-4,0])cube_fillet([6, min_beltbearing_height+8, carriage_height],top=[0,0,0,0]);

		}//end hull
		cut_wheel_holes();

	}//end difference

}



module cut_belt_holes(carriage_top=false){

	//6.35 = height of eccentric spacer
	//10.23 = height of wheel
	fw = 20; // frame width
	
	
	edc = vslot_wheel_spacer_length+vslot_wheel[1]/2; //extra distance from carriage to center of v-slot
	bhp = 0.6; //belt hole padding
	bc = x_belt_clearance; //belt clearance from vslot (needs to be the same as in xyblock)


	z_belt_height = (carriage_top==false)?(carriage_height+edc-fw/2-5-GT2_belt_thickness-bhp) : (-edc+fw/2+5-bhp);

	x_offset = (carriage_top==true)? 10:0; //offest for top to cater for tensioners

	
belt_y=[
				[carriage_length/2+m4_washer_thickness+flange_thickness-0.4], //top
				[carriage_length/2-m4_washer_thickness-belt_bearing[2]+flange_thickness-0.4]//bottom
			];//end belts


	belt_x = [ [-6.1+x_offset, 0, -x_offset], //pos, offset for wraparound
			    [carriage_width+6-x_offset, -6+1, 0.1]
			  ]; 


	for(i=[0,1]){ //left and right
		for(y_pos = belt_y){ //top and bottom
			translate([belt_x[i][0], y_pos[0], z_belt_height]){
				if(carriage_top==true){
					translate([belt_x[i][2],0,-z_belt_height-0.1])cube([x_offset,GT2_belt_width+0.4, GT2_belt_thickness+0.6+z_belt_height+0.1]);
					if(i==0){ //left
						translate([-9,0,6])scale([3.5,1,1.2]) quarter_ring(pos=i, d=10);
					} else { //right
						translate([+9,0,6])scale([3.5,1,1.2]) quarter_ring(pos=i, d=10);
					}	

					//cuts for tensioner// +11/2-GT2_belt_thickness-0.2
					translate([-belt_x[i][0]-6.1,0,-z_belt_height+carriage_height])cube([carriage_width+12.2,GT2_belt_width+0.4, GT2_belt_thickness*2+0.4+0.1]);


				} else {

					//translate([0,0,6]) quarter_ring(pos=i);
					translate([-6*i,0,-z_belt_height+carriage_height+edc-fw/2-5-8]) cube([6,GT2_belt_width+0.2, 8]);
					translate([5-i*12.5,0,-z_belt_height]) cube([2.5,GT2_belt_width+0.2, carriage_height+0.2]);



				}
				if(carriage_top==false){
					//cutout on top to wrap around
					translate([belt_x[i][1],0,-z_belt_height+carriage_height-GT2_belt_thickness])
						cube([5, GT2_belt_width+0.2,GT2_belt_thickness+0.6]);
				}
			}
		}	
	}
}

module quarter_ring(pos=0, d=12){
	intersection(){
		difference(){
			rotate([-90,0,0])cylinder(d=d, h=GT2_belt_width+0.2, $fn=60);
			translate([0,0,-0.1])rotate([-90,0,0])cylinder(d=d-GT2_belt_thickness*2-0.6*2, h=GT2_belt_width+0.2, $fn=60);
		}
		translate([-pos*d/2,0,-12/2]) cube([d/2, GT2_belt_width+0.2, d/2]);	
	}

}

module create_accessory_mounts(){
	for(x=[carriage_width/2-25/2, carriage_width/2+25/2]){
    	difference() {
      		// Top accessory mounting holes
      		translate([x,carriage_length+1.5,0]) cylinder(r=1.7+2, h=carriage_height, $fn=32);
      		translate([x,carriage_length+1.5,0]) cylinder(r=1.7, h=20, $fn=32, center=true);
   		 }
	}
}

module cut_mounting_holes(){

	for(h=mount_spacing){
		for(x=[carriage_width/2-h/2, carriage_width/2+h/2]){
			translate([x, carriage_length/2, -0.1]){
				cylinder(d=mount_diameter, h=carriage_height+0.2, $fn=30);
				translate([0,0,carriage_height-3+0.1])cylinder(r=3.3, h=3.1, $fn=6);//nut traps
			} 

		}
	}

	//accessories mouting holes 
	for(x=[carriage_width/2-25/2, carriage_width/2+25/2]){
		translate([x,carriage_length+1.5,8]) cylinder(r=1.7+2, h=20, $fn=32);
  			translate([x,carriage_length+1.5,0]) cylinder(r=1.7, h=20, $fn=32);
	}

}

module cut_wheel_holes(){
	//wheel holes
	for(i=[0:number_wheels-1]){
		//echo(i, wheel_holes[i]);

		translate([wheel_holes[i][0], wheel_holes[i][1], -0.1]){
			
			if(number_wheels == 3 && i==2){
				translate([h_wheel_spacing/2,0,0])
					cylinder(d=wheel_holes[i][2], h=carriage_height+0.2, $fn=30);
			}else {
					cylinder(d=wheel_holes[i][2], h=carriage_height+0.2, $fn=30);
			}
		}
	}
}




module belt(len, width, top=0, extra_thickness=0){

	belt_thickness = GT2_belt_thickness-GT2_belt_tooth_height;

    if (top == 1) {
		translate([0, 0, 0]) maketeeth(len=len, width=width);
    	translate([0,0,-extra_thickness])
			cube([ len + 0.02, width,belt_thickness+extra_thickness]);
    
    } else {
	   translate([0, 0, GT2_belt_thickness-2]) maketeeth(len=len, width=width);
		translate([0,0,GT2_belt_tooth_height])
 		   	cube([ len + 0.02, width,belt_thickness+extra_thickness]);

	}
}


module maketeeth(len, width, tooth_height=2){
    for (i = [0:len/GT2_belt_pitch]) {
		translate([i*GT2_belt_pitch,0,0]) 
			cube([GT2_belt_pitch*GT2_belt_tooth_ratio, width, tooth_height], center = false);
    }
}

//max(vec) returns undef in 2014.03, using adaption of nopheads solution from: https://github.com/openscad/openscad/issues/738
function maxInVec(v, i = 0) = ((i + 1) < len(v)) ?max(maxInVec(v, i + 1),v[i]):v[i];