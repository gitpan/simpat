#!/usr/bin/perl -w

# $Id: simpat-canvas-cmd.pl,v 1.5 1999/04/08 20:00:32 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;


package canvas ;


sub create { &_draw( 1 ) }
sub redraw { &_draw( 0 ) }

sub _draw {
    package main ;

    my $new = shift ;

    &cursor( 'watch' ) ;

    if( $new ) {
		$Canvas{CANVAS}->delete( 'all' ) ;

		$Canvas{CANVAS}->configure(
			-width  => $Opt{CANVAS_WIDTH},
			-height => $Opt{CANVAS_HEIGHT},
			) ;
 	}

    &canvas::status( 'Redrawing...' ) ;
	for( my $x = 0 ; $x < $Opt{WIDTH} ; $x++ ) {
		my $x0 = $x  * $Opt{CANVAS_SCALE} ;
        my $x1 = $x0 + $Opt{CANVAS_SCALE} ; 
		for( my $y = 0 ; $y < $Opt{HEIGHT} ; $y++ ) {
            my $colour = $NewPixel[$x][$y] ;
			my $y0 = $y * $Opt{CANVAS_SCALE} ;
            $Pixel[$x][$y] = $Canvas{CANVAS}->create(
								'rectangle', 
								$x0, 
								$y0, 
								$x1, 
								$y0 + $Opt{CANVAS_SCALE},
								-fill    => $colour,
								-outline => $colour,
								) ;
			$OldPixel[$x][$y] = $colour ;
        }
    }

    &cursor() ;
    &canvas::status( '' ) ;
}


sub update {
    package main ;

    &canvas::status( 'Updating...' ) ;
    &cursor( 'watch' ) ;
    
	for( my $x = 0 ; $x < $Opt{WIDTH} ; $x++ ) {
		for( my $y = 0 ; $y < $Opt{HEIGHT} ; $y++ ) {
		    my $colour = $NewPixel[$x][$y] ;
		    next if $colour eq 
		            $Canvas{CANVAS}->itemcget( $Pixel[$x][$y], -fill ) ;
			$Canvas{CANVAS}->itemconfigure( $Pixel[$x][$y], 
				-fill    => $colour,
				-outline => $colour,
				) ;
			$OldPixel[$x][$y] = $colour ;
		}
	}

    &cursor() ;
    &canvas::status( '' ) ;
}


sub scale {
    package main ;

    my $oldx = $Opt{WIDTH} ;
    my $oldy = $Opt{HEIGHT} ;

	$Opt{WIDTH}  = int( $Opt{CANVAS_WIDTH}  / $Opt{CANVAS_SCALE} ) ;
	$Opt{HEIGHT} = int( $Opt{CANVAS_HEIGHT} / $Opt{CANVAS_SCALE} ) ;

	for( my $x = $oldx ; $x < $Opt{WIDTH} ; $x++ ) {
		for( my $y = $oldy ; $y < $Opt{HEIGHT} ; $y++ ) {
			$OldPixel[$x][$y] = $Const{DEAD_COLOUR} ;
			$NewPixel[$x][$y] = $Const{DEAD_COLOUR} ; 
		}
	}

    &canvas::create ;
}


sub read_pixel {
    package main ;

    my( $x, $y ) = @_ ;

    ( 0 <= $x and $x < $Opt{WIDTH} and
      0 <= $y and $y < $Opt{HEIGHT} and 
  	  defined $OldPixel[$x][$y] ) ? 
	$OldPixel[$x][$y] : $Const{DEAD_COLOUR} ;
}


sub write_pixel {
    package main ;

    my( $x, $y, $colour ) = @_ ;

    $NewPixel[$x][$y] = $colour ;
}


sub click1 {
    package main ;

    my $win   = shift ;
    my $event = $win->XEvent ;
    my $cx    = $Canvas{CANVAS}->canvasx( $event->x ) ;
    my $cy    = $Canvas{CANVAS}->canvasy( $event->y ) ;
    my $x     = int( $cx / $Opt{CANVAS_SCALE} ) ;
    my $y     = int( $cy / $Opt{CANVAS_SCALE} ) ;

    $OldPixel[$x][$y] = $Opt{USER_COLOUR} ;
    $NewPixel[$x][$y] = $Opt{USER_COLOUR} ;
    $Canvas{CANVAS}->itemconfigure( $Pixel[$x][$y], 
        -fill    => $Opt{USER_COLOUR},
        -outline => $Opt{USER_COLOUR},
        ) ;
}


sub click3 {
    package main ;

    my $win   = shift ;
    my $event = $win->XEvent ;
    my $cx    = $Canvas{CANVAS}->canvasx( $event->x ) ;
    my $cy    = $Canvas{CANVAS}->canvasy( $event->y ) ;
    my $x     = int( $cx / $Opt{CANVAS_SCALE} ) ;
    my $y     = int( $cy / $Opt{CANVAS_SCALE} ) ;

    $OldPixel[$x][$y] = $Opt{DEAD_COLOUR} ;
    $NewPixel[$x][$y] = $Opt{DEAD_COLOUR} ;
    $Canvas{CANVAS}->itemconfigure( $Pixel[$x][$y], 
        -fill    => $Opt{DEAD_COLOUR},
        -outline => $Opt{DEAD_COLOUR},
        ) ;
}


sub generation {
    package main ;

    my $change = shift ;

    if( $change == 0 ) {
        $Global{GENERATION} = 0 ;
	}
	else {
		$Global{GENERATION} += $change ;
        $Global{GENERATION} = 0 if $Global{GENERATION} < 0 ;
	}

    $Canvas{GENERATION}->configure( -text => $Global{GENERATION} ) ;
    $Canvas{GENERATION}->update ;
}


sub status {
    package main ;

    my $text = shift ;

    $Canvas{STATUS}->configure( -text => $text ) ;
    $Canvas{STATUS}->update ;
}


1 ;
