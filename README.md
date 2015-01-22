CoreXY 3D Printer
==================

A v-slot 3D printer using the CoreXY configuration. Belt layout and z-axis is based on jand1122's https://github.com/jand1122/RepRap-XY and zelogik's https://github.com/zelogik/AluXY CoreXY 3D printer. 

X axis and Y-axis are using v-slot wheels and the Z-axis is using 12LMLUU. 

Frame Size: 400mm x 400mm x 500mm

Build Area (X x Y x Z): 210mm x 195mm x 240mm.  

![ScreenShot](/IMG_5496.jpg)

All source code is written using OpenSCAD.



Bill of Materials
==================

*Note: This list is only a rough guide and there may be some inconsistencies due to various changes over time.*

**Frame - 20x20 v-slot aluminium extrusions**
* 4x 500mm length
* 12x 360mm length
* Lots and lots of t-nuts 
* Fittings for corners (i.e. hidden 90deg bracket, brackets, printed brackets)
* Some drop-in t-nuts (for adding parts after frame is assembled)
* ??x M5 button cap bolt

**Z-axis**
* 2x 400mm length 12mm diameter smooth rod
* 2x LM12LUU linear bearing (12mm "long" bearing) - can also use 4x LM12UU (configured in settings, STLs are for long version)
* 1x 400mm TR10x2 Trapezoidal leadscrew (10mm diameter with 2mm pitch)
* 1x 10X2 flanged trapezoidal bronze nut
* 1x 5mmx10mm  coupler 
* 1x 6300Z bearing 
* 4x Double t-nut (or use 8 t-nuts)
* 4x 25mm M5 bolts (for z carriage)
* 4x 40mm M5 bolts (for z carriage)
* 8x 40mm M4 bolts (for z-carriage, screws can be longer)
* 6x 25mm M5 bolts (for z nut. 4 would probably be sufficient)
* 6x M5 nuts (for z nut)
* Lots of M5 washers
* 4x 15mm M3 bolt (to attach z nema motor)
* 8x 40mm M5 (for z rod holders)
* 2x 40mm M5 bolts (for z motor mount)
* 2x 30mm M5 (for z motor mount)
* 1x NEMA17 Stepper motor
* ??x t-nuts

**X & Y axis**
* 8x Solid V-Slot Wheel Kits
* 4x Eccentric Spacer
* 12x 45mm M5 bolts (for XY block)
* 2x NEMA17 stepper motors
* 3x Corner Fittings (printed or aluminium). 4 needed if not using the printed integrated endstop holder.
* Approx. 3-4m GT2 belt 
* 2x 20 tooth GT2 Pulley
* Lots of M4 washers
* Lots of M5 washers
* 4x M5 nuts
* 24x F624ZZ flanged bearings
* 24x 8mm M5 bolts (for idler plates)
* 8x 40mm M4 bolts (for idler bearings, screws can be longer)
* 12x M4 nuts
* 4x 60mm M4 bolts (for XY block idler bearings)
* 4x 30mm M5 bolts (for motor mounts)
* 8x 10mm M3 bolt (attach nema motors)
* ??x t-nuts

**X-Carriage**
* 4x Solid V-Slot Wheel Kits
* 4x Eccentric Spacer
* 4x 45mm M5 bolts
* 4x 25mm M3 bolt (for tensioner)
* 4x M3 nut (for tensioner)
* 2x M3 nut (to mount hotend)


Printed Parts
=============

* 1x y_motor_end.stl
* 1x z_motor_mount.stl
* 1x x-carriage.stl
* 1x x_carriage_tensioners.stl
* 2x z_carriage_outer.stl
* 1x z_carriage_inner(mirror).stl
* 1x z_carriage_inner.stl
* 1x z_bearing_mount.stl
* 1x z_rod_clamps.stl
* 2x y_idler_ends.stl
* 2x y_idler_ends_mirror.stl
* 2x xy_block.stl
* 8x belt_bearing_spacer.stl
 

Assembly Notes
==============

* There must be a washer on the outsides of the flange bearings to run smoothly (i.e washer->bearing->bearing->washer). 
* Use the notches on the eccentric spacers and make sure the front spacers line up with the back spacers for the v-slot wheel on the x-carriage. This will ensure the front and back are sitting correctly.
![ScreenShot](/IMG_5500.jpg)
* It helps to glue/melt in the nuts into the nut traps on the x-carriage. I glued mine in with JB-Weld.
* There is enough space to run a twist in the belt along the y-axis. This allows to run the back of the belt on the majority of the bearings.
* Belt layout diagram (H - bearings on top with spacer on bottom; L - bearings on bottom with spacer on top):
![ScreenShot](/BeltLayoutDiagram.png)

* Photo of z-axis assembly:
![ScreenShot](/IMG_5498.jpg)




**Notice: This is a work in progress. Use at your own risk! **

