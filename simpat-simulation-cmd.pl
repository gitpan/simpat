#!/usr/bin/perl -w

# $Id: simpat-simulation-cmd.pl,v 1.5 1999/04/08 20:00:32 root Exp $

# (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package simulation ;

my $Initialised = 0 ;


sub rules {
    package main ;

	&cursor( 'clock' ) ;
	$Opt{DIR}  = &abs_path( $Opt{DIR} ) ;
	my $dialog = $Win->FileSelect( 
					-directory => $Opt{DIR},
					-filter    => "*$Const{RULE_FILE_SUFFIX}",
					) ;
	my $filename = $dialog->Show ;
	&cursor() ; 

	if( $filename ) {
	    local $^W = 0 ; # We're redefining subroutines and don't want perl to complain.
		&load_library( $filename ) ;
	    &canvas::status( 'Loaded new rules.' ) ;
	}
}


sub load {
    package main ;

print STDERR "Simulation load not implemented yet.\n" ;
}


sub save {
    package main ;

print STDERR "Simulation save not implemented yet.\n" ;
}


sub rulename {
    package main ;

    &{$Routine{RULENAME}} ;
}


sub initialise {
    package main ;

	for( my $x = 0 ; $x < $Opt{WIDTH} ; $x++ ) {
		for( my $y = 0 ; $y < $Opt{HEIGHT} ; $y++ ) {
			$OldPixel[$x][$y] = $Const{DEAD_COLOUR} ;
			$NewPixel[$x][$y] = $Const{DEAD_COLOUR} ; 
		}
	}

    &canvas::generation( 0 ) ;
    &{$Routine{INITIALISE}} ;
    &canvas::create ;
    $Initialised = 1 ;
}


sub start {
    package main ;

    &simulation::initialise unless $Initialised ;
    &{$Routine{START}} ;
    $Global{RUNNING} = 1 ;
    do {
		&simulation::step ;
	} while( $Global{RUNNING} ) ;
}


sub stepback {
    package main ;

    &canvas::generation( -1 ) ;
    &{$Routine{STEPBACK}} ;
    &canvas::update ;
}


sub step {
    package main ;

    &cursor( 'watch' ) ;
    &canvas::status( 'Calculating...' ) ;
    &canvas::generation( 1 ) ;
    &{$Routine{STEP}} ;
    &cursor() ;
    &canvas::update ;
}


sub stepto {
    package main ;

    &{$Routine{STEPTO}} ;
    &canvas::update ;
}


sub pause {
    package main ;

    &{$Routine{PAUSE}} ;
    $Global{RUNNING} = 0 ;
    &cursor() ;
}


sub stop {
    package main ;

    &{$Routine{STOP}} ;
    $Global{RUNNING} = 0 ;
    &cursor() ;
}


sub clear {
    package main ;

	for( my $x = 0 ; $x < $Opt{WIDTH} ; $x++ ) {
		for( my $y = 0 ; $y < $Opt{HEIGHT} ; $y++ ) {
			$OldPixel[$x][$y] = $Const{DEAD_COLOUR} ;
			$NewPixel[$x][$y] = $Const{DEAD_COLOUR} ; 
		}
	}
    &{$Routine{CLEAR}} ;
    &canvas::update ;
}


1 ;
