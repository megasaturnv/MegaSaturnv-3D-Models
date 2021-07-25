// by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Width of the power supply. You may wish to add 0.2-0.5mm here
POWER_SUPPLY_WIDTH = 65.6;
//Height of the power supply. Best to leave this measurement the same as the item which is being mounted
POWER_SUPPLY_HEIGHT = 46.8;

//Diameter of the screw used
SCREW_HOLE_DIAMETER = 4.4;
//Change this to enable/disable counter-sinking
COUNTER_SINKING = true;

//Custom text to put on the mounts
CUSTOM_INSCRIPTION = "Game Cube";
//Margin around the custom text incription. Use this to make the text fit if needed. If this value is too large it won't have an effect, so play around with it first in openscad.
CUSTOM_INSCRIPTION_MARGIN = 20;

//Quantity of mounts to print. They will be stacked on top of each other for printing
MOUNT_QUANTITY = 2;

/* [Advanced] */
//Thickness of the plastic for the power supply mount
POWER_SUPPLY_MOUNT_THICKNESS = 3;

//Margin around each screw hole. Default is SCREW_HOLE_DIAMETER + 2mm (good for counter-sinking)
SCREW_HOLE_MARGIN = SCREW_HOLE_DIAMETER+2;

//Give extra thickness to the screw holes. Useful for strength and screws that are too long. This is in addition to POWER_SUPPLY_MOUNT_THICKNESS
SCREW_HOLE_EXTRA_THICKNESS = 7;

//Spacing between the stacked prints. Applies when printing multiple, specified by MOUNT_QUANTITY
MOUNT_QUANTITY_SPACING = 0.2;

//Depth of the custom text incription into the plastic. 1x or 2x the nozzle diameter is fine
CUSTOM_INSCRIPTION_DEPTH = 0.8;


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
module mountBase(Arg_baseHeight, Arg_screwDiameter) {
	difference() {
		cube([Arg_baseHeight, Arg_screwDiameter+SCREW_HOLE_MARGIN, Arg_screwDiameter+SCREW_HOLE_MARGIN]);
		translate([-0.1, (Arg_screwDiameter+SCREW_HOLE_MARGIN/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+SCREW_HOLE_MARGIN/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d=Arg_screwDiameter, h=Arg_baseHeight+0.2);
		if (COUNTER_SINKING) {
			translate([-0.1, (Arg_screwDiameter+SCREW_HOLE_MARGIN/2)-(Arg_screwDiameter/2), (Arg_screwDiameter+SCREW_HOLE_MARGIN/2)-(Arg_screwDiameter/2)]) rotate([0, 90, 0]) cylinder(d1=0, d2=Arg_screwDiameter*2, h=Arg_baseHeight+0.2);
		}
	}
}

module mountHorizontal() {
	difference() {
		cube([POWER_SUPPLY_MOUNT_THICKNESS, POWER_SUPPLY_WIDTH, baseWidth]);
		translate([POWER_SUPPLY_MOUNT_THICKNESS-CUSTOM_INSCRIPTION_DEPTH, POWER_SUPPLY_WIDTH/2, baseWidth/2]) rotate([90, 0, 90]) linear_extrude(CUSTOM_INSCRIPTION_DEPTH+1, convexity = 4) resize([POWER_SUPPLY_WIDTH-CUSTOM_INSCRIPTION_MARGIN, 0], auto = true) text(CUSTOM_INSCRIPTION, halign = "center", valign = "center");


//linear_extrude(height=CUSTOM_INSCRIPTION_DEPTH+1) text(CUSTOM_INSCRIPTION, size=baseWidth-CUSTOM_INSCRIPTION_MARGIN);
	}
}

module mountBracket() {
	//Base 1
	mountBase(POWER_SUPPLY_MOUNT_THICKNESS+SCREW_HOLE_EXTRA_THICKNESS, SCREW_HOLE_DIAMETER);

	//Base 2
	translate([0, baseLength+POWER_SUPPLY_WIDTH+(POWER_SUPPLY_MOUNT_THICKNESS*2), 0]) mountBase(POWER_SUPPLY_MOUNT_THICKNESS+SCREW_HOLE_EXTRA_THICKNESS, SCREW_HOLE_DIAMETER);

	//Vertical Segment 1
	translate([0, baseLength, 0]) cube([POWER_SUPPLY_HEIGHT+POWER_SUPPLY_MOUNT_THICKNESS, POWER_SUPPLY_MOUNT_THICKNESS, baseWidth]);

	//Vertical Segment 2
	translate([0, baseLength+POWER_SUPPLY_WIDTH+POWER_SUPPLY_MOUNT_THICKNESS, 0]) cube([POWER_SUPPLY_HEIGHT+POWER_SUPPLY_MOUNT_THICKNESS, POWER_SUPPLY_MOUNT_THICKNESS, baseWidth]);

	//Horizontal Segment
	translate([POWER_SUPPLY_HEIGHT, baseLength+POWER_SUPPLY_MOUNT_THICKNESS, 0]) mountHorizontal();
}


////////////////
// Main Model //
////////////////
rotate([0, 0, 270])
for (i=[0:MOUNT_QUANTITY-1]) {
	translate([0, 0, i*(baseWidth + MOUNT_QUANTITY_SPACING)]) mountBracket();
}
