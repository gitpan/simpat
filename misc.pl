#!/usr/bin/perl -w

# $Id: misc.pl,v 1.1 1999/03/24 21:11:48 root Exp root $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


sub abs_path {
    my $path = shift ;

    my $filename = basename( $path ) ;

    $path        = dirname( $path ) ;
    chdir $path ;
    $path = cwd ;

    $path =~ s!/./!/!go ;

    if( $filename ) {
        $path .= '/' unless substr( $path, -1, 1 ) eq '/' ;
        $path .= $filename ;
    }

    $path ;
}


1 ;
