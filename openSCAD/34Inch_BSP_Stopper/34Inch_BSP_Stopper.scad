// by MegaSaturnv 2021-07-24

// Thread library Open Source by Dan Kirshner - dan_kirshner@yahoo.com
// https://github.com/jcrocholl/kossel/blob/master/threads.scad
// https://raw.githubusercontent.com/jcrocholl/kossel/master/threads.scad
// http://dkprojects.net/openscad-threads/threads.scad
// http://dkprojects.net/openscad-threads/
include <threads.scad>

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
endcap_height=5;
thread_length = 0.6;

/* [Advanced] */
//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve.
$fn = $preview ? 24 : 96;

////////////////
// Main Model //
////////////////

union () {
	// Square cap
	rotate([0, 0, 45]) cylinder(d=28, h=5, $fn=4);

	// 3/4" BSP thread
	translate ([0,0,endcap_height]) english_thread(1.0, 14, thread_length);
}
