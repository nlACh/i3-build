$fn=3000;
constant_nema17_dimen=43.18;
constant_nema17_dimen_half=21.59;

//faceplate dimen, adjust as required.
//holes will be spaced w.r.t center irrespective of dimens
plate_l=55;
plate_b=50;
plate_t=8;

//E3d cold end J-head dia
e3d=16;//change according to ur stuff

h_l = 2*plate_l;
h_b = 50;
h_t = 22;
//hoping the screw holes are M3 or M4 size. So dia=3.5mm, use drill if necessary. The values are hardcoded into the cylinders of nema17_holes module
module nema17_holes(h) {
    union(){
    //cube([43.18, 43.18, 3]);
    cylinder(d=3.5, h=h, $fn=2000);
    translate([43.18,0,0]) {
        cylinder(d=3.5, h=h, $fn=2000);
    }
    translate([43.18,43.18,0]) {
        cylinder(d=3.5, h=h, $fn=2000);
    }
    translate([0,43.18,0]) {
        cylinder(d=3.5, h=h, $fn=2000);
    }
    
}}
module base_plate(l,b,h) {
    difference() {
    cube([l,b,h]);
    union() {
    translate([l/2-21.59,b/2-21.59,0]){
        nema17_holes(h);
        }
    translate([l/2,b/2,0]){cylinder(d=25, h=h);}
        }
    }
}

module dual_ext(){
    union(){
    base_plate(plate_l, plate_b, plate_t);
    translate([plate_l,0,0]){
        base_plate(plate_l, plate_b, plate_t);
    }
    translate([0,plate_b+h_t,0]){
        rotate([90,0,0])heatsink();
        }
    translate([plate_l-30,plate_b+h_t,0]){
        difference(){
        cube(size=[60,40,plate_t]);
            translate([42,8,0])mounting_holes();}//fixed
        //position is parametric
    }
  }
}

module heatsink(){
    union(){
    difference(){
        cube(size=[h_l,h_b,h_t]);
        translate([0.65*plate_l,.6*h_b,0]){
            cylinder(h=h_t,d=e3d);}
        translate([h_l-0.65*plate_l,.6*h_b,0]){
            cylinder(h=h_t,d=e3d);
        }
    }
}}

module mounting_holes(){   //will be M4 as per i3 rework
    union(){
    cylinder(h=plate_t, d=4);
    translate([-24,0,0]) cylinder(h=plate_t, d=4);
    translate([-24,24,0]) cylinder(h=plate_t, d=4);
    translate([0,24,0]) cylinder(h=plate_t, d=4);
    }
    
}
dual_ext();
//mounting_holes();
