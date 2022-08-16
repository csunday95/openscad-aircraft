include <NACA_profiles.scad>

module straight_airfoil_NACA(wingspan, t_NACA, m_NACA, p_NACA, AoA=0, points=1000) {
    translate([1, 0, 0])
        rotate([90, AoA, 180])
            translate([0, 0, -wingspan / 2])
                linear_extrude(wingspan)
                    NACA_profile(t_NACA, m_NACA, p_NACA);
}

module test_straight_airfoil_NACA() {
  straight_airfoil_NACA(10, 12, 1.5, 40, AoA=15);
}
