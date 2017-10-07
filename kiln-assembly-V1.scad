////////////////////////////////////////////////////////////////////////////////
//  kiln-assembly-V1.scad
//
//  This OpenSCAD file describes the mechanical assembly for RepKiln, a simple 
//  electric kiln designed for firing clay and melting metals. The kiln is designed 
//  to be able to fire the same kind of bricks from which it is constructed, hence 
//  the "Rep" (for replicating) in the name.
//
//  More information about the RepKiln project can be found here:
//
//  https://hackaday.io/project/21642-repkiln
// 
//  Version 1.0 Initial Release - September 2017
//
//  Copyright 2017 Matt Moses   
//  mmoses152 at gmail dot com
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  If you do not have a copy of the GNU General Public License, see
//  http://www.gnu.org/licenses
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module brick() 
{
    color([0.7,0.3,0.2])
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
}

module halfBrick() 
{
    color([0.7,0.3,0.2])
    {
        difference()
            cube([bl/2, bw, bh], center=true);
            cylinder(h = bh*1.1, r=bhd/2, center=true);
    }
}

module shortStrip()
{
    hl1 = shsl/2 - 1.5 * hs;
    hl2 = shsl/2 - 0.5 * hs;
    hl3 = shsl/2 + 0.5 * hs;
    hl4 = shsl/2 + 1.5 * hs;
    echo("short strip dimensions in INCHES");
    echo("short strip length =", shsl);
    echo("hole one location from end =", hl1);
    echo("hole two location from end =", hl2);
    echo("hole three location from end =", hl3);
    echo("hole four location from end =", hl4);
    color([0.1,0.3,0.6])
    {
        difference()
        {
            cube([shsl, shsw, shsh], center=true);
            for (i = [-1.5, -0.5, 0.5, 1.5])
            {
                translate([i*hs, 0, 0])
                    cylinder(r=shd/2, h = 1.1*shsh, center=true);
            }
        }
    }
}
        
module longStrip()
{
    hl1 = losl/2 - 2.5 * hs;
    hl2 = losl/2 - 1.5 * hs;
    hl3 = losl/2 - 0.5 * hs;
    hl4 = losl/2 + 0.5 * hs;
    hl5 = losl/2 + 1.5 * hs; 
    hl6 = losl/2 + 2.5 * hs;
    echo("long strip dimensions in INCHES");
    echo("long strip length =", losl);
    echo("hole one location from end =", hl1);
    echo("hole two location from end =", hl2);
    echo("hole three location from end =", hl3);
    echo("hole four location from end =", hl4);
    echo("hole five location from end =", hl5);
    echo("hole six location from end =", hl6);
    color([0.1,0.3,0.6])
    {
        difference()
        {
            cube([losl, losw, losh], center=true);
            for (i = [-2.5, -1.5, -0.5, 0.5, 1.5, 2.5])
            {
                translate([i*hs, 0, 0])
                    cylinder(r=shd/2, h = 1.1*shsh, center=true);
            }
        }
    }
}

module lidStrip()
{
    hl1 = lisl/2 - hs;
    hl2 = lisl/2;
    hl3 = lisl/2 + hs;
    echo("lid strip dimensions in INCHES");
    echo("lid strip length =", lisl);
    echo("hole one location from end =", hl1);
    echo("hole two location from end =", hl2);
    echo("hole three location from end =", hl3);
    color([0.1,0.3,0.6])
    {
        difference()
        {
            cube([lisl, lisw, lish], center=true);
            for (i = [-1, 0, 1])
            {
                translate([i*hs, 0, 0])
                    cylinder(r=shd/2, h = 1.1*lish, center=true);
            }
        }
    }
}

module threadedRod(trodHeight)
{
    color([0.1,0.3,0.6])
        cylinder(r=thrdrd/2, h = trodHeight, center=true);
}

module LayerOne()
{
    translate([bl/2, 3/2*bw, bh/2])
        brick();
    translate([-bl/2, 3/2*bw, bh/2])
        brick();
    translate([bl/2, -3/2*bw, bh/2])
        brick();
    translate([-bl/2, -3/2*bw, bh/2])
        brick();
    translate([0, 1/2*bw, bh/2])
        brick();
    translate([0, -1/2*bw, bh/2])
        brick();
    translate([-bl, 1/2*bw, bh/2])
        brick();
    translate([-bl, -1/2*bw, bh/2])
        brick();
    translate([-7/4*bl, 0, bh/2])
        rotate([0,0,90])
            brick();
    translate([3/4*bl, 0, bh/2])
        rotate([0,0,90])
            brick();
}

module LayerTwo()
{
    translate([0, 3/2*bw, 3/2*bh])
        brick();
    translate([0, -3/2*bw, 3/2*bh])
        brick();
    translate([3/4*bl, 1/2*bl, 3/2*bh])
        rotate([0,0,90])
            brick();
    translate([3/4*bl, -1/2*bl, 3/2*bh])
        rotate([0,0,90])
            brick();
    translate([-3/4*bl, 1/2*bl, 3/2*bh])
        rotate([0,0,90])
            brick();
    translate([-3/4*bl, -1/2*bl, 3/2*bh])
        rotate([0,0,90])
            brick();
    translate([-1/4*bl, 0/2*bl, 3/2*bh])
        rotate([0,0,90])
            brick();
    translate([1/4*bl, 0/2*bl, 3/2*bh])
        rotate([0,0,90])
            brick();
    translate([-3/2*bl, 1/4*bl, 3/2*bh])
            brick();
    translate([-3/2*bl, -1/4*bl, 3/2*bh])
            brick();
}

module basicWallLayer()
{
    translate([bl/2, 3/2*bw, 0])
        brick();
    translate([-bl/2, 3/2*bw, 0])
        brick();
    translate([bl/2, -3/2*bw, 0])
        brick();
    translate([-bl/2, -3/2*bw, 0])
        brick();
    translate([3/4*bl, 0, 0])
        rotate([0,0,90])
            brick(); 
    translate([-3/4*bl, 0, 0])
        rotate([0,0,90])
            brick(); 
}

module heater(heatloop, heatgap, heatcoil, heatstem)
{
    difference()
    {
        union()
        {
            cube([heatloop+heatcoil, heatloop+heatcoil, heatcoil], center=true);
            translate([-heatloop/2 - heatstem/2, 0, 0])
                cube([heatstem, heatgap+heatcoil, heatcoil], center=true);
        }
        cube([heatloop-heatcoil, heatloop-heatcoil, 1.1*heatcoil], center=true);
        translate([-heatloop/2 - heatstem/2, 0, 0])
            cube([heatstem + 1.1*heatcoil, heatgap-heatcoil, 1.1*heatcoil], center=true);
     }
}

module LayerThree()
{
    translate([0, 0, 5/2*bh])
    difference()
    {
        basicWallLayer();
        translate([0, 0, 1/2*bh - 0.9*heatcoil])
            // this next line is confusing. see
            // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/General#Scope_of_variables
            // for some clarification on why this actually works
            heater(heatloop, heatgap, 2*heatcoil, heatstem);
    }
}

module LayerFour()
{
    translate([0, 0, 7/2*bh])
    difference()
    {
        rotate([0, 0, 90])
        basicWallLayer();
        translate([0, 0, 1/2*bh - 0.9*heatcoil])
            // this next line is confusing. see
            // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/General#Scope_of_variables
            // for some clarification on why this actually works        
            heater(heatloop, heatgap, 2*heatcoil, heatstem);
    }
}

module LayerFive()
{
    translate([0, 0, 9/2*bh])
    difference()
    {
        basicWallLayer(bl, bw, bh, bhd);
        translate([0, 0, 1/2*bh - 0.9*heatcoil])
            // this next line is confusing. see
            // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/General#Scope_of_variables
            // for some clarification on why this actually works
            heater(heatloop, heatgap, 2*heatcoil, heatstem);
    }
}

module LayerSix()
{
    translate([0, 0, 11/2*bh])
        rotate([0, 0, 90])
            basicWallLayer();
}

module LayerSeven()
{
    translate([0, 0, 13/2*bh])
    difference()
    {
        basicWallLayer(bl, bw, bh, bhd);
        translate([0, 0, 1/2*bh - 0.9*heatcoil])
            // this next line is confusing. see
            // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/General#Scope_of_variables
            // for some clarification on why this actually works
            heater(heatloop, heatgap, 2*heatcoil, heatstem);
    }
}

module LayerEight()
{
    translate([0, 0, 15/2*bh])
        rotate([0, 0, 90])
            basicWallLayer();
}

module halfLid()
{
    for (i = [-2.5, -0.5, 1.5, 3.5])
    {
        translate([bl/4, i*bh, 0])
            rotate([90,0,0])
                brick();
        translate([bl/2, i*bh - bh, 0])
            rotate([90,0,0])
                halfBrick();
    }
}   

module Lid()
{
     translate([0,0,8*bh + bw/2])
    {
        for (i = [-1, 0, 1])
        {
            translate([i*hs, 0, 0])
                rotate([90,0,0])
                    threadedRod(trodHeight=lidthL); 
        }
        translate([0, 4*bh + lish/2, 0])
             rotate([90,0,0])
                lidStrip();
         translate([0, -4*bh - lish/2, 0])
             rotate([90,0,0])
                lidStrip();
        halfLid();
        rotate([180,180,0])
            halfLid();
    }
}    

// number of fragments, OpenSCAD system parameter
$fn = 50; // no units

//////////////////////////////////////////////////////////////////////////////////////////////
// UNLESS OTHERWISE NOTED, LENGTH UNITS ARE INCHES!!
//////////////////////////////////////////////////////////////////////////////////////////////

sf = 4.25/4.5; // shrink factor - this is measured from the actual bricks

bl = sf * 9; // brick length
bw = sf * 4.5; // brick width
bh = sf * 1.5; // brick height
bhd = sf * 3/4; // brick hole diameter

hs = sf * 4.5; // this is the primary hole spacing for threaded rods and metal strips

shd = 17/64; // strip hole diameter
shsl = 18; // short strip length
losl = 25; // long strip length
lisl = 11; // lid strip length

shsw = 1; // short strip width
shsh = 0.125; // short strip height
losw = 1; // long strip width
losh = 0.125; // long strip height
lisw = 1; // lid strip width
lish = 0.125; // lid strip height

thrdrd = 0.25; // threaded rod diameter
lothL = 14; // long vertical threaded rod length
shothL = 6; // short vertical threaded rod length
lidthL = 18; // lid threaded rod length

heatloop = bl; // heater loop width
heatgap = bl/4; // heater gap distance
heatcoil = 1/2; // heater coil diameter
heatstem = 1.25*bw; // heater stem length

// Lower metal layer
for (i = [-1.5, -0.5, 0.5, 1.5])
{
    translate([i*hs,0,-3*shsh/2])
        rotate([0,0,90])
            shortStrip();
}

// Upper metal layer
for (i = [-0.5, 0.5])
{
    translate([-hs,i*hs,-shsh/2])
        longStrip();
}
for (i = [-1.5, 1.5])
{
    translate([0,i*hs,-shsh/2])
    shortStrip();
}

// Long threaded rods
for (i = [-3/2, 3/2])
{
    for (j = [-3/2, -1/2, 1/2, 3/2])
    {
        translate([i*hs, j*hs, lothL/2 -2.5])
            threadedRod(trodHeight=lothL);
    }
}
for (i = [-1/2, 1/2])
{
    for (j = [-3/2, 3/2])
    {
        translate([i*hs, j*hs, lothL/2 -2.5])
            threadedRod(trodHeight=lothL);
    }
}

// Short threaded rods
for (i = [-1/2, 1/2])
{
    for (j = [-1/2, 1/2])
    {
        translate([i*hs-3*hs, j*hs, shothL/2 -2.5])
            threadedRod(trodHeight=shothL);
    }
}

LayerOne();
LayerTwo();
LayerThree();
translate([0,0,3*bh-1.1*heatcoil/2])
    color("red")
    heater(heatloop, heatgap, heatcoil, heatstem);
LayerFour();
translate([0,0,4*bh-1.1*heatcoil/2])
    color("red")
        heater(heatloop, heatgap, heatcoil, heatstem);
LayerFive();
translate([0,0,5*bh-1.1*heatcoil/2])
    color("red")
        heater(heatloop, heatgap, heatcoil, heatstem);
LayerSix();
LayerSeven();
translate([0,0,7*bh-1.1*heatcoil/2])
    color("red")
        heater(heatloop, heatgap, heatcoil, heatstem);
LayerEight();
Lid();
 