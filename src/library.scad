//rounded cube Functions from: http://www.thingiverse.com/thing:38069


module cube_fillet(size,radius=-1,vertical,top,bottom,center=false,$fn=0){
    if (center) {
        cube_fillet_inside(size, radius, vertical, top, bottom, $fn=$fn);
    } else {
        translate([size[0]/2, size[1]/2, size[2]/2])
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn=$fn);
    }
}
module fillet(radius, height=100, $fn=60) {  
    //this creates negative of fillet,
    //i.e. thing to be substracted from object
    translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=$fn);
        }
}

module cube_negative_fillet(size,radius=-1,vertical, top,bottom,$fn=0){
    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i])
                translate([size[1-j[i]]/2, size[j[i]]/2, 0])
                    fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i])
                translate([size[1-j[i]]/2, size[j[i]]/2, 0])
                    fillet(vertical[i], size[2], $fn=$fn);

        }
        rotate([90*i, -90, 0])
            translate([size[2]/2, size[j[i]]/2, 0 ])
                fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0])
            translate([size[2]/2, size[j[i]]/2, 0])
                fillet(bottom[i], size[1-j[i]], $fn=$fn);
    }
}

module cube_fillet_inside(size,radius=-1,vertical,top,bottom,$fn=0){

    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn=$fn);
        }
    }
}
