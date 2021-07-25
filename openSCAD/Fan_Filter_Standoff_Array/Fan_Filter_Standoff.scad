// By MegaSaturnv 2021-03-02

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Thickness of the standoff
STANDOFF_HEIGHT = 5;

//Width or length of the standoff. Will be the fan size, which is usually one of the following: 40,50,60,70,80,92,120,140,200,220. Also determines the size of the dovetail joints
FAN_SIZE = 120;

//Diameter of the fan itself. Determines the size of the hole in the standoff to let air through
FAN_DIAMETER = 115;

//Distance between mounting screws. Measured centre-centre
SCREWS_DISTANCE = 105;

//Diameter of the mounting screw holes
SCREW_HOLE_DIAMETER = 5;

//Additional thickness given to the upper and right sides. Usually desired when interlocking with other fans and the filter is slightly larger than FAN_SIZE. Set to 0 to disable margin
EXTRA_MARGIN = 3;

//Round the corners of the standoff
ROUNDED_CORNERS = true;

//Add dovetail joints so adjacent prints can lock into each other
INTERLOCKING = true;

//Dovetail joins are modified by this much to allow for tolerance
INTERLOCKING_TOLERANCE = 0.3;

//Allows the use of a larger filter for a smaller fan. e.g. A 120mm fan filter on a 92mm fan
ADDITIONAL_SCREW_HOLES = false;

//Distance between the additional mounting screws. Measured centre-centre
ADDITIONAL_SCREWS_DISTANCE = 105;

//Quantity of mounts to print. They will be stacked on top of each other for printing
MOUNT_QUANTITY = 1;

/* [Advanced] */
//Spacing between the stacked prints. Applies when printing multiple, specified by MOUNT_QUANTITY
MOUNT_QUANTITY_SPACING = 0.2;

//Specifies how rounded the corners are
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
module drawAvatar(pxSize=2, thickness=2, center=true) {
    avatar = [
    " X X ",
    "XX XX",
    " XXX ",
    "  X  ",
    "X X X"];
    for (i = [0 : len(avatar)-1], j = [0 : len(avatar[i])-1]) {
        if (avatar[i][j] == "X") {
			if (center)	{
				translate([-(len(avatar)*pxSize)/2, -(len(avatar[0])*pxSize)/2, 0])
				translate([i*pxSize, j*pxSize, 0])
				cube([pxSize, pxSize, thickness]);
			} else {
				translate([i*pxSize, j*pxSize, 0])
				cube([pxSize, pxSize, thickness]);
			}
        }
    }
}

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
for (i=[0:MOUNT_QUANTITY-1]) {
	translate([0, 0, i*(STANDOFF_HEIGHT + MOUNT_QUANTITY_SPACING)])
	difference() {
		union() {
			translate([-FAN_SIZE/2, -FAN_SIZE/2, 0]) cube([FAN_SIZE+EXTRA_MARGIN, FAN_SIZE+EXTRA_MARGIN, STANDOFF_HEIGHT]);
			if (INTERLOCKING) {
				translate([FAN_SIZE/2 + EXTRA_MARGIN + INTERLOCKING_H, FAN_SIZE/4, 0]) rotate([0, 0, 90]) isoscelesTrapezium(INTERLOCKING_A_T, INTERLOCKING_B_T, INTERLOCKING_H, STANDOFF_HEIGHT); //Male. Right. +x +y/2
				translate([-FAN_SIZE/2 - INTERLOCKING_H, -FAN_SIZE/4, 0]) rotate([0, 0, 270]) isoscelesTrapezium(INTERLOCKING_A_T, INTERLOCKING_B_T, INTERLOCKING_H, STANDOFF_HEIGHT+0); //Male. Left. -x -y/2

				translate([FAN_SIZE/4, FAN_SIZE/2 + EXTRA_MARGIN + INTERLOCKING_H, 0]) rotate([0, 0, 180]) isoscelesTrapezium(INTERLOCKING_A_T, INTERLOCKING_B_T, INTERLOCKING_H, STANDOFF_HEIGHT); //Male. Top. +x/2 +y
				translate([-FAN_SIZE/4, FAN_SIZE/2 + EXTRA_MARGIN + INTERLOCKING_H, 0]) rotate([0, 0, 180]) isoscelesTrapezium(INTERLOCKING_A_T, INTERLOCKING_B_T, INTERLOCKING_H, STANDOFF_HEIGHT); //Male. Top. +x/2 +y
			}
		}



		translate([0, 0, -0.01]) cylinder(d=FAN_DIAMETER, h=STANDOFF_HEIGHT+0.02, $fn=384);

		for (i=[-2,2], j=[-2,2]) {
			translate([SCREWS_DISTANCE/i, SCREWS_DISTANCE/j, -0.01]) cylinder(d=SCREW_HOLE_DIAMETER, h=STANDOFF_HEIGHT+0.02);
		}

		if (ADDITIONAL_SCREW_HOLES) {
			translate([(ADDITIONAL_SCREWS_DISTANCE+SCREWS_DISTANCE)/4, (ADDITIONAL_SCREWS_DISTANCE+SCREWS_DISTANCE)/4, STANDOFF_HEIGHT-1]) rotate([0, 0, 270]) drawAvatar(FAN_SIZE/35, 1.01, true);
		} else {
			translate([SCREWS_DISTANCE/2, SCREWS_DISTANCE/2, STANDOFF_HEIGHT-1]) rotate([0, 0, 270]) drawAvatar(FAN_SIZE/35, 1.01, true);
		}

		if (ADDITIONAL_SCREW_HOLES) {
			for (i=[-2,2], j=[-2,2]) {
				translate([ADDITIONAL_SCREWS_DISTANCE/i, ADDITIONAL_SCREWS_DISTANCE/j, -0.01]) cylinder(d=SCREW_HOLE_DIAMETER, h=STANDOFF_HEIGHT+0.02);
			}
		}

		if (ROUNDED_CORNERS) {
			for (i=[0, 90, 180, 270]) {
				translate([EXTRA_MARGIN/2, EXTRA_MARGIN/2, -0.01]) rotate([0, 0, i]) translate([-FAN_SIZE/2 - EXTRA_MARGIN/2, -FAN_SIZE/2 - EXTRA_MARGIN/2, 0]) roundedCorner(ROUNDED_CORNERS_RADIUS, STANDOFF_HEIGHT+0.02);
			}
		}

		if (INTERLOCKING) {
			translate([FAN_SIZE/2 + EXTRA_MARGIN - INTERLOCKING_H_T, -FAN_SIZE/4, -0.01]) rotate([0, 0, 270]) isoscelesTrapezium(INTERLOCKING_A, INTERLOCKING_B, INTERLOCKING_H_T+0.01, STANDOFF_HEIGHT+0.02); //Female. Right. +x -y/2
			translate([-FAN_SIZE/2 + INTERLOCKING_H_T, FAN_SIZE/4, -0.01]) rotate([0, 0, 90]) isoscelesTrapezium(INTERLOCKING_A, INTERLOCKING_B, INTERLOCKING_H_T+0.01, STANDOFF_HEIGHT+0.02); //Female. Left. -x +y/2

			translate([FAN_SIZE/4, -FAN_SIZE/2 + INTERLOCKING_H_T, -0.01]) rotate([0, 0, 180]) isoscelesTrapezium(INTERLOCKING_A, INTERLOCKING_B, INTERLOCKING_H_T+0.01, STANDOFF_HEIGHT+0.02); //Female. Top. +x/2 +y
			translate([-FAN_SIZE/4, -FAN_SIZE/2 + INTERLOCKING_H_T, -0.01]) rotate([0, 0, 180]) isoscelesTrapezium(INTERLOCKING_A, INTERLOCKING_B, INTERLOCKING_H_T+0.01, STANDOFF_HEIGHT+0.02); //Female. Top. +x/2 +y
		}
	}
}