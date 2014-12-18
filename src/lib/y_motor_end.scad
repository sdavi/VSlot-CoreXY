// y_motor end
// Author: sdavi


//Motor Mount BoM
// M3 bolts
// 2x M5x?? bolts
// 1x NEMA17



include <../configuration.scad>
include <../dimensions.scad>
include <y_idler_ends.scad>


nema_mount_width = nema17_holes+11;
motor_mount_thickness = 4;



motor_mount();
%illustration();


module motor_mount(){

	nema_mount_thickness = 4;

	difference(){
		union(){
			translate([20,20+50-7,min_beltbearing_height+motor_mount_thickness*2-2-nema_mount_thickness]){
				cube([nema17_width, nema17_width+14,nema_mount_thickness]);
				translate([-20,0,0]) cube([20, nema17_width+14, 20+nema_mount_thickness]);
				support();
				translate([0,7+nema17_width+1,0]) support();
			}
		} // end union

		translate([20,20+50-7,min_beltbearing_height+motor_mount_thickness*2-2-nema_mount_thickness-0.1]){
				
			//frame screws (bottom)
			translate([-10,15,0])cylinder(d=frame_screw, h=20+nema_mount_thickness+0.2);				
			translate([-10,7+nema17_width+7-15,0])cylinder(d=frame_screw, h=20+nema_mount_thickness+0.2);	
		} // end translate
		

		translate([20+nema17_width/2,20+50+nema17_width/2,min_beltbearing_height+motor_mount_thickness*2-2-nema_mount_thickness-0.1]){
			cylinder(d=28, h=4.2, $fn=60); //central nema hole
	
			//nema holes.
			for(holes=[[-nema17_holes/2, -nema17_holes/2],
						 [-nema17_holes/2, nema17_holes/2],
						 [nema17_holes/2, nema17_holes/2], 
						 [nema17_holes/2, -nema17_holes/2]]){
				translate([holes[0], holes[1], 0])
					cylinder(d=M3, h=nema_mount_thickness+0.2, $fn=60);
			}// end for loop
		}// end translate
	} // end difference
}
	

module support(height=6, width=nema17_width){

	translate([0,height, 0])rotate([90,0,0])linear_extrude(height=height, slices = 20)
			polygon( points=[[0,0],
				[width,0],
              [20,20+motor_mount_thickness],
				[0,20+motor_mount_thickness], [0,0]] 
			);						


}




module illustration(){
		visualise_high = 0; //high (1) or low bearing (0)

//frames
			%color("grey")translate([0,0,-20]) cube([20,20,70]);
			%color("grey")%translate([0,0,y_block_total_height/2-10]) cube([100, 20,20]);
			%color("grey")%translate([0,0,y_block_total_height/2-10]) cube([20,150, 20]);

//nema17
		%color("yellow") rotate([0,180,0])
			translate([	-nema17_width/2-20,
							nema17_width/2+20+50,
							-(min_beltbearing_height+motor_mount_thickness*2)-46]) 
			nema17();	
			
		%translate([nema17_width/2+20,nema17_width/2+20+50,y_block_height+m4_washer_thickness+belt_bearing[2]/2 + visualise_high*(belt_bearing[2]+m4_washer_thickness*2)])
			pulley(bottom=visualise_high);

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


