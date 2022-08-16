
include <../body/aircraft_body.scad>
include <../airfoils/airfoil.scad>

$fs = 0.01;
$fa = 0.01;
scale([1, 3, 3])
    rotate([0, 90, 0])
        streamlined_body(12, 5);
translate([4, 0, 0])
    straight_airfoil_NACA(10, 14, 2, 40, AoA=3);
