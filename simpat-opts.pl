#!/usr/bin/perl -w

# $Id: simpat-opts.pl,v 1.4 1999/04/08 20:00:32 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


$Opt{CANVAS_WIDTH}             = $Const{CANVAS_WIDTH_DEF} ;
$Opt{CANVAS_HEIGHT}            = $Const{CANVAS_HEIGHT_DEF} ;
$Opt{CANVAS_SCALE}             = $Const{CANVAS_SCALE_DEF} ;
$Opt{WIDTH}                    = int( $Opt{CANVAS_WIDTH}  / $Opt{CANVAS_SCALE} ) ;
$Opt{HEIGHT}                   = int( $Opt{CANVAS_HEIGHT} / $Opt{CANVAS_SCALE} ) ;

$Opt{CANVAS_BACKGROUND_COLOUR} = $Const{CANVAS_BACKGROUND_COLOUR} ;
$Opt{USER_COLOUR}              = $Const{USER_COLOUR} ;

$Opt{VERBOSE}                  = $Const{VERBOSE} ;

$Opt{DIR}                      = $Const{DIR} ;

$Opt{LAST_FILE}                = 1 ;
$Opt{LAST_FILE_1}              = '(none)' ;
$Opt{LAST_FILE_2}              = '(none)' ;
$Opt{LAST_FILE_3}              = '(none)' ;
$Opt{LAST_FILE_4}              = '(none)' ;
$Opt{LAST_FILE_5}              = '(none)' ;
$Opt{LAST_FILE_6}              = '(none)' ;
$Opt{LAST_FILE_7}              = '(none)' ;
$Opt{LAST_FILE_8}              = '(none)' ;
$Opt{LAST_FILE_9}              = '(none)' ;


sub opts_check {

    $Opt{DIR} = '.' unless -d $Opt{DIR} ;

    for( my $i = 1 ; $i <= $Const{LAST_FILE_MAX} ; $i++ ) {
        $Opt{LAST_FILE} = $i, last unless $Opt{"LAST_FILE_$i"} ;
    }

	
	$Opt{CANVAS_WIDTH}  = $Const{CANVAS_WIDTH_DEF} 
	if $Opt{CANVAS_WIDTH}  !~ /^\d+$/o or $Opt{CANVAS_WIDTH}  == 0 ; 
	$Opt{CANVAS_HEIGHT} = $Const{CANVAS_HEIGHT_DEF} 
	if $Opt{CANVAS_HEIGHT} !~ /^\d+$/o or $Opt{CANVAS_HEIGHT} == 0 ; 
	$Opt{CANVAS_SCALE}  = $Const{CANVAS_SCALE_DEF} 
	if $Opt{CANVAS_SCALE}  !~ /^\d+$/o or $Opt{CANVAS_SCALE}  == 0 ; 

	$Opt{WIDTH}  = int( $Opt{CANVAS_WIDTH}  / $Opt{CANVAS_SCALE} ) ;
	$Opt{HEIGHT} = int( $Opt{CANVAS_HEIGHT} / $Opt{CANVAS_SCALE} ) ;
}


1 ;
