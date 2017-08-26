// helix_image.scad
// this is just a little file used to make an image of a helix
// Matt Moses 2017


// a module to make a helical path
// pitch is length for one turn
// r1 is radius to center of path
// r2 is radius of the extruded circle
// N is number of turns
module helix(pitch, r1, r2, N)
{
   linear_extrude(height = N*pitch, center = false, convexity = 10, twist = -360*N)
   translate([r1, 0, 0])
   circle(r = r2);
}


$fn = 100;
p = 2;
r1 = 1;
r2 = 0.05;
N = 1;

color("Gray")
difference(){
cylinder(r=r1,h=N*p);
translate([0,0,-.05*N*p])
cylinder(r=r1-r2/2, h=1.1*N*p);
}
color("Red")
helix(p,r1,r2,N);

color("Gray")
translate([r1,2*r1, 0])
   cube([r2/2, 2*3.1415*r1, N*p], center=false);

translate([r1,2*r1,0])
rotate([-90,0,0])
rotate([ atan2(N*p,2*3.1415*r1),0,0])
color("Red")
cylinder(r=0.8*r2, h = sqrt(pow(2*3.1415*r1,2) + pow(N*p,2)), center=false);