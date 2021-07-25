#!/bin/bash

echo "$(date)        Pokewalker_Case.stl"
openscad -o Pokewalker_Case.stl Pokewalker_Case.scad 2> /dev/null



echo "$(date)        Pokewalker_Case_upper.stl"
openscad -o Pokewalker_Case_upper.stl            -D 'RENDER_SIDE="upper"' Pokewalker_Case.scad 2> /dev/null

echo "$(date)        Pokewalker_Case_lower.stl"
openscad -o Pokewalker_Case_lower.stl            -D 'RENDER_SIDE="lower"' Pokewalker_Case.scad 2> /dev/null



echo "$(date)        Pokewalker_Case_upper_noHoles.stl"
openscad -o Pokewalker_Case_upper_noHoles.stl    -D 'RENDER_SIDE="upper"' -D 'IR_PORT=false' -D 'SCREEN=false' -D 'BUTTON_COVER="base"' Pokewalker_Case.scad 2> /dev/null

echo "$(date)        Pokewalker_Case_lower_noHoles.stl"
openscad -o Pokewalker_Case_lower_noHoles.stl    -D 'RENDER_SIDE="lower"' -D 'IR_PORT=false' Pokewalker_Case.scad 2> /dev/null




echo "$(date)        Pokewalker_Case_upper_buttonFlatBase.stl"
openscad -o Pokewalker_Case_upper_buttonFlatBase.stl -D 'RENDER_SIDE="upper"' -D 'BUTTON_COVER="base"' Pokewalker_Case.scad 2> /dev/null

echo "$(date)        Pokewalker_Case_upper_buttonCaps.stl"
openscad -o Pokewalker_Case_upper_buttonCaps.stl -D 'RENDER_SIDE="upper"' -D 'BUTTON_COVER="caps"' Pokewalker_Case.scad 2> /dev/null

echo "$(date)        Complete!"
