// by MegaSaturnv 2020-12-05

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
PLATE_X = 48;
PLATE_Y = 48;
PLATE_Z = 3;

CORNER_ROUNDING = 5;

SCREW_HOLE_Z = 2.5;
SCREW_HOLE_LENGTH = 10;
SCREW_HOLE_WIDTH = 8;
SCREW_HOLE_EDGE_THICKNESS = 1.4;
SCREW_HOLE_1_X = 7;
SCREW_HOLE_1_Y = 10;
SCREW_HOLE_2_X = 8;
SCREW_HOLE_2_Y = 37;

/* [Advanced] */
//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;


/////////////
// Modules //
/////////////
module oval(innerDiameter, outerDiameter, length, height, hollow=true) {
	translate([(outerDiameter-length)/2, 0, 0])	difference() {
		union() {
			cylinder(r=outerDiameter/2, h=height);
			translate([length-outerDiameter, 0, 0]) cylinder(r=outerDiameter/2, h=height);
			translate([0, -outerDiameter/2, 0]) cube([length-outerDiameter, outerDiameter, height]);
		}
		if (hollow) {
			translate([0, 0, -0.005])cylinder(r=innerDiameter/2, h=height+0.01);
			translate([length-innerDiameter-(outerDiameter-innerDiameter), 0, -0.005]) cylinder(r=innerDiameter/2, h=height+0.01);
			translate([0, -innerDiameter/2, -0.005]) cube([length-innerDiameter-(outerDiameter-innerDiameter), innerDiameter, height+0.01]);
		}
	}
}

module roundedCorner(sideLength=1, thickness=1) {
	difference() {
		cube([sideLength, sideLength, thickness]);
		translate([sideLength, sideLength, 0]) cylinder(r=sideLength, h=thickness);
	}
}


////////////////
// Main Model //
////////////////
difference() {
	cube([PLATE_X, PLATE_Y, PLATE_Z]);
	translate([SCREW_HOLE_1_X, SCREW_HOLE_1_Y, 0]) oval(SCREW_HOLE_WIDTH, SCREW_HOLE_WIDTH, SCREW_HOLE_LENGTH, PLATE_Z, false);
	translate([SCREW_HOLE_2_X, SCREW_HOLE_2_Y, 0]) rotate([0,0,90]) oval(SCREW_HOLE_WIDTH, SCREW_HOLE_WIDTH, SCREW_HOLE_LENGTH, PLATE_Z, false);
	roundedCorner(CORNER_ROUNDING, PLATE_Z);
	translate([PLATE_X, 0, 0]) rotate([0, 0, 90]) roundedCorner(CORNER_ROUNDING, PLATE_Z);
	translate([PLATE_X, PLATE_Y, 0]) rotate([0, 0, 180]) roundedCorner(CORNER_ROUNDING, PLATE_Z);
	translate([0, PLATE_Y, 0]) rotate([0, 0, 270]) roundedCorner(CORNER_ROUNDING, PLATE_Z);
}
translate([SCREW_HOLE_1_X, SCREW_HOLE_1_Y, 0]) oval(SCREW_HOLE_WIDTH-SCREW_HOLE_EDGE_THICKNESS*2,SCREW_HOLE_WIDTH,SCREW_HOLE_LENGTH,PLATE_Z+SCREW_HOLE_Z,true);
translate([SCREW_HOLE_2_X, SCREW_HOLE_2_Y, 0]) rotate([0,0,90]) oval(SCREW_HOLE_WIDTH-SCREW_HOLE_EDGE_THICKNESS*2,SCREW_HOLE_WIDTH,SCREW_HOLE_LENGTH,PLATE_Z+SCREW_HOLE_Z,true);