$fn = 96;

//Mounting hole parameters
HOLE_RADIUS = 2;
HOLE_Y_OFFSET = 71.7;
HOLE_X_OFFSET = 92.9;

//Circuit board parameters - Relative position to centre of mounting holes
BOARD_L_OFFSET = HOLE_RADIUS + 2;  //Left offset
BOARD_R_OFFSET = HOLE_RADIUS + 11; //Right offset
BOARD_B_OFFSET = HOLE_RADIUS + 4;  //Bottom offset
BOARD_T_OFFSET = HOLE_RADIUS + 4;  //Top offset
BOARD_Z = 0.4; // = 1.7; //Thickness of circuit board

//USB-B port parameters
USB_X_OFFSET = 6.5;
USB_PROTRUSION = 7.5;
USB_LENGTH = 16.5;
USB_WIDTH = 12;

//40-pin LCD port parameters
LCD_PORT_Y_OFFSET = 41;
LCD_PORT_LENGTH = 5;
LCD_PORT_WIDTH = 25;

//Size of circuit board, calculated from mounting hole and circuit board parameters
boardX = BOARD_L_OFFSET + HOLE_X_OFFSET + BOARD_R_OFFSET;
boardY = BOARD_B_OFFSET + HOLE_Y_OFFSET + BOARD_T_OFFSET;

difference() {
	union() {
		//Circuit board
		translate([-BOARD_L_OFFSET, -BOARD_B_OFFSET]) cube([boardX, boardY, BOARD_Z]);

		//USB port
		translate([USB_X_OFFSET, -BOARD_B_OFFSET-USB_PROTRUSION, 0]) cube([USB_WIDTH, USB_LENGTH, BOARD_Z/2]); //USB Port
	}
	union() {
		//Mounting holes
		translate([0, 0, 0]) cylinder(r=HOLE_RADIUS, h=BOARD_Z); //Bottom left
		translate([HOLE_X_OFFSET, 0, 0]) cylinder(r=HOLE_RADIUS, h=BOARD_Z); //Bottom right
		translate([0, HOLE_Y_OFFSET, 0]) cylinder(r=HOLE_RADIUS, h=BOARD_Z); //Top left
		translate([HOLE_X_OFFSET, HOLE_Y_OFFSET, 0]) cylinder(r=HOLE_RADIUS, h=BOARD_Z); //Top Right

		//USB port
		translate([USB_X_OFFSET, -BOARD_B_OFFSET-USB_PROTRUSION, BOARD_Z/2]) cube([USB_WIDTH, USB_LENGTH, BOARD_Z/2]); //USB Port

		//LCD port
		translate([HOLE_X_OFFSET+BOARD_R_OFFSET-LCD_PORT_LENGTH, LCD_PORT_Y_OFFSET, BOARD_Z/2]) cube([LCD_PORT_LENGTH, LCD_PORT_WIDTH, BOARD_Z/2]); //LCD Port
	}
}
