#!/usr/bin/perl -w

# $Id: simpat-keys.pl,v 1.1 1999/03/28 11:33:48 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


# Key bindings for the main window. 
$Win->bind( '<F1>',        \&help::form ) ;
$Win->bind( '<Control-n>', \&file::new ) ;
$Win->bind( '<Control-o>', \&file::open ) ;
$Win->bind( '<Control-q>', \&file::quit ) ;
$Win->bind( '<Control-s>', \&file::save ) ;
 

1 ;
