#!/usr/bin/perl -w

# $Id: simpat-toolbar-cmd.pl,v 1.1 1999/03/28 11:33:48 root Exp $

# (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package toolbar ;


sub enter {
    package main ;

    my $button = shift if ref $_[0] ;
    my $text   = shift ;

    $text = '' unless $text ;

    &cursor( 'left_ptr' ) ;
    &canvas::status( $text ) ;
}


sub mkbutton {
    package main ;

    my( $frame, $button, $command, $text ) = @_ ;

	$Toolbar{$button . '_SIM'} = $frame->Button(
		-image   => $Const{$button . '_IMAGE'},
		-command => $command,
		)->pack( -side => 'left' ) ;
	$Toolbar{$button . '_SIM'}->bind( '<Enter>', 
		[ \&toolbar::enter, $Toolbar{$button . '_SIM'}, $text ] ) ;
	$Toolbar{$button . '_SIM'}->bind( '<Leave>', \&toolbar::enter ) ;
}


1 ;
