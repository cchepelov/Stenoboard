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

include <common_parameters.scad>;
include <common_parameters_base.scad>;
use <common_library.scad>;
use <common_library_primitives.scad>;



// MODULE CALLS


//translate([-46, 35, 0]) consonantsKeyboard(keys = 6, numberKeyIndex = 3, rightWideKeyIndex = 0, leftWideKeyIndex = 5, drawTopRow = true, drawBottomRow = true, drawFrame = true);
//color("gray") 
//translate([-46, 35, 0]) translate([0,0,2])
//translate([-46, 10, 0]) barKeyboard();
//barButtonContact();
//rightBaseBridgeTest();
//translate([-45.73, 50, 0]) base();
//translate([0, 130, 0])
//translate([-45.73, 50, 0]) base(isRight = false);
//translate([0, 0, rightVowelsScrewH + screwFrameVerticalOffset + 0.2])
//translate([-14.5, 75, 0]) 
translate([-14.5, 24, 0]) vowelsKeyboard();
//translate([-45.73, 50, 0]) cover();
//rightAssembly(drawConsonants = true, drawNumbers = true);


module test(keyW = 13, keyD = 25, keyH = 5.25, topBevelR = 0.8,  drawDifference = true, isRightWideKey = false, isLeftWideKey = false, drawDifference = true, isNearNumberSwitchKey = [false, false], tolerance = GeneralFacetTolerance) {
    
    bezelizeTopSurface(keyH, topBevelR, tolerance = tolerance) 
	union() {
      translate([-keyW / 2 + (isLeftWideKey ? -2.4 : 0), 0, 0]) union() {
	cubeX([keyW + (isLeftWideKey ? 2.4 : 0) + (isRightWideKey ? 2.4 : 0) , keyD / 2, keyH]);
	translate([0, keyD/4, 0]) cylinderXR(r = keyD/4, h = keyH, tolerance = tolerance);
	}
    };
	
}

test();
