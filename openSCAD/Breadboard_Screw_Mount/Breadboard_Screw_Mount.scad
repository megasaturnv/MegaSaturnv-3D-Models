// by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Thickness / height of the mount (Z axis)
SCREW_MOUNT_THICKNESS = 8.5;
//SCREW_MOUNT_THICKNESS = 13;

//Diameter of the screw hole
SCREW_HOLE_DIAMETER = 4.2;

//Distance between the outside of the screw hole and the edge of the mounting plate
SCREW_HOLE_MARGIN = 8.25;

//Enable countersinking on the screw hole
COUNTERSINKING = true;

//Adjust the depth of the countersinking
COUNTERSINKING_Z_ADJUSTMENT = 0.5;
//COUNTERSINKING_Z_ADJUSTMENT = 4;

/* [Advanced] */
//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;

//Various Breadboard Trapezium Connector Dimensions
TRAPEZIUM_LARGER_WIDTH = 4.4;

//Various Breadboard Trapezium Connector Dimensions
TRAPEZIUM_SMALLER_WIDTH = 4.0;

//Various Breadboard Trapezium Connector Dimensions
TRAPEZIUM_HEIGHT = 1.5;

//Various Breadboard Trapezium Connector Dimensions
TRAPEZIUM_EXTRUDE_HEIGHT = 6.5;


//////////////////
// Calculations //
//////////////////
mountWidth = SCREW_HOLE_DIAMETER+SCREW_HOLE_MARGIN*2;


/////////////
// Modules //
/////////////
module mountHole(Arg_baseHeight, Arg_screwDiameter, Arg_screwHoleMargin, Arg_counterSinking=true, Arg_invert=false) {
	difference() {
		if (Arg_invert) cube([Arg_baseHeight, Arg_screwDiameter+Arg_screwHoleMargin, Arg_screwDiameter+Arg_screwHoleMargin]);
		difference() {
			cube([Arg_baseHeight, Arg_screwDiameter+Arg_screwHoleMargin, Arg_screwDiameter+Arg_screwHoleMargin]);
			translate([-0.1, (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d=Arg_screwDiameter, h=Arg_baseHeight+0.2);
			if (Arg_counterSinking) {
				//translate([-0.1, (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d1=0, d2=Arg_screwDiameter*2, h=Arg_baseHeight+0.2);
				//translate([Arg_screwDiameter/2, (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d1=0, d2=Arg_screwDiameter*4, h=Arg_baseHeight+0.2);
				translate([Arg_screwDiameter/1 + COUNTERSINKING_Z_ADJUSTMENT, (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d1=0, d2=Arg_screwDiameter*6, h=Arg_baseHeight+0.2);
			}
		}
	}
}

module trapezium(Arg_largerWidth, Arg_smallerWidth, Arg_height) {
	points=[[0,0],[Arg_largerWidth,0],[(Arg_largerWidth+Arg_smallerWidth)/2,Arg_height],[(Arg_largerWidth-Arg_smallerWidth)/2,Arg_height]];
	path=[[3,0,1,2]];
	translate([-Arg_largerWidth/2, 0, 0]) polygon(points,path);
}


////////////////
// Main Model //
////////////////
union() {
	difference() {
		rotate([0, 270, 0]) mountHole(SCREW_MOUNT_THICKNESS, SCREW_HOLE_DIAMETER, SCREW_HOLE_MARGIN*2, COUNTERSINKING);
		translate([-mountWidth/2, mountWidth-TRAPEZIUM_HEIGHT, 0]) linear_extrude(TRAPEZIUM_EXTRUDE_HEIGHT) trapezium(TRAPEZIUM_LARGER_WIDTH, TRAPEZIUM_SMALLER_WIDTH, TRAPEZIUM_HEIGHT);
		translate([-mountWidth+TRAPEZIUM_HEIGHT, mountWidth/2, 0]) rotate([0, 0, 90]) linear_extrude(TRAPEZIUM_EXTRUDE_HEIGHT) trapezium(TRAPEZIUM_LARGER_WIDTH, TRAPEZIUM_SMALLER_WIDTH, TRAPEZIUM_HEIGHT);
	}
	translate([-mountWidth/2, -TRAPEZIUM_HEIGHT, 0]) linear_extrude(TRAPEZIUM_EXTRUDE_HEIGHT) trapezium(TRAPEZIUM_LARGER_WIDTH, TRAPEZIUM_SMALLER_WIDTH, TRAPEZIUM_HEIGHT);
	translate([TRAPEZIUM_HEIGHT, mountWidth/2, 0]) rotate([0, 0, 90]) linear_extrude(TRAPEZIUM_EXTRUDE_HEIGHT) trapezium(TRAPEZIUM_LARGER_WIDTH, TRAPEZIUM_SMALLER_WIDTH, TRAPEZIUM_HEIGHT);
}
