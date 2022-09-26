// HEPA filter fan adaptor
// Based on Big Clive's design (bigclive.com)
// Expanded by Tomek Szczęsny 2022

$fn=200;

// You can adjust these variables
// Primarily the filter hole diameter and fan size
screwhole=5;     //fan screw hole diameter (5)
holespacing=7.5; // screw hole distance from the edge (7.5)
fan=140;              //fan size (must be bigger than filterhole)
filterhole=115;     //HEPA filter hole diameter
thickness=2;  //Thickness of plastic layer (1.5)
insert=10;          //Length of insert into filter (10)

//Do not adjust anything below here

cone=(fan-filterhole)/1.5;
wall=thickness*2;
difference(){
	union(){
		//flange
		translate([0,0,0])
			cube([fan,fan,thickness]);
		//taper to filter insert
		translate([fan/2,fan/2,0])  
			cylinder(h=cone,d1=fan,d2=filterhole);
		//filter insert
		translate([fan/2,fan/2,cone])  
			cylinder(h=insert,d=filterhole);
	}
	//taper to filter insert
	translate([fan/2,fan/2,-0.01])  
		cylinder(h=cone+0.02,d1=fan-4,d2=filterhole-wall);
	//filter insert
	translate([fan/2,fan/2,cone-0.01])  
		cylinder(h=insert+0.02,d=filterhole-wall);
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
