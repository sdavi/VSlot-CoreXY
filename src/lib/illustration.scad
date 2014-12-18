// Illustrations
// Author: sdavi


include <../configuration.scad>
include <../dimensions.scad>

//i_linear_bearing([8,15,6]);
//i_radial_bearing([8,15,24]);
//smooth_rod(d=8, h=60);
//v_slot([20,20], h=50);


module i_linear_bearing(s=[1, 2, 3], $fn=30){////rod diameter,outer diameter, length

	difference(){
		cylinder(d=s[1], h=s[2], $fn=$fn);
		translate([0,0,-0.1])cylinder(d=s[0], h=s[2]+0.2, $fn=$fn);
	}
}

module i_radial_bearing(s=[1, 2, 3], $fn=30){////inner diameter,outer diameter, thickness
	i_linear_bearing(s=s);
}


module smooth_rod(d,h, $fn=30){

	cylinder(d=d, h=h, $fn=$fn);
}

module v_slot(s=[20,20], h=10){
	cube([s[0], s[1], h]);
}