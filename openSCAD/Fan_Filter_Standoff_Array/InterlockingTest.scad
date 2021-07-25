// By MegaSaturnv 2021-03-02

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Thickness of the standoff
STANDOFF_HEIGHT = 5;

//Width or length of the standoff. Will be the fan size, which is usually one of the following: 40,50,60,70,80,92,120,140,200,220. Also determines the size of the dovetail joints
FAN_SIZE = 120;

//Round the corners of the standoff
ROUNDED_CORNERS = true;

//Dovetail joins are modified by this much to allow for tolerance
INTERLOCKING_TOLERANCE = 0.3;

/* [Advanced] */
ROUNDED_CORNERS_RADIUS = 6;

INTERLOCKING_A = FAN_SIZE/16;
INTERLOCKING_B = FAN_SIZE/8;
INTERLOCKING_H = FAN_SIZE/24;
INTERLOCKING_A_T = INTERLOCKING_A - (2*INTERLOCKING_TOLERANCE);
INTERLOCKING_B_T = INTERLOCKING_B - (2*INTERLOCKING_TOLERANCE);
INTERLOCKING_H_T = INTERLOCKING_H + INTERLOCKING_TOLERANCE;

//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;

/////////////
// Modules //
/////////////
module roundedCorner(sideLength=1, thickness=1, cylinderCenter=false) {
	if (cylinderCenter) { //Cylinder cutout is in the centre
		difference() {
			cube([sideLength, sideLength, thickness]);
			cylinder(r=sideLength, h=thickness);
		}
	} else {
		difference() { //Corner of the object is in the centre
			cube([sideLength, sideLength, thickness]);
			translate([sideLength, sideLength, 0]) cylinder(r=sideLength, h=thickness);
		}
	}
}

module isoscelesTrapezium(a, b, h, thickness, center=true) {
	if (center)	{
		translate([-b/2, 0, 0])
		linear_extrude (height=thickness)
		polygon(points=[[0,0],[b,0],[a/2+b/2,h],[b/2-a/2,h]]);
	} else {
		linear_extrude (height=thickness)
		polygon(points=[[0,0],[b,0],[a/2+b/2,h],[b/2-a/2,h]]);
	}
}

////////////////
// Main Model //
////////////////
difference() {POSITION_FACTOR = 12;
	union() {
		cube([FAN_SIZE/4, FAN_SIZE/8, STANDOFF_HEIGHT]);

		translate([FAN_SIZE/8, FAN_SIZE/8 + INTERLOCKING_H, 0]) rotate([0, 0, 180]) isoscelesTrapezium(INTERLOCKING_A_T, INTERLOCKING_B_T, INTERLOCKING_H, STANDOFF_HEIGHT);
	}

	if (ROUNDED_CORNERS) {
		translate([FAN_SIZE/4, FAN_SIZE/8, -0.01]) rotate([0, 0, 180]) roundedCorner(ROUNDED_CORNERS_RADIUS, STANDOFF_HEIGHT+0.02);
		translate([0, FAN_SIZE/8, -0.01]) rotate([0, 0, 270]) roundedCorner(ROUNDED_CORNERS_RADIUS, STANDOFF_HEIGHT+0.02);
		translate([FAN_SIZE/4, 0, -0.01]) rotate([0, 0, 90]) roundedCorner(ROUNDED_CORNERS_RADIUS, STANDOFF_HEIGHT+0.02);
		translate([0, 0, -0.01]) rotate([0, 0, 0]) roundedCorner(ROUNDED_CORNERS_RADIUS, STANDOFF_HEIGHT+0.02);
	}

	translate([FAN_SIZE/8, INTERLOCKING_H_T, -0.01]) rotate([0, 0, 180]) isoscelesTrapezium(INTERLOCKING_A, INTERLOCKING_B, INTERLOCKING_H_T+0.01, STANDOFF_HEIGHT+0.02);
}
