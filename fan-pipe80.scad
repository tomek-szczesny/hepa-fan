// Fan to pipe adapter
// Flat design for 80mm fan and 80mm pipe
// by Tomek Szczęsny 2022
// Slab module by Edward Kisiel
// (https://github.com/hominoids/SBC_Case_Builder/blob/main/sbc_case_builder_library.scad)

$fn=200;

// You can adjust these variables
// Primarily the filter hole diameter and fan size
screwhole=4.5;     //fan screw hole diameter (5)
holespacing=4.25; // screw hole distance from the edge (7.5)
fan=80;              //fan size (must be bigger than filterhole)
filterhole=80;     //HEPA filter hole diameter
thickness=2;  //Thickness of plastic layer (1.5)
insert=15;          //Length of insert into filter (10)

//Do not adjust anything below here

cone=(fan-filterhole)/1.5;
wall=thickness*2;
difference(){
	union(){
		//flange
		translate([0,0,0])
			slab([fan,fan,thickness],3.75);
		//taper to filter insert
		translate([fan/2,fan/2,thickness])  
			cylinder(h=cone,d1=fan,d2=filterhole);
		//filter insert
		translate([fan/2,fan/2,cone])  
			cylinder(h=insert+thickness,d=filterhole);
	}
	//taper to filter insert
	translate([fan/2,fan/2,-0.01])  
		cylinder(h=cone+0.02,d1=fan-4,d2=filterhole-wall);
	//filter insert
	translate([fan/2,fan/2,cone-0.01])  
		cylinder(h=insert+thickness+0.02,d=filterhole-wall);
	//fan attachment holes
	translate([holespacing,holespacing,-1])  
		cylinder(h=thickness+2,d=screwhole);
	translate([holespacing,fan-holespacing,-1])  
		cylinder(h=thickness+2,d=screwhole);
	translate([fan-holespacing,holespacing,-1])  
		cylinder(h=thickness+2,d=screwhole);
	translate([fan-holespacing,fan-holespacing,-1])  
		cylinder(h=thickness+2,d=screwhole);
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
