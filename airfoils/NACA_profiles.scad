// render values

function NACA_airfoil_sym_thickness(t, x) = 
  5 * t * (0.2969 * sqrt(x) - 0.1260 * x - 0.3516 * x ^ 2 + 0.2843 * x^3 - 0.1036 * x ^ 4);

function NACA_mean_camber_line_y(m, p, x) = 
  x <= p ?
    (m / (p ^ 2)) * ( 2 * p * x - x ^ 2) :
    (m / ((1 - p) ^ 2)) * (1 - 2 * p + 2 * p * x - x ^ 2)
;

function cat(L1, L2) = [for (i=[0:len(L1)+len(L2)-1]) 
                        i < len(L1)? L1[i] : L2[i-len(L1)]] ;
                        
function flip_y(points) = [for (i=[0:len(points)-1]) [points[i][0], -points[i][1]]];

function join_xy(xx, yy) = [for (i=[0:len(xx)-1]) [xx[i], yy[i]]];

function reversed(points) = [for (i=[len(points) - 1:-1 : 0]) points[i]];

function NACA_camber_angle(m, p, x) = atan(
  x <= p ? 
    (2 * m / (p ^ 2) * (p - x)) : 
    ((2 * m / (1 - p) ^ 2) * (p - x))
);

function NACA_airfoil_cambered_pt_offsets(m, p, t, x) = 
  let (theta = NACA_camber_angle(m, p, x))
    let (thickness = NACA_airfoil_sym_thickness(t, x))
      p == 0 ? [0, thickness] : [-thickness * sin(theta), thickness * cos(theta)]
;

module NACA_sym_upper_profile(t_NACA, x_start=0, x_end=1.0, points=100) {
  t = t_NACA / 100;
  pts = [for (x=[x_start:1/points:x_end]) [abs(NACA_airfoil_sym_thickness(t, x)), -x]];
  extra_pt = x_start == 0 ? [] : [[0, -x_start]];
  polygon(cat(extra_pt, pts));
}

module NACA_profile(t_NACA, m_NACA, p_NACA, points=1000) {
  t = t_NACA / 100;
  m = m_NACA / 100;
  p = p_NACA / 100;
  camber_line = [for(x = [0: 1 / points:1.0]) [x, p == 0 ? 0 : NACA_mean_camber_line_y(m, p, x)]];
  offsets = [for (x = [0:1 / points:1.0]) NACA_airfoil_cambered_pt_offsets(m, p, t, x)];
  echo(offsets);
  pts = cat(camber_line + offsets, reversed(camber_line - offsets));
  polygon(pts);
}

module test_NACA_profile() {
  NACA_profile(12, 1.5, 40, 1000);
}
