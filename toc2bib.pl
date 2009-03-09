#!/usr/bin/perl

$file = $ARGV[0];
if($file =~ /.*Rnews_(\d*)-(\d)/){
    $year = $1;
    $volume = $2;
}
else{
    print "Usage: toc2bib.pl Rnews_year-volume\n\n\n";
    exit 1;
}


open in, "< $file.tex" || die "Cannot open $file.tex\n";
while(<in>){
    if(/\\date\{(.*) $year\}/){
	$month = $1;
    }
    if(/\\volnumber\{(.*)\}/){
	$volnumber = $1;
    }
}
close in;

open in, "< $file.toc" || die "Cannot open $file.toc\n";
while(<in>){
    if(/\{chapter\}\{([^\}]*)\}\{(\d*)\}/){
	$title = $1;
	$page = $2;
	print "\@Article\{,\n" .
	    "  author       = \{\},\n" .
	    "  title        = \{$title\},\n" .
	    "  journal      = \{R News\},\n" .
	    "  year         = $year,\n" .
	    "  volume       = $volume,\n" .
	    "  number       = $volnumber,\n" .
	    "  pages        = \{$page--\},\n" .
	    "  month        = \{$month\},\n" .
	    "  url          = \{http://CRAN.R-project.org/doc/Rnews/\}\n" .
	    "\}\n\n"
    }
}
	

