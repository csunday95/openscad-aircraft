include <../airfoils/NACA_profiles.scad>

thickness = 12;

module streamlined_body(thickness, extension_length) {
    translate([0, 0, 0.7]) {
        rotate_extrude()
            translate([0, 0.3, 0])
                NACA_sym_upper_profile(thickness, x_start=0.3, points=500);
        rotate_extrude()
            translate([0, extension_length + 0.3, 0])
                NACA_sym_upper_profile(thickness, x_end=0.3, points=500);
        cylinder(h=extension_length, r=thickness/200);
  }
}

module test_streamlined_body() {
    streamlined_body(thickness=12, extension_length=1);
}
