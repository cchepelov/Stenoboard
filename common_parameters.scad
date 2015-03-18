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

// VALUES


hKeyDistance = 18.325;
vowelsKeyDistance = 14.5;
framePosition = [-17.75, -69.5, 0];

boardCenter = [46,-41.25,0];
rightRReference = boardCenter + [-hKeyDistance * 1.5, -22, 0];
rightEReference = rightRReference + [-11.3, -27, 0];
screwFrameVerticalOffset = 8.7;
leftVowelsOffset = 11.3 * 2 + hKeyDistance * 3 - 14.5 - 0.65;
screw1 = [103.9, 2.5, 0];
screw2 = [-12.75, 2.5, 0];
screw3 = [-12.75, -62.5, 0];
screw4 = [103.9, -62.5, 0];
frameScrewPositions = [screw1, screw2, screw3, screw4];
frameScrewD = 3.0;
mainRightScrewPositions = [[-37.465,11.43,0], [40.64,13.97,0], [-34.29,-10.795,0], [34.925,-10.795,0]];
mainRightScrewBevels = [[false, false, true, false], [true, false, false, true], [false, true, true, true], [true, false, true, true]];
mainRightScrewH = 20.1;
mainRightScrewD = 3.0;
mainLeftScrewPositions = [[-16.51,12.065,0], [40.005,13.335,0], [-34.29,-10.795,0], [36.83,-11.43,0]];
mainLeftScrewBevels = [[true, true, true, true], [true, true, true, true], [true, true, true, true], [true, true, true, true]];
rightVowelsScrewPositions = [[-1.27,9.525,0], [16.51,9.525,0], [7.62,-9.525,0]];
rightVowelsScrewBevels = [[true, true, true, true], [true, true, true, true], [true, true, false, false]];
rightVowelsScrewH = mainRightScrewH - 9.3;
rightVowelsScrewD = 3.0;
arduinoScrewPositions = [[0, 0, 0], [50.8, -15.2, 0], [50.8, -15.2 - 27.9, 0], [-1.3, -15.2 -27.9 -5.1, 0]];
arduinoScrewOffset = [-17.5, 45, 0];
arduinoScrewH = 6;
arduinoScrewD = 3;
rightVowelsBasePosition = [-8.5, -107, 0];
rightVowelsBaseScrewD = 3.0;

/* These aren't parameters per se, but are useful to check where we are (screw positions etc.): */

%translate(boardCenter) cylinder(r=1,h=10,$fn=6);
%translate(rightRReference) cylinder(r=1,h=10,$fn=6);
%translate(rightEReference + [0, 0, 30]) cylinder(r=1,h=10,$fn=6);
%translate(frameScrewPositions[0]) cylinder(r=1,h=50,$fn=6);
%translate(frameScrewPositions[1]) cylinder(r=1,h=50,$fn=6);
%translate(frameScrewPositions[2]) cylinder(r=1,h=50,$fn=6);
%translate(frameScrewPositions[3]) cylinder(r=1,h=50,$fn=6);

