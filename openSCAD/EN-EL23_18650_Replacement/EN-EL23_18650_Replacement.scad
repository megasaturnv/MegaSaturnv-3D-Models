// by MegaSaturnv 2020-07-14

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
INCLUDE_18650_MOUNTING_PLATE = true;

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

//Width of the 18650 holder mounting plate (X axis)
18650_MOUNTING_PLATE_X = 4;
//Length of the 18650 holder mounting plate (Y axis)
18650_MOUNTING_PLATE_Y = 21;
//Height of the 18650 holder mounting plate (Z axis)
18650_MOUNTING_PLATE_Z = 78;

//Distance between the 18650 holder screw hole and the centre of the 18650 holder
18650_HOLDER_SCREW_DISTANCE_FROM_CENTRE = 27.9;
//Diameter of the screw hole in the 18650 holder
18650_HOLDER_SCREW_DIAMETER = 3;

//Width of the zip tie hole (Y axis)
18650_HOLDER_ZIP_TIE_Y = 5;
//Height of the zip tie hole (Z axis)
18650_HOLDER_ZIP_TIE_Z = 2;
//Zip tie hole position from the bottom - 1 (Z axis)
18650_HOLDER_ZIP_TIE_Z_POS_1 = 60;
//Zip tie hole position from the bottom - 2 (Z axis)
18650_HOLDER_ZIP_TIE_Z_POS_2 = 50;

//Length of the connecting plastic between the EN-EL23 and the 18650 holder mounting plate (X axis)
ENEL23_18650MP_GAP_X = 11;
//Width of the connecting plastic between the EN-EL23 and the 18650 holder mounting plate (Y axis)
ENEL23_18650MP_GAP_Y = 3;
//Height of the connecting plastic between the EN-EL23 and the 18650 holder mounting plate (Z axis)
ENEL23_18650MP_GAP_Z = 4.8;

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

module 18650HolderMountingPlate() {
	difference() {
		cube([18650_MOUNTING_PLATE_X, 18650_MOUNTING_PLATE_Y, 18650_MOUNTING_PLATE_Z]);

		//Screw holes
		translate([0, 18650_MOUNTING_PLATE_Y/2, 18650_MOUNTING_PLATE_Z/2 + 18650_HOLDER_SCREW_DISTANCE_FROM_CENTRE]) rotate([0, 90, 0]) cylinder(r=18650_HOLDER_SCREW_DIAMETER/2, h=18650_MOUNTING_PLATE_X);
		translate([0, 18650_MOUNTING_PLATE_Y/2, 18650_MOUNTING_PLATE_Z/2 - 18650_HOLDER_SCREW_DISTANCE_FROM_CENTRE]) rotate([0, 90, 0]) cylinder(r=18650_HOLDER_SCREW_DIAMETER/2, h=18650_MOUNTING_PLATE_X);

		//18650 holder contact holes
		translate([0, 18650_MOUNTING_PLATE_Y/2, 0]) scale([1, 1, 6]) rotate([0, 90, 0]) cylinder(r=0.8, h=18650_MOUNTING_PLATE_X);
		translate([0, 18650_MOUNTING_PLATE_Y/2, 18650_MOUNTING_PLATE_Z]) scale([1, 1, 6]) rotate([0, 90, 0]) cylinder(r=1, h=18650_MOUNTING_PLATE_X);

		//Zip tie holes
		translate([0, 18650_MOUNTING_PLATE_Y/2 - 18650_HOLDER_ZIP_TIE_Y/2, 18650_HOLDER_ZIP_TIE_Z_POS_1]) cube([18650_MOUNTING_PLATE_X, 18650_HOLDER_ZIP_TIE_Y, 18650_HOLDER_ZIP_TIE_Z]);
		translate([0, 18650_MOUNTING_PLATE_Y/2 - 18650_HOLDER_ZIP_TIE_Y/2, 18650_HOLDER_ZIP_TIE_Z_POS_2]) cube([18650_MOUNTING_PLATE_X, 18650_HOLDER_ZIP_TIE_Y, 18650_HOLDER_ZIP_TIE_Z]);
		translate([18650_MOUNTING_PLATE_X-1, 18650_MOUNTING_PLATE_Y/2 - 18650_HOLDER_ZIP_TIE_Y/2, 18650_HOLDER_ZIP_TIE_Z_POS_2]) cube([1, 18650_HOLDER_ZIP_TIE_Y, 18650_HOLDER_ZIP_TIE_Z+18650_HOLDER_ZIP_TIE_Z_POS_1-18650_HOLDER_ZIP_TIE_Z_POS_2]);

		//Vertial Wire Guide
		translate([18650_MOUNTING_PLATE_X/2, 18650_MOUNTING_PLATE_Y/4, 0]) rotate([270, 0, 0]) cylinder(r=1.1, h=18650_MOUNTING_PLATE_Y/4);
		translate([18650_MOUNTING_PLATE_X/2, 18650_MOUNTING_PLATE_Y/4, 0]) cylinder(r=1.1, h=18650_MOUNTING_PLATE_Z);
	}
}

module ENEL23_18650MP_connector() {
	difference() {
		union() {
			cube([ENEL23_18650MP_GAP_X, ENEL23_18650MP_GAP_Y, ENEL23_18650MP_GAP_Z]);
			translate([-0.5, 0, 0]) cube([0.5, ENEL23_18650MP_GAP_Y, ENEL23_18650MP_GAP_Z]);
			translate([-3.5, -0.5, 0]) cube([3, ENEL23_18650MP_GAP_Y+1, ENEL23_18650MP_GAP_Z+4]);
		}
		//translate([0, ENEL23_18650MP_GAP_Y/2, 0]) rotate([0, 90, 0]) cylinder(r=ENEL23_18650MP_GAP_Y/3, h=ENEL23_18650MP_GAP_X);
		//translate([-3.5, ENEL23_18650MP_GAP_Y/2, 0]) rotate([0, 90, 0]) cylinder(r=ENEL23_18650MP_GAP_Y/3, h=ENEL23_18650MP_GAP_X);
		scale([1, 1, 2]) translate([-3.5, ENEL23_18650MP_GAP_Y/2, 0]) rotate([0, 90, 0]) cylinder(r=0.8, h=ENEL23_18650MP_GAP_X+3.5);

		//translate([ENEL23_18650MP_GAP_X - ENEL23_18650MP_GAP_Y/3, ENEL23_18650MP_GAP_Y/2, 0]) cylinder(r=ENEL23_18650MP_GAP_Y/4, h=ENEL23_18650MP_GAP_Z);
	}
}



////////////////
// Main Model //
////////////////
translate([0, -ENEL23_Y/2, 0]) ENEL23_dummy();
if (INCLUDE_18650_MOUNTING_PLATE) {
	translate([ENEL23_X, -ENEL23_18650MP_GAP_Y/2, 0]) ENEL23_18650MP_connector();
	translate([ENEL23_X + ENEL23_18650MP_GAP_X, -18650_MOUNTING_PLATE_Y/2, 0]) 18650HolderMountingPlate();
}
