#!/usr/bin/perl -w

# $Id: simpat-help-frm.pl,v 1.1 1999/03/28 11:33:48 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package help ;


my $HelpWin ; 


sub form {

    &main::cursor( 'clock' ) ;
    &canvas::status( 'Showing help...' ) ;

    # Set up the help window and some bindings to close it.
    $HelpWin = $main::Win->Toplevel() ; 
    $HelpWin->title( 'Simpat Help' ) ;
    $HelpWin->protocol( "WM_DELETE_WINDOW", \&close ) ;
    $HelpWin->bind( '<q>',         \&close ) ;
    $HelpWin->bind( '<Alt-q>',     \&close ) ;
    $HelpWin->bind( '<Control-q>', \&close ) ;
    $HelpWin->bind( '<Escape>',    \&close ) ;

    # Set up the text widget.
    my $text_box = $HelpWin->Scrolled( 'Text', 
                    -background => 'white', 
                    -wrap       => 'word',
                    -scrollbars => 'ow',
                    -width      => 80, 
                    -height     => 40,
                    -takefocus  => 0,
                    )->pack( -fill => 'both', -expand => 'y' ) ;
    my $text = $text_box->Subwidget( 'text' ) ;
    $text->configure( -takefocus => 1 ) ;
    $text->focus ;

    if( open HELP, $main::Const{HELP_FILE} ) {
		local $/ = '' ; # render_pod requires paragraphs.
		&tk::text::render_pod( $text, <HELP> ) ;
		close HELP ;
	}
	else {
		message( 
		    'Warning', 
		    'Help', 
		    "Cannot open help file `$main::Const{HELP_FILE}': $!"
		    ) ;
	}

    $text->configure( -state => 'disabled' ) ;
}


sub close {
    package main ;

    &cursor() ;
    &canvas::status( '' ) ;
    $HelpWin->destroy ;
}


1 ;
