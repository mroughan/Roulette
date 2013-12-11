Roulette
========

Compute roulette curves (derived by rolling one curve against another), in matlab.


### Description

This package contains code for drawing "roulettes" which are
mathematical curves created when one shape is rolled against another
and we trace a location relative to the curve as it rolls (think
spirographs).

### Contents

The code contains:
   - `roulette1.m`: calculates roulettes of specified curve when rolled along the x-axis
   - `roulette2.m`: calculates roulettes of one curve rolled against another

In each of these cases curves are specified by a two functions: 
   - one takes a parameters t (or vector of parameters) and returns
      the appropriate $(x,y)$ Cartesian coordinates along the curve.
   - the other returns the derivatives $(dx/dt, dy/dt)$ at the same
      points
 
There are several examples of such functions in the packages
   - `ellipse.m` and `ellipsed.m` (which can do a circle as a special case)
   - `hyperbola.m` and `hyperbolad.m`
   - `parabola.m` and `parabolad.m`

There are also several precalculated roulettes to use as test
functions
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
of how to use the code:
   - `arclength_test.m`: provides tests of the arclength code
   - `roulette1_test.m`: shows a selection of standard roulettes both
                       calculated using roulette1, and using the
		       theoretical curve 
   - `roulette2_test.m`: tests a selection of standard roulettes formed
                       from two curves


Matt Roughan, 2013
