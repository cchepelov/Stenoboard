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

/* These parameters are imported in every file. These control generic aspects such as
  tolerances, surface roughness, and constants which never change in the Universe such 
  as Pi, Avogadro's number and the Arduino board's screw hole positions.

  Stenoboard device parameters are stored in common_parameters.scad instead, and must be 
  carried around as part of parameter invocation.
  
*/

drawKeySupport = false;
drawKeySurfaceTopBevel = true;
drawKeySurfaceDifference = true;
keySurfaceDifferenceFn = 256;
scaleKeyTopBevel = 1.4;

/* The General Facet Tolerance. This is used to compute the best $fa parameters in spheres & cylinders.
Set it too big and facets will show up on printed artifacts, set it too low and your CPU & RAM will choke. */
GeneralFacetTolerance = 0.10;


