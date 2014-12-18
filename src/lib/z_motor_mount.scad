// z_ends
// Author: sdavi



include <../configuration.scad>
include <../dimensions.scad>


nema_mount_thickness = 10;
nema_mount_height = 30;

nema_padding = 3;
side_thickness=15;

frame_width=20; //20x20

z_motor_mount_height=nema_padding+nema17_height+nema_mount_thickness;
z_motor_mount_width = side_thickness+nema_padding+nema17_width+nema_padding+side_thickness;
z_motor_mount_length = frame_width+1+nema17_width;


shaft_center =  1+nema17_width/2;
echo("ShaftCenter: ", shaft_center);


echo("height: ", z_motor_mount_height);
echo("width: ", z_motor_mount_width);
echo("length: ", z_motor_mount_length);


bearing_mount();
//z_motor_end(single_piece=1);



module z_motor_end(single_piece=0){

	if(single_piece==1){
		translate([0,0,z_motor_mount_height])rotate([180,0,0])
			z_motor_end_single();
	} else {



		rotate([0,-90,-90])intersection(){
			translate([0,0,z_motor_mount_height])rotate([180,0,0])
				z_motor_end_main();
			translate([-0.1, -z_motor_mount_length-0.1, -0.1])
				cube([30.1, z_motor_mount_length+0.2, z_motor_mount_height+0.2]);

		}

		translate([5,0,z_motor_mount_width])rotate([0,90,90])intersection(){
			translate([0,0,z_motor_mount_height])rotate([180,0,0])
				z_motor_end_main();
			translate([z_motor_mount_width-30, -z_motor_mount_length-0.1, -0.1])
				cube([30.1, z_motor_mount_length+0.2, z_motor_mount_height+0.2]);

		}




	}
	
	

}



module z_motor_end_single(){
	union(){
		z_motor_end_main(single_piece=1);
		
		//add thin part to print without supports (drill out)
		for(x= [side_thickness/2, z_motor_mount_width-side_thickness/2]){
			
			// vertical screw
			translate([x,z_motor_mount_length-frame_width/2, 0]){
				//countersink to suit screw length				
				translate([0,0,frame_width+36])
					cylinder(d=12+1, h=0.2, $fn=60);
			}
		} //

	}

}

module z_motor_end_main(single_piece=0){
	
	rounded_corners = (single_piece==1)?[3,3,3,3]:[0,0,0,0]; //use rounded corners on the single piece
	
	difference(){	
		union(){
			cube_fillet([z_motor_mount_width, z_motor_mount_length, z_motor_mount_height], vertical=rounded_corners);
			//cube_fillet([z_length, nema_mount_thickness, nema_mount_height], vertical=[0,0,3,3], top=[0,3,0,3]);
		}

		//nema cutout;
		translate([side_thickness, -0.1,-0.1]) cube([nema_padding+nema17_width+nema_padding+0.1, nema17_width+1+0.1, nema_padding+nema17_height+0.1]);



		//cutout for frame
		translate([-0.1, z_motor_mount_length-20-0.1, -0.1])cube([z_motor_mount_width+0.2,20+0.2,20]);


		//nema holes
		translate([side_thickness+nema_padding+nema17_width/2, nema17_width/2, z_motor_mount_height-nema_mount_thickness-0.1]){
			cylinder(d=28, h=nema_mount_thickness+0.2, $fn=60);//central hole
			
			translate([-nema17_holes/2, -nema17_holes/2, 0]) cylinder(d=M3, h=nema_mount_thickness+0.2, $fn=60);
			translate([-nema17_holes/2, nema17_holes/2, 0]) cylinder(d=M3, h=nema_mount_thickness+0.2, $fn=60);
			translate([nema17_holes/2, -nema17_holes/2, 0]) cylinder(d=M3, h=nema_mount_thickness+0.2, $fn=60);
			translate([nema17_holes/2, nema17_holes/2, 0]) cylinder(d=M3, h=nema_mount_thickness+0.2, $fn=60);

/*			rotate([-90,0,0]) 
				cylinder(d=M3, h=nema_mount_thickness+0.4, $fn=60);
			translate([nema17_holes, 0,0]) rotate([-90,0,0]) 
				cylinder(d=M3, h=nema_mount_thickness+0.2, $fn=60);
			translate([nema17_holes/2, 0, nema17_holes/2]) rotate([-90,0,0])
				cylinder(d=28, h=nema_mount_thickness+0.2, $fn=60);// central nema hole
*/
		}


		//curved end
		translate([-0.1,-10, 0]) rotate([0,90,0])cylinder(d=60, h=z_motor_mount_width+0.2, $fn=60);		



		//21 height for screw horiz for 25mm screw;
		//36 depth for vert for 40mm screw


		//frame holes
		for(x= [side_thickness/2, z_motor_mount_width-side_thickness/2]){
			//horizontal screw
			translate([x,-0.1,frame_width/2 ]){
				rotate([-90,0,0])
					cylinder(d=frame_screw, h=z_motor_mount_length, $fn=60);
				//countersink to suit screw length
				rotate([-90,0,0])
					cylinder(d=11.5, h=z_motor_mount_length-frame_width-21, $fn=60);
				
			}

			// vertical screw
			translate([x,z_motor_mount_length-frame_width/2, 0]){
				cylinder(d=frame_screw, h=z_motor_mount_height, $fn=60);
				//countersink to suit screw length				
				translate([0,0,frame_width+36])
					cylinder(d=12, h=z_motor_mount_height, $fn=60);
			}
		} //end for loop
	} // end difference


} // end module


module bearing_mount(){

	bearing_end_length=BEARING_6300[1]+8 + 15+15; 
	bearing_end_width=20;
	bearing_end_height=20;



	difference(){
		union(){
			translate([shaft_center, 0,0]) 
				cylinder(d=BEARING_6300[1]+8, h=bearing_end_height, $fn=30);
			translate([0,-bearing_end_length/2,0])
				cube_fillet([bearing_end_width, bearing_end_length, bearing_end_height], vertical=[3,0,0,3]);
			
		}
	
		//center hole for rod
		translate([shaft_center,0,-0.1]) 
			cylinder(d=BEARING_6300[1]-3, h=bearing_end_height+0.2, $fn=30);
		
		//hole for bearing 6300z
		translate([shaft_center,0,bearing_end_height-BEARING_6300[2]]) 
			cylinder(d=BEARING_6300[1]+0.4, h=BEARING_6300[2]+0.1, $fn=30);
	
		//frame_holes
		translate([-0.1,-bearing_end_length/2+15/2, bearing_end_height/2]) 
			rotate([0,90,0])cylinder(d=frame_screw, h=bearing_end_width+0.2, $fn=30);
		translate([-0.1, bearing_end_length/2-15/2, bearing_end_height/2])
			rotate([0,90,0])cylinder(d=frame_screw, h=bearing_end_width+0.2, $fn=30);
		
	}

}


