#!/usr/bin/perl -w

# $Id: simpat-simulation-frm.pl,v 1.3 1999/04/07 20:53:42 root Exp $

# (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package simulation ;

my $SimulationWin ; 
my %TempParam ;

# This should allow us to choose a rule set from file, and then to
# set any parameter values associated with that ruleset.

sub form {
    package main ;

    &cursor( 'clock' ) ;
    &canvas::status( 'Setting simulation properties...' ) ;

    # Start with existing values.
    %TempParam = %Param ;

    # Set up the simulation window. 
    $SimulationWin = $Win->Toplevel() ;
    $SimulationWin->title( 'Simpat Simulation Properties' ) ;
    $SimulationWin->protocol( "WM_DELETE_WINDOW", [ \&simulation::close, 0 ] ) ;

    &simulation::key_bindings ;


    my $Frame = $SimulationWin->Frame()->
        pack( -side => 'top', -padx => 5, -pady => 5 ) ;

    my $row = 0 ;

    # Widgets go here.
    $Frame->Label( -text => 'Rules:', -justify => 'left' )->
			grid( -row => $row, -column => 0, -columnspan => 1, 
			      -sticky => 'w' ) ;
    $Frame->Label( 
        -text    => &simulation::rulename, 
        -justify => 'left',
		-anchor  => 'w', 
		)->grid( -row => $row++, -column => 1, -columnspan => 2, 
		         -sticky => 'nsew', ) ;

    my $first ;
    foreach my $key ( sort keys %Param ) {
		$Frame->Label( -text => "$key:", -justify => 'left', -anchor => 'w' )->
			grid( -row => $row, -column => 0, -columnspan => 1, 
			      -sticky => 'w' ) ;
		my $entry = $Frame->Entry( 
			-justify      => 'left',
			-textvariable => \$TempParam{$key},
			)->grid( -row => $row++, -column => 1, -columnspan => 2, 
					 -sticky => 'nsew', ) ;
	    $first = $entry unless defined $first ;
    }

    $first->focus ;

    $Frame = $Frame->Frame()->grid(
			-row        => $row++, 
			-column     => 0,
			-columnspan => 3,
			) ;

    # Save button.
    $Frame->Button(
        -text      => 'Save',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => [ \&simulation::close, 1 ],
        )->pack( -side => 'left' ) ;

    # Cancel button.
    $Frame->Button(
        -text      => 'Cancel',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => [ \&simulation::close, 0 ],
        )->pack( -side => 'left' ) ;

    # Defaults button.
    $Frame->Button(
        -text      => 'Defaults',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => \&simulation::defaults,
        )->pack( -side => 'left' ) ;
}


sub create_scale {
    my( $min, $max, $interval, $title, $row ) = @_ ;

    my $scale = $SimulationWin->Scale( 
        -orient       => 'horizontal',
        -from         => $min,
        -to           => $max,
        -tickinterval => $interval,
        -label        => $title,
        '-length'     => 300,
        )->canvas( -row => $row, -column => 0, -rowspan => 2, -columnspan => 3 ) ;

    $scale ;
}


sub key_bindings {

    # Cancel keycanvas bindings.
    $SimulationWin->bind( '<Alt-c>',     [ \&close, 0 ] ) ;
    $SimulationWin->bind( '<Control-c>', [ \&close, 0 ] ) ;
    $SimulationWin->bind( '<Escape>',    [ \&close, 0 ] ) ;

    # Save keycanvas bindings.
    $SimulationWin->bind( '<Alt-s>',     [ \&close, 1 ] ) ;
    $SimulationWin->bind( '<Control-s>', [ \&close, 1 ] ) ;
    $SimulationWin->bind( '<Return>',    [ \&close, 1 ] ) ;
    
    # Defaults keycanvas bindings.
    $SimulationWin->bind( '<Alt-d>',     \&defaults ) ;
    $SimulationWin->bind( '<Control-d>', \&defaults ) ;
}


sub close {
    package main ;

    shift if ref $_[0] ; # Some callers include an thing ref.
    my $save = shift ;

    if( $save ) {
        %Param = %TempParam ;
        &write_opts ;
    }

    &cursor() ;
    &canvas::status( '' ) ;
    $SimulationWin->destroy ;
}


sub defaults {
    package main ;

    foreach my $key ( keys %Param ) {
        $TempParam{$key} = $Param{$key} ;
	}
#    %TempParam = %Param ; # Doesn't update entries.
}


1 ;
