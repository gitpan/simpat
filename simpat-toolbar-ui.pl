#!/usr/bin/perl -w

# $Id: simpat-toolbar-ui.pl,v 1.2 1999/03/28 15:06:14 root Exp $

# (c) Mark Summerfield 1999. All s Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


# The toolbar frame.
my $Frame = $Win->Frame(
                 -bg => 'gray80',
                )->pack( -anchor => 'nw', -fill => 'x' ) ;


# Simulation control.

{
	package toolbar ;

	&mkbutton( $Frame, 'INITIALISE', \&simulation::initialise, 'Initialise.' ) ;
	&mkbutton( $Frame, 'START',      \&simulation::start,      'Start.' ) ;
	&mkbutton( $Frame, 'STEPBACK',   \&simulation::stepback,   'Step back.' ) ;
	&mkbutton( $Frame, 'STEP',       \&simulation::step,       'Step forward.' ) ;
	&mkbutton( $Frame, 'STEPTO',     \&simulation::stepto,     'Step to...' ) ;
	&mkbutton( $Frame, 'PAUSE',      \&simulation::pause,      'Pause.' ) ;
	&mkbutton( $Frame, 'STOP',       \&simulation::stop,       'Stop.' ) ;
	&mkbutton( $Frame, 'CLEAR',      \&simulation::clear,      'Clear.' ) ;
}


1 ;
