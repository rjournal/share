## news2ltx.pl
## Usage:
##   perl news2ltx.pl NEWS

my $secBeg = "\\end\{itemize\}\n\n\\section*\{ ";
my $secEnd = "\}\n\\begin\{itemize\}";


while(<>){
    s/\s*CHANGES IN R VERSION (\d.\d.\d)/\\title\{Changes in R\}\\author\{by the R Core Team\}\\maketitle/;

    s/\s*USER-VISIBLE CHANGES/${secBeg}User-visible changes${secEnd}/;
    s/\s*NEW FEATURES/${secBeg}New features${secEnd}/;
    s/\s*DEPRECATED & DEFUNCT/${secBeg}Deprecated \& defunct${secEnd}/;
    s/\s*DOCUMENTATION CHANGES/${secBeg}Documentation changes${secEnd}/;
    s/\s*INSTALLATION CHANGES/${secBeg}Installation changes${secEnd}/;
    s/\s*UTILITIES/${secBeg}Utilities${secEnd}/;
    s/\s*C-LEVEL FACILITIES/${secBeg}C-level facilities${secEnd}/;
    s/\s*BUG FIXES/${secBeg}Bug fixes${secEnd}/;
    
    s/^\s+o\s+/\\item /;
    s/(\S+\([^\)]*\))/\\code{$1}/g;
    s/PR\#/PR\\\#/g;
    s/_/\\_/g;
    s/&/\\&/g;

    print;
}
