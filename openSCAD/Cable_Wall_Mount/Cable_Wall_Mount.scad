// by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Diameter of the cable
CABLE_DIAMETER = 7;

//Diameter of the screw used
SCREW_HOLE_DIAMETER = 4.1;

//Set to false to use a single screw on one side, rather than two (one on each side)
TWO_SCREWS = true;

//Change this to enable/disable counter-sinking
COUNTER_SINKING = true;

//Quantity of mounts to print. They will be stacked on top of each other for printing
MOUNT_QUANTITY = 4;


/* [Advanced] */
//Thickness of the plastic printed for the mount
MOUNT_THICKNESS = 2;

//Reduce the height given to the mounted cable. Used to grip the cable against the wall.
CABLE_REDUCED_HEIGHT = 1;

//Make the arch part of the base. Useful for small cable sizes, but may obscure the screw hole. Increase SCREW_HOLE_MARGIN below if needed (variable may not be visible in customizer and only seen in OpenSCAD because it is a calculated value)
ARCH_PART_OF_BASE = false;

//Margin around each screw hole. Default is SCREW_HOLE_DIAMETER + 2mm (good for counter-sinking)
SCREW_HOLE_MARGIN = SCREW_HOLE_DIAMETER+2;

//Give extra thickness to the screw holes. Useful for strength and screws that are too long. This is in addition to MOUNT_THICKNESS
SCREW_HOLE_EXTRA_THICKNESS = 1;

//Spacing between the stacked prints. Applies when printing multiple, specified by MOUNT_QUANTITY
MOUNT_QUANTITY_SPACING = 0.2;

//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;


//////////////////
// Calculations //
//////////////////
baseLength = SCREW_HOLE_DIAMETER+SCREW_HOLE_MARGIN;
baseWidth = SCREW_HOLE_DIAMETER+SCREW_HOLE_MARGIN;


/////////////
// Modules //
/////////////
module mountBase(Arg_baseHeight, Arg_screwDiameter, Arg_screwHoleMargin) {
	difference() {
		cube([Arg_baseHeight, Arg_screwDiameter+Arg_screwHoleMargin, Arg_screwDiameter+Arg_screwHoleMargin]);
		translate([-0.1, (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d=Arg_screwDiameter, h=Arg_baseHeight+0.2);
		if (COUNTER_SINKING) {
			translate([-0.1, (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+Arg_screwHoleMargin/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d1=0, d2=Arg_screwDiameter*2, h=Arg_baseHeight+0.2);
		}
	}
}

module mountArch(Arg_cableDiameter, Arg_width, Arg_thickness, Arg_reducedHight=0) {
	translate([(Arg_cableDiameter/2)-CABLE_REDUCED_HEIGHT, (Arg_cableDiameter/2)+Arg_thickness, 0]) difference() {
		difference() {
			cylinder(d=Arg_cableDiameter+(2*Arg_thickness), h=Arg_width);
			translate([0, 0, -0.1]) cylinder(d=Arg_cableDiameter, h=Arg_width+0.2);
		}
		translate([(Arg_cableDiameter/-2)-Arg_thickness, (Arg_cableDiameter/-2)-Arg_thickness, -0.1]) cube([(Arg_cableDiameter/2)+Arg_thickness, Arg_cableDiameter+(2*Arg_thickness), Arg_width+0.2]);
	}
	cube([(Arg_cableDiameter/2)-Arg_reducedHight, Arg_thickness, Arg_width]);
	translate([0, Arg_cableDiameter+Arg_thickness, 0]) cube([(Arg_cableDiameter/2)-Arg_reducedHight, Arg_thickness, Arg_width]);
}

module mountBracket() {
	union() {
		//Base 1
		mountBase(MOUNT_THICKNESS+SCREW_HOLE_EXTRA_THICKNESS, SCREW_HOLE_DIAMETER, SCREW_HOLE_MARGIN);

		//Base 2
		if (TWO_SCREWS) {
			if (ARCH_PART_OF_BASE) {
				translate([0, baseLength+CABLE_DIAMETER, 0]) mountBase(MOUNT_THICKNESS+SCREW_HOLE_EXTRA_THICKNESS, SCREW_HOLE_DIAMETER, SCREW_HOLE_MARGIN);
			} else {
				translate([0, baseLength+CABLE_DIAMETER+(2*MOUNT_THICKNESS)-0.2, 0]) mountBase(MOUNT_THICKNESS+SCREW_HOLE_EXTRA_THICKNESS, SCREW_HOLE_DIAMETER, SCREW_HOLE_MARGIN);
			}
		}

		//Arch
		if (ARCH_PART_OF_BASE) {
			translate([0, baseLength-MOUNT_THICKNESS, 0]) mountArch(CABLE_DIAMETER, baseWidth, MOUNT_THICKNESS, CABLE_REDUCED_HEIGHT);
		} else {
			translate([0, baseLength-0.1, 0]) mountArch(CABLE_DIAMETER, baseWidth, MOUNT_THICKNESS, CABLE_REDUCED_HEIGHT);
		}
	}
}


////////////////
// Main Model //
////////////////
rotate([0, 0, 270])
for (i=[0:MOUNT_QUANTITY-1]) {
	translate([0, 0, i*(baseWidth + MOUNT_QUANTITY_SPACING)]) mountBracket();
}
