#!/usr/bin/perl -w

# $Id: simpat-help-cmd.pl,v 1.1 1999/03/28 11:33:48 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package help ;


sub about {
    package main ;

    &cursor( 'clock' ) ;
    &canvas::status( 'Showing about box...' ) ;

    my $text = <<__EOT__ ;
Simpat v $VERSION

Copyright (c) Mark Summerfield 1999. 
All Rights Reserved.

May be used/distributed under the same terms as Perl.
__EOT__


    my $msg = $Win->MesgBox(
        -title => 'Simpat - About',
        -text  => $text,
        ) ;
    $msg->Show ;
    
    &cursor() ;
    &canvas::status( '' ) ;
}


1 ;
