#!/bin/bash

# By MegaSaturnv 2021-03-02

fanSizes=(          40  50  60  70   80    92    120  140    200  220)
fanDiameters=(      35  45  55  65   75    87    115  135    195  215)
screwsDistances=(   32  40  50  60   71.5  82.5  105  124.5  154  170)
screwHoleDiameters=(3.5 4   4   4.5  5     5     5    5      5    5)

arrayLength=${#fanSizes[@]}

startTime="$(date +%s)"

#Check arrays are the same size
if [[ "$arrayLength" != "${#fanDiameters[@]}" || "$arrayLength" != "${#screwsDistances[@]}" || "$arrayLength" != "${#screwHoleDiameters[@]}" ]]; then
	echo "Error: arrays are not the same size! fanSizes, fanDiameters, screwsDistances and screwHoleDiameters arrays should all have the same number of items in each"
	echo "Array lengths:"
	echo "fanSizes =           ${#fanSizes[@]}"
	echo "fanDiameters =       ${#fanDiameters[@]}"
	echo "screwsDistances =    ${#screwsDistances[@]}"
	echo "screwHoleDiameters = ${#screwHoleDiameters[@]}"
	exit
fi



echo "==== Render fan sizes 40-220mm ===="
for (( i=0; i<$arrayLength; i++ )); do #"for size in ${fanSizes[@]}; do" etc won't work because we need to access the same index in multiple arrays
	echo "$(date -Is)    Rendering with... FAN_SIZE=${fanSizes[$i]} FAN_DIAMETER=${fanDiameters[$i]} SCREWS_DISTANCE=${screwsDistances[$i]}"
	openscad -q -o "Fan_Filter_Standoff ${fanSizes[$i]}.stl" -D "FAN_SIZE=${fanSizes[$i]}" -D "FAN_DIAMETER=${fanDiameters[$i]}" -D "SCREWS_DISTANCE=${screwsDistances[$i]}" -D "SCREW_HOLE_DIAMETER=${screwHoleDiameters[$i]}" "Fan_Filter_Standoff.scad"
done



MASTER_SIZE=120
ARRAY_POSITION_OF_MASTER_SIZE=6
echo
echo "==== Render fan sizes 40-$MASTER_SIZE mm with outer size = $MASTER_SIZE mm with additional screw holes ===="
for (( i=0; i<$ARRAY_POSITION_OF_MASTER_SIZE; i++ )); do #
	echo "$(date -Is)    Rendering with... FAN_SIZE=$MASTER_SIZE FAN_DIAMETER=${fanDiameters[$i]} SCREWS_DISTANCE=${screwsDistances[$i]}"
	openscad -q -o "Fan_Filter_Standoff Outer$MASTER_SIZE Inner${fanSizes[$i]}.stl" -D "FAN_SIZE=$MASTER_SIZE" -D "FAN_DIAMETER=${fanDiameters[$i]}" -D "SCREWS_DISTANCE=${screwsDistances[$i]}" -D "SCREW_HOLE_DIAMETER=${screwHoleDiameters[$i]}" -D "ADDITIONAL_SCREW_HOLES=true" "Fan_Filter_Standoff.scad"
done



endTime="$(date +%s)"
echo "seconds taken to render: $(($endTime - $startTime))"
#echo "seconds taken to render: $((endTime - startTime))"
