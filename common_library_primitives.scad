/**
 * Stenoboard is an open source stenographic keyboard.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright 2014 Emanuele Caruso. See LICENSE for details.
 */

include <common_parameters_base.scad>;

minAngleTolerance = (1/3);

module cubeX(size = 1, center = false, tolerance = "(ignored)") { cube(size, center); }

module sphereXR(r = 1, center = false, tolerance = GeneralFacetTolerance) {	
	echo("sphere $fa=", 2*acos( ((r - tolerance) / r)  ), " $fs=", 2 * r * sin(2*acos( ((r - tolerance) / r)) ) );

	sphere(r = r, center = center, 
		$fa = 2*acos( ((r - tolerance) / r)  ), 
		$fs= 2 * r * sin(2*acos( ((r - tolerance) / r)) ) );
}
module sphereXD(d = 1, center = false, tolerance = GeneralFacetTolerance) {
	sphereXR(r = d/2, center = center, tolerance = tolerance);
}
module cylinderXR(h = 1, r = 1, center = false, tolerance = GeneralFacetTolerance) {
	echo("cylinder $fa=", 2*acos( ((r - tolerance) / r)  ), " $fs=", 2 * r * sin(2*acos( ((r - tolerance) / r)) ) );

	cylinder(h = h, r = r, center = center, 
		$fa = 2*acos( ((r - tolerance) / r)  ), 
		$fs= 2 * r * sin(2*acos( ((r - tolerance) / r)) ) );
}
module cylinderXD(h = 1, d = 1, center = false, tolerance = GeneralFacetTolerance) {
	cylinderXR(h = h, r = d/2, center = center, tolerance = tolerance);
}


/*
module cylinderXRR(h = 1, r1 = 1, r2 = 1, center = false, tolerance = GeneralFacetTolerance) {
	let (rm = ((r1 < r2) ? r1 : r2) )
		cylinder(h = h, r1 = r1, r2 = r2 center = center, $fa = 2*asin(rm - tolerance/rm) );
}
module cylinderXDD(h = 1, d1 = 1, d2 = 1, center = false, tolerance = GeneralFacetTolerance) {
	let (rm = min(d1,d2)/2)
		cylinder(h = h, d1 = d1, d2 = d2 center = center, $fa = 2*asin(rm - tolerance/rm) );
}*/

module cornerBevel(r = 2, length = 100, minThickness = 0, tolerance = GeneralFacetTolerance) {
  #rotate([0, 0, 180]) rotate([-90, 0, 0]) bevel(r = r, length = length, minThickness = minThickness, tolerance = tolerance);
}

module bevel(r = 2, length = 100, minThickness = 0, tolerance = GeneralFacetTolerance) {
  difference() {
    cubeX([(r + minThickness) * 2, (r + minThickness) * 2, length], center = true, tolerance = tolerance);
    translate([r, r, 0]) cylinderXR(r = r, h = length * 2, center = true, tolerance = tolerance);
    for (i = [0, 1]) rotate([0, 0, i * -90]) translate([-0, -r * 2 - 0.001, 0]) cubeX(size = [r * 4, r * 4, length*2], center = true, tolerance = tolerance);
  }
}

module beveledCube(cubeEdges, center = false, bevelR = 2, 
	bevelX = [true, true], bevelY = [true, true], tolerance = GeneralFacetTolerance) {

  difference() {
    cubeX(cubeEdges, center = center);
    translate([center ? 0 : cubeEdges[0] / 2, center ? 0 : cubeEdges[1] / 2, 0])
    for (i = [0 : 1]) for (j = [0 : 1]) if(bevelX[i] && bevelY[j]) {
      mirror([i, 0, 0]) mirror([0, j, 0]) translate(center ? [-cubeEdges[0] / 2, -cubeEdges[1] / 2, 0] : [-cubeEdges[0] / 2, -cubeEdges[1] / 2, cubeEdges[2] / 2]) bevel(r = bevelR, length = cubeEdges[2] + 0.01, tolerance = tolerance);
    }
  }
}


module peelOffThickness(thickness, tolerance=GeneralFacetTolerance) {
	difference() {
		children(0);
		minkowski($fa = 2*acos( ((thickness - tolerance) / thickness)  ) ) {
			difference() {
				minkowski($fa = 2*acos( ((thickness - tolerance) / thickness)  ) ) { children(0); cubeX(size=thickness, center=true); }
				children(0);
			}
			cubeX(size=thickness, center=true);
		}	
	}
}

module bezelizeTopSurface(height, bezelR, topS=[30,30], tolerance = GeneralFacetTolerance) {
	union() {
		intersection() {
			minkowski($fa = 2*acos( ((bezelR - tolerance) / bezelR)  ) ) {
				peelOffThickness(thickness = bezelR, tolerance=tolerance) { children(0); }
				sphereXR(r = bezelR, center=true, tolerance = tolerance);
			}

			translate([-topS[0]/2, -topS[1]/2, -bezelR + height - 1]) cubeX(size=[topS[0],topS[1],height], center=false);
		}


		intersection() {
			minkowski() {
				peelOffThickness(thickness = bezelR, tolerance=tolerance) { children(0); }
				cylinderXR(r = bezelR, h=2*bezelR, center=true, tolerance = tolerance);
			}
			translate([-topS[0]/2, -topS[1]/2, -bezelR ]) cubeX(size=[topS[0],topS[1],height], center=false);
		}
	}
}


module advancedBeveledCube(cubeEdges, center = false, bevelR = 2, bevelX = [true, true], bevelY = [true, true], topBevels = [true, true, true, true], topBevelR = 0.8, scaleTopBevel = 1, tolerance = GeneralFacetTolerance, bevelSegments = 3) {
 
  union() {
		difference() {
	  			beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);
	
			union() {
				scale([ 1.1, 1.1, 1 ])
		  			beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);
				translate([0, 0, -(cubeEdges[2]+topBevelR)/cubeEdges[2]]) scale([ 1, 1, 1.2 ])
		  			beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);
			}
		}


	*minkowski($fs = 0.1) {
		difference() {	
			*minkowski($fs = 0.1) {
			  beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);
			  cubeX(size = topBevelR, center=true, tolerance = tolerance);
			}
			union() {
				resize([ (cubeEdges[0]+topBevelR)/cubeEdges[0], (cubeEdges[1]+topBevelR)/cubeEdges[1], 1 ])
	 	  			beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);
				resize([ 1, 1, (cubeEdges[2]+topBevelR)/cubeEdges[2] ])
	 	  			beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);
			}
		}
		sphereXR(r = topBevelR, center=true, tolerance = tolerance);
	}



  difference() {
    *beveledCube(cubeEdges = cubeEdges, center = center, bevelR = bevelR, tolerance = tolerance, bevelX = bevelX, bevelY = bevelY);

    // Top bevels
    if(topBevels[2]) translate([center ? -cubeEdges[0] / 2 : 0, 0, cubeEdges[2] / (center ? 2 : 1)]) rotate([-90, 0, 0]) scale([1, scaleTopBevel, 1]) bevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance, minThickness = 0);

/*
    if(topBevels[0]) translate([center ? cubeEdges[0] / 2 : cubeEdges[0], 0, cubeEdges[2] / (center ? 2 : 1)]) rotate([0, 0, 180]) rotate([-90, 0, 0]) scale([1, scaleTopBevel, 1]) bevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance,  minThickness = 0);
    if(topBevels[3])  translate([0, (center ? -cubeEdges[1] / 2 : 0), cubeEdges[2] / (center ? 2 : 1)]) rotate([0, 90, 0]) scale([scaleTopBevel, 1, 1]) bevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance,  minThickness = 0);
    if(topBevels[1]) translate([0, (center ? cubeEdges[1] / 2 : cubeEdges[1]), cubeEdges[2] / (center ? 2 : 1)]) rotate([0, 0, 180]) rotate([0, 90, 0]) scale([scaleTopBevel, 1, 1]) bevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance, minThickness = 0);
    // Top corner bevels

    if(topBevels[0] && topBevels[1]) 
		for(i = [0 : bevelSegments - 1]) 
			translate([cubeEdges[0] / (center ? 2 : 1) - bevelR, cubeEdges[1] / (center ? 2 : 1) - bevelR, cubeEdges[2] / (center ? 2 : 1)]) 
		rotate([0, 0, (90 / bevelSegments / 2) + i * (90 / bevelSegments)]) 
		translate([bevelR, bevelR, 0]) 
		scale([1, 1, scaleTopBevel]) 
			cornerBevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance, minThickness = 0);


    if(topBevels[1] && topBevels[2]) translate([(!center ? cubeEdges[0] / 2 : 0), (!center ? cubeEdges[1] / 2 : 0), 0]) mirror([1, 0, 0]) for(i = [0 : bevelSegments - 1]) translate([cubeEdges[0] / 2 - bevelR, cubeEdges[1] / 2 - bevelR, cubeEdges[2] / (center ? 2 : 1)]) rotate([0, 0, (90 / bevelSegments / 2) + i * (90 / bevelSegments)]) translate([bevelR, bevelR, 0]) scale([1, 1, scaleTopBevel]) cornerBevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance, minThickness = 0);
    if(topBevels[2] && topBevels[3]) translate([(!center ? cubeEdges[0] / 2 : 0), (!center ? cubeEdges[1] / 2 : 0), 0]) mirror([1, 0, 0])  mirror([0, 1, 0]) for(i = [0 : bevelSegments - 1]) translate([cubeEdges[0] / 2 - bevelR, cubeEdges[1] / 2 - bevelR, cubeEdges[2] / (center ? 2 : 1)]) rotate([0, 0, (90 / bevelSegments / 2) + i * (90 / bevelSegments)]) translate([bevelR, bevelR, 0]) scale([1, 1, scaleTopBevel]) cornerBevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, minThickness = 0, tolerance = tolerance);
    if(topBevels[0] && topBevels[3]) translate([(!center ? cubeEdges[0] / 2 : 0), (!center ? cubeEdges[1] / 2 : 0), 0]) mirror([0, 1, 0])  for(i = [0 : bevelSegments - 1]) translate([cubeEdges[0] / 2 - bevelR, cubeEdges[1] / 2 - bevelR, cubeEdges[2] / (center ? 2 : 1)]) rotate([0, 0, (90 / bevelSegments / 2) + i * (90 / bevelSegments)]) translate([bevelR, bevelR, 0]) scale([1, 1, scaleTopBevel]) cornerBevel(r = topBevelR, length = (cubeEdges[0] + cubeEdges[1]) * 3, tolerance = tolerance, minThickness = 0);
	*/
  }

	

    if(topBevels[3] && topBevels[0]) 
		translate([center ? 0 : cubeEdges[0] / 2, center ? 0 : cubeEdges[1] / 2, center ? 0 : cubeEdges[2] / 2]) 
		translate([ - cubeEdges[0]/2, - cubeEdges[1]/2, cubeEdges[2] / 2]) 
			cubeX(size= 2 * topBevelR, center=true);


    if(topBevels[0] && topBevels[1]) 
		translate([center ? 0 : cubeEdges[0] / 2, center ? 0 : cubeEdges[1] / 2, center ? 0 : cubeEdges[2] / 2]) 
		translate([ - cubeEdges[0]/2, +cubeEdges[1]/2, cubeEdges[2] / 2]) 
			cubeX(size= 2 * topBevelR, center=true);

    if(topBevels[1] && topBevels[2]) 
		translate([center ? 0 : cubeEdges[0] / 2, center ? 0 : cubeEdges[1] / 2, center ? 0 : cubeEdges[2] / 2]) 
		translate([ + cubeEdges[0]/2, +cubeEdges[1]/2, cubeEdges[2] / 2]) 
			cubeX(size= 2 * topBevelR, center=true);

    if(topBevels[2] && topBevels[3]) 
		translate([center ? 0 : cubeEdges[0] / 2, center ? 0 : cubeEdges[1] / 2, center ? 0 : cubeEdges[2] / 2]) 
		translate([ + cubeEdges[0]/2, - cubeEdges[1]/2, cubeEdges[2] / 2]) 
			cubeX(size= 2 * topBevelR, center=true);
}
}

