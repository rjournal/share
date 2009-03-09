## pkg2ltx.pl
## Usage:
##   R CMD perl pkg2ltx.pl <list_of_R_packages>

use R::Dcf;

my $TMPD = "/tmp/pkg2lat.$$";
mkdir $TMPD, 0755;

print "\\begin\{description}\n";
foreach my $file (sort(@ARGV)) {
    if($file !~ /.tar.gz$/) {
	$file = `ls ${file}_*.tar.gz`
	    or die("ERROR: No such file\n");
    }
    ## get only the non-whitespace characters in the last line
    $file =~ s/(\S*)\s*$/$1/s;
    if(-r $file) {
	system("tar zxOf '$file' --wildcards '*/DESCRIPTION' > " .
	       "$TMPD/DESCRIPTION");
	my $rdcf = R::Dcf->new("$TMPD/DESCRIPTION");
	print_description($rdcf);
    }
}
print "\\end\{description}\n";

unlink $TMPD;

sub print_description {
    my ($rdcf) = @_;
    my $author = $rdcf->{"Author"};
    $author =~ s/\s*<[^>]*>//g;
    my $pkg = $rdcf->{"Bundle"};
    print $pkg, "\n";
    my $description;
    if($pkg) {
	$description = $rdcf->{"BundleDescription"};
    }
    else {
	$pkg = $rdcf->{"Package"};
	$description = $rdcf->{"Description"};
    }
    my $title = $rdcf->{"Title"};
    print "\\item[\\pkg\{", $pkg, "\}]";
    print "\n$title";
    print "." unless($title =~ /\.$/);
    if($description) {
	print "\n$description";
	print "." unless($description =~ /\.$/);
    } else {
	print stderr "WARNING: no description in $pkg\n";
    }
    print "\nBy ", $author, ".\n\n";
}
