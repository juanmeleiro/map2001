// Main modules:
// 'edge' for the edge piece
// 'connector' for the connectors

// Constants:
WIDTH = 3;
SEP = 1;

include <out.scad>;

// Angles represent the FULL vertex angle, not the angle made by the piece.
module edge(length, angle1, angle2) {
    union() {
        halfedge(length/2, angle1);
        mirror([0, 1, 0]) halfedge(length/2, angle2);
    }
}
module halfedge(length, angle) {

    difference() {
        square([3*WIDTH, length]);
        union() {
            translate([0, length, 0]) rotate(angle) translate([0, -length, 0])
                union() {
                    square([3*WIDTH, length]);
                    translate([-2*WIDTH, length - 3*WIDTH/sin(angle), 0]) square(WIDTH);
                }
            translate([WIDTH, WIDTH, 0]) square(WIDTH);
        }
    }
}

module connector(angle) {
    union() {
        rotate(angle) translate([WIDTH, 0]) square(WIDTH);
        translate([WIDTH, -WIDTH]) square(WIDTH);
        arc(2*WIDTH, angle);
    }
}

module arc(radius, angle) {
    $fn = 100;
    arc_points = [for (i = [0 : $fn]) [radius*cos(i*angle/$fn), radius*sin(i*angle/100)]];
    polygon(concat(arc_points, [[0, 0]]));
}
