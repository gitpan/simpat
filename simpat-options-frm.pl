#!/usr/bin/perl -w

# $Id: simpat-options-frm.pl,v 1.1 1999/03/28 11:33:48 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package options ;


my $OptionsWin ; 


sub form {
    package main ;

    &cursor( 'clock' ) ;
    &canvas::status( 'Setting options...' ) ;

    # Start with existing values.

    # Set up the options window. 
    $OptionsWin = $Win->Toplevel() ;
    $OptionsWin->title( 'Simpat Options' ) ;
    $OptionsWin->protocol( "WM_DELETE_WINDOW", [ \&options::close, 0 ] ) ;

    &options::key_bindings ;


    my $Frame = $OptionsWin->Frame()->pack( -side => 'top' ) ;

    
    # Widgets go here.


    $Frame = $Frame->Frame()->grid(
			-row        => 9, 
			-column     => 0,
			-columnspan => 3,
			) ;

    # Save button.
    $Frame->Button(
        -text      => 'Save',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => [ \&options::close, 1 ],
        )->pack( -side => 'left' ) ;

    # Cancel button.
    $Frame->Button(
        -text      => 'Cancel',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => [ \&options::close, 0 ],
        )->pack( -side => 'left' ) ;

    # Defaults button.
    $Frame->Button(
        -text      => 'Defaults',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => \&options::defaults,
        )->pack( -side => 'left' ) ;
}


sub create_scale {
    my( $min, $max, $interval, $title, $row ) = @_ ;

    my $scale = $OptionsWin->Scale( 
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
    $OptionsWin->bind( '<Alt-c>',     [ \&close, 0 ] ) ;
    $OptionsWin->bind( '<Control-c>', [ \&close, 0 ] ) ;
    $OptionsWin->bind( '<Escape>',    [ \&close, 0 ] ) ;

    # Save keycanvas bindings.
    $OptionsWin->bind( '<Alt-s>',     [ \&close, 1 ] ) ;
    $OptionsWin->bind( '<Control-s>', [ \&close, 1 ] ) ;
    $OptionsWin->bind( '<Return>',    [ \&close, 1 ] ) ;
    
    # Defaults keycanvas bindings.
    $OptionsWin->bind( '<Alt-d>',     \&defaults ) ;
    $OptionsWin->bind( '<Control-d>', \&defaults ) ;
}


sub close {
    package main ;

    shift if ref $_[0] ; # Some callers include an thing ref.
    my $save = shift ;

    if( $save ) {

        &write_opts ;
    }

    &cursor() ;
    &canvas::status( '' ) ;
    $OptionsWin->destroy ;
}


sub defaults {
    package main ;

}


1 ;
