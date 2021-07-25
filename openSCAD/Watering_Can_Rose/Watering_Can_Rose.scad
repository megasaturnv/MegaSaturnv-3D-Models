// by MegaSaturnv 2021-06-27

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
WATERING_CAN_SPOUT_DIAMETER = 19;
WATERING_CAN_SPOUT_DIAMETER_TAPERING = 2;
WALL_THICKNESS = 2.3;

/* [Advanced] */
WATERING_CAN_SPOUT_LENGTH = 15;

ROSE_LENGTH = 30;
ROSE_DIAMETER = 60;

ROSE_HOLES_DIAMETER = 1.6;

ROSE_HOLES_1_QUANTITY = 6;
ROSE_HOLES_2_QUANTITY = 12;
ROSE_HOLES_3_QUANTITY = 18;
ROSE_HOLES_4_QUANTITY = 24;

ROSE_HOLES_1_DISTANCE = 5;
ROSE_HOLES_2_DISTANCE = 12;
ROSE_HOLES_3_DISTANCE = 19;
ROSE_HOLES_4_DISTANCE = 26;

ROSE_HOLES_1_ANGLE = 10;
ROSE_HOLES_2_ANGLE = 20;
ROSE_HOLES_3_ANGLE = 30;
ROSE_HOLES_4_ANGLE = 40;

//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;

/////////////
// Modules //
/////////////
module roseHoles(diameter, height, quantity, distance, angle) {
	for (i = [1:quantity]) {
		rotate([0, 0, (360/quantity)*i]) translate([distance, 0, 0]) rotate([0, -angle, 0]) translate([0, 0, -WALL_THICKNESS*3]) cylinder(d=diameter, h=WALL_THICKNESS*7);
	}
}

module rose() {
	difference() {
		union() {
			// Rose head
			cylinder(d=ROSE_DIAMETER+WALL_THICKNESS, h=WALL_THICKNESS);

			// Cone
			translate([0, 0, WALL_THICKNESS]) cylinder(d1=ROSE_DIAMETER+WALL_THICKNESS, d2=WATERING_CAN_SPOUT_DIAMETER+WALL_THICKNESS, h=ROSE_LENGTH);

			// Spout fitting
			translate([0, 0, ROSE_LENGTH]) cylinder(d=WATERING_CAN_SPOUT_DIAMETER+WALL_THICKNESS, h=WATERING_CAN_SPOUT_LENGTH);
		}
		// Rose head holes
		translate([0, 0, -0.01]) roseHoles(ROSE_HOLES_DIAMETER, WALL_THICKNESS, ROSE_HOLES_1_QUANTITY, ROSE_HOLES_1_DISTANCE, ROSE_HOLES_1_ANGLE);
		translate([0, 0, -0.01]) roseHoles(ROSE_HOLES_DIAMETER, WALL_THICKNESS, ROSE_HOLES_2_QUANTITY, ROSE_HOLES_2_DISTANCE, ROSE_HOLES_2_ANGLE);
		translate([0, 0, -0.01]) roseHoles(ROSE_HOLES_DIAMETER, WALL_THICKNESS, ROSE_HOLES_3_QUANTITY, ROSE_HOLES_3_DISTANCE, ROSE_HOLES_3_ANGLE);
		translate([0, 0, -0.01]) roseHoles(ROSE_HOLES_DIAMETER, WALL_THICKNESS, ROSE_HOLES_4_QUANTITY, ROSE_HOLES_4_DISTANCE, ROSE_HOLES_4_ANGLE);
		
		// Cone
		translate([0, 0, WALL_THICKNESS-0.01]) cylinder(d1=ROSE_DIAMETER-WATERING_CAN_SPOUT_DIAMETER_TAPERING, d2=WATERING_CAN_SPOUT_DIAMETER-WATERING_CAN_SPOUT_DIAMETER_TAPERING, h=ROSE_LENGTH+0.02);

		// Spout fitting
		translate([0, 0, WALL_THICKNESS+ROSE_LENGTH-0.01]) cylinder(d1=WATERING_CAN_SPOUT_DIAMETER-WATERING_CAN_SPOUT_DIAMETER_TAPERING, d2=WATERING_CAN_SPOUT_DIAMETER, h=WATERING_CAN_SPOUT_LENGTH+0.02);
	}
}
////////////////
// Main Model //
////////////////
rose();