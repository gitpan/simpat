#!/usr/bin/perl -w

# $Id: simpat-globals.pl,v 1.2 1999/04/07 20:53:42 root Exp $

# Copyright (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


$Global{WROTE_OPTS}     = 0 ;
$Global{WROTE_SIM}      = 1 ;
$Global{FILENAME_INDEX} = 1 ;
$Global{FILENAME}       = '' ;
$Global{GENERATION}     = 0 ;
$Global{RUNNING}        = 0 ;


1 ;
