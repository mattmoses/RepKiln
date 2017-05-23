module brick(bl, bw, bh, bhd) 
{
    difference()
    {
    cube([bl, bw, bh], center=true);
        cylinder(h = bh*1.1, r=bhd/2, center=true);
        translate([bw/2,0,0])
                cylinder(h = bh*1.1, r=bhd/2, center=true);
        translate([-bw/2,0,0])
                cylinder(h = bh*1.1, r=bhd/2, center=true);
    }
}

module layer(bl, bw, bh, bhd)
{
    translate([0, 3/2*bw, bh/2])
       brick(bl, bw, bh, bhd);
    translate([0, -3/2*bw, bh/2])
       brick(bl, bw, bh, bhd);
    translate([3/2*bw, bl/2, bh/2])
        rotate([0,0,90])
            brick(bl, bw, bh, bhd);
    translate([-3/2*bw, bl/2, bh/2])
        rotate([0,0,90])
            brick(bl, bw, bh, bhd);
    translate([3/2*bw, -bl/2, bh/2])
        rotate([0,0,90])
            brick(bl, bw, bh, bhd);
     translate([-3/2*bw, -bl/2, bh/2])
        rotate([0,0,90])
            brick(bl, bw, bh, bhd);
}

module base(bl, bw, bh, bhd)
{
    translate([bl/2, 3/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
    translate([bl/2,-3/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
    translate([-bl/2, 3/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
     translate([-bl/2, -3/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
        translate([bl/2, 1/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
        translate([bl/2, -1/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
        translate([-bl/2, 1/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);
        translate([-bl/2, -1/2*bw, bh/2])
        //rotate([0,0,90])
            brick(bl, bw, bh, bhd);

    
    
}

$fn = 50;
bl = 9;
bw = 4.5;
bh = 1.5;
bhd = 5/8;
color([0.4,0.3,0.2])
brick(bl, bw, bh, bhd);
