Roulette
========

Compute roulette curves (derived by rolling one curve against another), in matlab.

========

### Description

This package contains code for drawing "roulettes" which are
mathematical curves created when one shape is rolled against another
and we trace a location relative to the curve as it rolls (think
spirographs).

Exact algorithms and sources are documented in the code.

### Dependencies

Currently it can either compute elliptic integrals by numeric
integration (which is a bit crude), or using the package
at http://code.google.com/p/elliptic/. If you want to use the latter,
then you need to set the path to find it in `common.m`. Some of the
tests assume you have the second more accurate method for doing
calculations of arc lengths. 

### Install
   
Change into the main directory, and run "common.m" to put the
subdirectories on the path. 

Edit elliptic_int_test.m to show the path to the elliptical integral
code if this is installed, or leave it blank if not (results will be
potentially faster and more accurate with that code).

Then run the tests to see if everything works, and use them as an
example to get things going.


### Contents

The code contains:
   - `roulette1.m`: calculates roulettes of specified curve when rolled along the x-axis
   - `roulette2.m`: calculates roulettes of one curve rolled against another

In each of these cases curves are specified by a two functions: 
   - one takes a parameters $t$ (or vector of parameters) and returns
      the appropriate $(x,y)$ Cartesian coordinates along the curve.
   - the other returns the derivatives $(dx/dt, dy/dt)$ at the same
      points
 
There are several examples of such functions in the directory `Curves/`
   - `ellipse.m` and `ellipsed.m` (which can do a circle as a special case)
   - `hyperbola.m` and `hyperbolad.m`
   - `parabola.m` and `parabolad.m`

There are also several precalculated roulettes to use as test
functions in the directory `Roulettes/`
   - `cycloid.m``: roulette of a circle on a line
                    (includes prolate and curtate cases)
   - `epitrochoid.m`: roulette of a circle on the outside of another circle
                    (epicycloid is a special case)
   - `hypotrochoid.m`: roulette of a circle on the inside of another circle
                (hypocycloid is a special case)
   - `undulary.m`: gives the roulette of an ellipse along a straight line
   - `nodary.m`: gives the roulette of a hyperbola, 
        NB: there are two curves created by this, one for each focus
	of the hyperbola
   - `catenary.m`: gives the roulette of a parabola
   - `cissoid.m`: of Dioclese: the roulette of two parabolas

There is one function defined to help in calculations
   - `arclength.m` numerically calculates arclengths along curves
     in whatever parameterisation is being used

There are a couple of test scripts, which also provide some examples
of how to use the code in the directory 'Tests_and_Examples/'
   - `arclength_test.m`: provides tests of the arclength code. It does
                         some diagnostic plots, 
			 and outputs differences between numerical and
			 theoretical arclengths. Some deviations at
			 about the 1.0e-6 level occur.
   - `roulette1_test.m`: shows a selection of standard roulettes both
                       calculated using roulette1, and using the
		       theoretical curve 
   - `roulette2_test.m`: tests a selection of standard roulettes formed
                       from two curves

The two directories:
   - Plots/
   - Animations/

contain output from examples.

### Examples

For examples of how to use the code see 
   - `roulette1_test.m`
   - `roulette2_test.m`
   - `roulette_animate.m`

The test code does a few plots, which go in the Plots/ directory.

There is also an script that will create some animations in the
Animations/ directory.


Matt Roughan, 2015
