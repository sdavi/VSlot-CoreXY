//Author:sdavi
//Based on the openbuilds corner connector


module vslot_corner_connector(){

	difference(){
	
		rotate([90,0,0])linear_extrude(height=20 ,center=false, convexity=10, twist=0, slices=20, scale=1.0){
			polygon( points=[[0,0],[20,0],[20,20],[0,0]] );
		}	
	
		translate([10,-10,-0.1]) {
			cylinder(d=6.5, h=20, $fn=60);
			translate([0,0,4.1])cylinder(d=10, h=20, $fn=60);
		}
		translate([0,-10,10]){
			rotate([0,90,0])cylinder(d=6.5, h=20.2, $fn=60);
			rotate([0,90,0])cylinder(d=10, h=20-4, $fn=60);
	
		}
	}
}