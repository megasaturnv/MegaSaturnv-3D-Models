#!/bin/bash

echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2.stl"
openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2.stl       -D 'RENDER_SIDE="both"'  The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null

echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Upper.stl"
openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Upper.stl -D 'RENDER_SIDE="upper"' The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null

echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Lower.stl"
openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Lower.stl -D 'RENDER_SIDE="lower"' The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null



#echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2_NoThreadTolerance.stl"
#openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2_NoThreadTolerance.stl       -D 'RENDER_SIDE="both"'  -D 'HEX_CENTRE_THREAD_TOLERANCE=0' The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null

#echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Upper_NoThreadTolerance.stl"
#openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Upper_NoThreadTolerance.stl -D 'RENDER_SIDE="upper"' -D 'HEX_CENTRE_THREAD_TOLERANCE=0' The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null



#echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2_LargeThreadTolerance.stl"
#openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2_LargeThreadTolerance.stl       -D 'RENDER_SIDE="both"'  -D 'HEX_CENTRE_THREAD_TOLERANCE=0.4' The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null

#echo "$(date)        The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Upper_LargeThreadTolerance.stl"
#openscad -o The_Capsule_Hex_Bit_Keychain_Keyfob_v2_Upper_LargeThreadTolerance.stl -D 'RENDER_SIDE="upper"' -D 'HEX_CENTRE_THREAD_TOLERANCE=0.4' The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad 2> /dev/null



echo "$(date)        Complete!"
