$fa = 1;
$fs = 0.4;

fastening_width = 40.00;
fastening_height = 60.00;
bed_thickness = 20.00;
fastening_thickness = 4.00;
/* Arch for the fastening */
reflex_r = fastening_height;

screw_diameter = 1.00;
screw_head_diameter = 2.00;
screw_head_thickness = 2.00;

difference () {
    /* Base */
    union () {
        translate([0, reflex_r, 0]) difference() {
            rotate([90, 0, 90]) difference()
            {
                /* Base */
                cylinder(h=fastening_width, r=reflex_r, center=true);
                cylinder(h=fastening_width*2, r=reflex_r-fastening_thickness, center=true);
            }

            /* Height Cut */
            translate([0, 0, fastening_height/2.00+fastening_height/2.00])
                cube([fastening_height*10, fastening_width*10, fastening_height], center=true);
            translate([0, 0, -fastening_height/2.00-fastening_height/2.00])
                cube([fastening_height*10, fastening_width*10, fastening_height], center=true);

            /* Width Cut */
            translate([0, bed_thickness*5, 0])
                cube([fastening_width*2, bed_thickness*10, fastening_height*2], center=true);
        }

        /* Wall */
        translate([0, -bed_thickness])
            cube([fastening_width, fastening_thickness, fastening_height], center=true);

        /* Roof */
        __x = sqrt(((reflex_r-fastening_thickness)*(reflex_r-fastening_thickness)) - ((fastening_height/2)*(fastening_height/2)));
        translate([-fastening_width/2, -bed_thickness-fastening_thickness/2, fastening_height/2])
            cube([fastening_width, bed_thickness+(reflex_r-__x)+fastening_thickness/2, fastening_thickness+screw_head_thickness]);
    }
    translate([0, -bed_thickness/2, fastening_height/2.00 - 0.5])
        cylinder (h=1.00 + fastening_thickness+screw_head_thickness, r=screw_diameter);

    translate([0, -bed_thickness/2, fastening_height/2.00-1.00])
        cylinder (h=1.00 + screw_head_thickness, r=screw_head_diameter);
}
