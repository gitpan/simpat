#!/usr/bin/perl -w

# $Id: simpat-menu-ui.pl,v 1.5 1999/04/08 20:00:32 root Exp $

# (c) Mark Summerfield 1999. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


my $MenuBar = $Win->Frame(
                -relief      => 'raised',
                -borderwidth => 2,
                )->pack( -anchor => 'nw', -fill => 'x' ) ;


$MenuFile = $MenuBar->Menubutton(
                -text      => 'File',
                -underline => 0,
                -tearoff   => 0,
                -menuitems => [ 
                    [ 
                        Button       => '~New',  
                        -accelerator => 'Ctrl+N',
                        -command     => \&file::new,
                        -state       => 'disabled',
                    ],
                    [ 
                        Button       => '~Open...', 
                        -accelerator => 'Ctrl+O',
                        -command     => \&file::open,
                        -state       => 'disabled',
                    ], 
                    [
                        Button       => '~Save',
                        -accelerator => 'Ctrl+S',
                        -command     => \&file::save,
                        -state       => 'disabled',
                    ],
                    [
                        Button       => 'Save ~As...',
                        -command     => \&file::save_as,
                        -state       => 'disabled',
                    ],
                    [
                        Button       => 'Save stil~l image...',
                        -command     => \&file::save_still_image,
                        -state       => 'disabled',
                    ],
                    [
                        Separator    => '',
                    ],
                    [
                        Button       => 'Opt~ions...',
                        -command     => \&options::form, 
                    ],
                    [
                        Separator    => '',
                    ],
                    [
                        Button       => '~Quit',
                        -accelerator => 'Ctrl+Q',
                        -command     => \&file::quit,
                    ],
                    [
                        Separator    => '',
                    ],
                ]
                )->pack( -side => 'left' ) ;

for( my $i = 1 ; $i <= $Const{LAST_FILE_MAX} ; $i++ ) {
    $MenuFile->command(
        -label   => "~$i " . $Opt{"LAST_FILE_$i"},
        -command => [ \&file::open, $i ],
		-state   => 'disabled',
        ) ;
}


my $MenuSimulation = $MenuBar->Menubutton(
                -text      => 'Simulation',
                -underline => 0,
                -tearoff   => 0,
                -menuitems => [ 
                    [ 
                        Button       => '~Rules...',  
                        -command     => \&simulation::rules,
                    ],
                    [ 
                        Button       => '~Properties...',  
                        -command     => \&simulation::form,
                    ],
                    [
                        Separator    => '',
                    ],
                    [ 
                        Button       => '~Initialise...',  
                        -command     => \&simulation::initialise,
                    ],                    
                    [ 
                        Button       => '~Start...',  
                        -command     => \&simulation::start,
                    ],                    
                    [ 
                        Button       => 'Step ~Back',  
                        -command     => \&simulation::stepback,
                    ],                    
                    [ 
                        Button       => 'Step ~Forward',  
                        -command     => \&simulation::step,
                    ],                    
                    [ 
                        Button       => 'Step ~to...',  
                        -command     => \&simulation::stepto,
                    ],                    
                    [ 
                        Button       => 'P~ause',  
                        -command     => \&simulation::pause,
                    ],                    
                    [ 
                        Button       => 'St~op',  
                        -command     => \&simulation::stop,
                    ],                    
                    [
                        Separator    => '',
                    ],
                    [ 
                        Button       => '~Clear',  
                        -command     => \&simulation::clear,
                    ],                    
                 ]
                 )->pack( -side => 'left' ) ;


my $MenuScale = $MenuBar->Menubutton(
                -text      => 'Scale',
                -underline => 1,
                -tearoff   => 0,
                -menuitems => [ 
                    [ 
                        Radiobutton  => '  ~1 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 1,
                        -command     => \&canvas::scale
                    ],
                    [ 
                        Radiobutton  => '  ~2 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 2,
                        -command     => \&canvas::scale
                    ],
                    [ 
                        Radiobutton  => '  ~3 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 3,
                        -command     => \&canvas::scale
                    ],
                    [ 
                        Radiobutton  => '  ~4 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 4,
                        -command     => \&canvas::scale
                    ],
                    [ 
                        Radiobutton  => '  ~5 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 5,
                        -command     => \&canvas::scale
                    ],
                    [ 
                        Radiobutton  => '  ~6 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 6,
                        -command     => \&canvas::scale
                    ],
                    [ 
                        Radiobutton  => '  ~8 pixel',  
                        -variable    => \$Opt{CANVAS_SCALE}, 
                        -value       => 8,
                        -command     => \&canvas::scale
                    ],
                ]
                )->pack( -side => 'left' ) ;

my $MenuHelp = $MenuBar->Menubutton(
                -text      => 'Help',
                -underline => 0,
                -tearoff   => 0,
                -menuitems => [ 
                    [ 
                        Button       => '~Help',  
                        -accelerator => 'F1',
                        -command     => \&help::form,
                    ],
                    [
                        Button       => '~About',
                        -command     => \&help::about,
                    ],
                ]
                )->pack( -side => 'right' ) ;


1 ;
