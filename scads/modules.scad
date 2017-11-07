// Main modules:
// 'edge' for the edge piece
// 'connector' for the connectors

// Example:
//d = 5;   // Depth of cuts
//w = 3;   // Width of cuts
//a = 180;  // Angle
//l = 50; // Length

//translate([0, l/2, 0])
//rotate(a)
//translate([0, -l/2, 0])
//mirror([1, 0, 0])
//edge(l, d, a, a, w);
//edge(l, d, a, a, w);
//translate([30, 0, 0])
//connector(d, w, a);

include <out.scad>;

module edge(length, depth, angle1, angle2, width) {
    union() {
        mirror([0, 1, 0])
        halfEdge(length, depth, 180 - angle2, width);
        halfEdge(length, depth, 180 - angle1, width);
    }
}

module halfEdge(length, depth, angle, width) {
    difference() {
        translate([0, length/2 - 2*depth*tan(angle/2), 0])
        difference() {
            translate([0, 2*depth*tan(angle/2), 0])
            difference() {
                translate([0, -length/2, 0])
                square([2*depth, length/2]);
                rotate(-angle/2)
                square([length/2, 2*depth]);
            }
            translate([2*depth, 0])
            rotate(90 - angle/2)
            translate([-depth, 0])
            square([depth+1, width]);
        }
        translate([-1, -1])
        square([depth+1, 1+width/2]);
    }
}


module connector(depth, width, angle) {
    union() {
        //halfCircle(2*width);
        mirror([0, 1, 0])
        halfConnector(depth, width, angle);
        halfConnector(depth, width, angle);
    }
}

module halfConnector(depth, width, angle) {
    rotate(angle/2)
    translate([depth, 0, 0])
    difference() {
    translate([-depth, -width]) square([2*depth, 3*width]);
        square([depth+1, width]);
    }
}

module halfCircle(r) {
    difference() {
        circle(r);
        translate([0, -r, 0])
        square(2*r);
    }
}
