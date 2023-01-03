// HEPA filter fan adaptor
// Flat design for 80mm fan
// Fits 125mm pipe on top of itself
// For 116mm filter hole
// by Tomek Szczęsny 2022
// Slab module by Edward Kisiel
// (https://github.com/hominoids/SBC_Case_Builder/blob/main/sbc_case_builder_library.scad)

$fn=360;

// You can adjust these variables
screwhole=4.5;     //fan screw hole diameter (5)
holespacing=4.25; // screw hole distance from the edge (7.5)
thickness=1.6;  //Thickness of plastic layer (1.5)
fan=80;              //fan size
fan_b=fan+1;           // fan size for bracket
fanslabcorner=2.25;
filterhole=116;     //HEPA filter hole diameter
insert=5;           // HEPA filter insert depth
base=125;         // base diameter
basethickness=5;         // base diameter

fanbracket_h=basethickness+insert-thickness+0.01;

//Do not adjust anything below here

hole_pos=(fan/2-holespacing);

// Decorations
*%union(){
    // Fan
    translate([-fan/2, -fan/2, thickness+01])
        slab([fan, fan, 25],fanslabcorner);
    // Pipe
    translate([0,0,basethickness-100+0.001])
        difference(){
            cylinder(h=100,d=base+6);
            translate([0,0,-0.001]) cylinder(h=101,d=base);
        }
}

difference(){
    // Base
	union(){
		cylinder(h=basethickness,d=base);
        translate([0,0,basethickness-0.001])
            cylinder(h=insert,d=filterhole);
	}
    translate([0,0,thickness+0.001])
        cylinder(h=100,d=filterhole-2*thickness);
    
    // Fan mounting holes
    translate([hole_pos,hole_pos,-1])  
		cylinder(h=100,d=screwhole);
	translate([hole_pos,-hole_pos,-1])  
		cylinder(h=100,d=screwhole);
	translate([-hole_pos,hole_pos,-1])  
		cylinder(h=100,d=screwhole);
	translate([-hole_pos,-hole_pos,-1])  
		cylinder(h=100,d=screwhole);
    
    // Fan hole
    translate([0, 0, -1])
        cylinder(h=100, d=fan);  
}
// Fan Bracket
translate([0,0,thickness-0.01])
    difference(){
        translate([-fan_b/2-thickness, -fan_b/2-thickness, 0])
            slab([fan_b+2*thickness,fan_b+2*thickness,fanbracket_h],fanslabcorner+thickness);
        translate([-fan_b/2, -fan_b/2, -0.01])
            slab([fan_b,fan_b,fanbracket_h+1],fanslabcorner);
    }


/* slab module */
module slab(size, radius) {
    
    x = size[0];
    y = size[1];
    z = size[2];   
    linear_extrude(height=z)
    hull() {
        translate([0+radius ,0+radius, 0]) circle(r=radius);	
        translate([0+radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, 0+radius, 0]) circle(r=radius);
    }  
}
