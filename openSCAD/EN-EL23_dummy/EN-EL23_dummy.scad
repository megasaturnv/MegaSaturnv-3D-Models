// by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */

/* [Advanced] */
//Width of the EL-EL23 (X axis)
ENEL23_X = 35.0;
//Length of the EL-EL23 (Y axis)
ENEL23_Y = 10.5;
//Height of the EL-EL23 (Z axis)
ENEL23_Z = 47.2;

//Width of the contact (X axis)
ENEL23_CONTACT_X = 2.3;
//Length of the contact (Y axis)
ENEL23_CONTACT_Y = 3.5;
//How much the contact is recessed into the EN-EL23
ENEL23_CONTACT_Z = 1.0;

//Distance between left edge and centre of 1st contact
ENEL23_CONTACT_X_POSITION_1 = 22.5;
//Distance between left edge and centre of 2nd contact
ENEL23_CONTACT_X_POSITION_2 = 26.3;
//Distance between left edge and centre of 3nd contact
ENEL23_CONTACT_X_POSITION_3 = 30.1;

//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;



/////////////
// Modules //
/////////////
module ENEL23_dummy() {
	difference() {
		union() {
			//Main battery body
			translate([ENEL23_Y/2, ENEL23_Y/2, 0]) cylinder(r=ENEL23_Y/2, h=ENEL23_Z-2);
			translate([ENEL23_Y/2, 0, 0]) cube([ENEL23_X-ENEL23_Y, ENEL23_Y, ENEL23_Z-2]);
			translate([ENEL23_X - ENEL23_Y/2, ENEL23_Y/2, 0]) cylinder(r=ENEL23_Y/2, h=ENEL23_Z-2);
			//Cutaway at top
			translate([3, 1.5, ENEL23_Z-2]) cube([ENEL23_X-6, ENEL23_Y-3, 2]);
		}

		translate([0, ENEL23_Y/2, ENEL23_Z - ENEL23_CONTACT_Z]) {
			//Contact pads
			translate([ENEL23_CONTACT_X_POSITION_1 - ENEL23_CONTACT_X/2, -ENEL23_CONTACT_Y/2, 0]) cube([ENEL23_CONTACT_X, ENEL23_CONTACT_Y, ENEL23_CONTACT_Z]);
			translate([ENEL23_CONTACT_X_POSITION_2 - ENEL23_CONTACT_X/2, -ENEL23_CONTACT_Y/2, 0]) cube([ENEL23_CONTACT_X, ENEL23_CONTACT_Y, ENEL23_CONTACT_Z]);
			translate([ENEL23_CONTACT_X_POSITION_3 - ENEL23_CONTACT_X/2, -ENEL23_CONTACT_Y/2, 0]) cube([ENEL23_CONTACT_X, ENEL23_CONTACT_Y, ENEL23_CONTACT_Z]);

			//Contact wire end
			translate([ENEL23_CONTACT_X_POSITION_1, ENEL23_CONTACT_Y/2, -ENEL23_Z/6]) cylinder(r=ENEL23_CONTACT_X/2, h=ENEL23_Z/6);
			translate([ENEL23_CONTACT_X_POSITION_2, ENEL23_CONTACT_Y/2, -ENEL23_Z/6]) cylinder(r=ENEL23_CONTACT_X/2, h=ENEL23_Z/6);
			translate([ENEL23_CONTACT_X_POSITION_3, ENEL23_CONTACT_Y/2, -ENEL23_Z/6]) cylinder(r=ENEL23_CONTACT_X/2, h=ENEL23_Z/6);

			//Contact wire path
			translate([ENEL23_CONTACT_X_POSITION_1, -ENEL23_CONTACT_Y/2, -ENEL23_Z]) cylinder(r=ENEL23_CONTACT_X/2, h=ENEL23_Z);
			translate([ENEL23_CONTACT_X_POSITION_2, -ENEL23_CONTACT_Y/2, -ENEL23_Z]) cylinder(r=ENEL23_CONTACT_X/2, h=ENEL23_Z);
			translate([ENEL23_CONTACT_X_POSITION_3, -ENEL23_CONTACT_Y/2, -ENEL23_Z]) cylinder(r=ENEL23_CONTACT_X/2, h=ENEL23_Z);
		}

		//Cable path
		translate([ENEL23_CONTACT_X_POSITION_1 - ENEL23_CONTACT_X/2, ENEL23_Y/2, 0]) scale([1, 1, 5]) rotate([0, 90, 0]) cylinder(r=ENEL23_CONTACT_X/1.5, h=ENEL23_X);

		//Text
		translate([ENEL23_CONTACT_X_POSITION_1 - 5, 1, ENEL23_Z - 8]) rotate([90, 0, 0]) linear_extrude(2) text("- T +", 5);
	}
}



////////////////
// Main Model //
////////////////
translate([0, -ENEL23_Y/2, 0]) ENEL23_dummy();
