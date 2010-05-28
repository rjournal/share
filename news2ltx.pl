## news2ltx.pl
## Usage:
##   perl news2ltx.pl NEWS

my $secBeg = "\\end\{itemize\}\n\n\\subsection*\{ ";
my $secEnd = "\}\n\\begin\{itemize\}";

print "\\title\{Changes in R\}\\author\{by the R Core Team\}\\maketitle";

while(<>){
# Forget lines that begin and end with an asterisk
    /^\s*\*.*\*\s*$/ && next;
    s/\s*CHANGES IN R VERSION (\d+.\d+.\d+ *\S*)/\\section*\{R $1 changes\}\n\\begin\{itemize\}/;

    s/\s*USER-VISIBLE CHANGES/${secBeg}User-visible changes${secEnd}/;
    s/\s*NEW FEATURES/${secBeg}New features${secEnd}/;
    s/\s*DEPRECATED & DEFUNCT/${secBeg}Deprecated \& defunct${secEnd}/;
    s/\s*DOCUMENTATION CHANGES/${secBeg}Documentation changes${secEnd}/;
    s/\s*INSTALLATION CHANGES/${secBeg}Installation changes${secEnd}/;
    s/\s*INSTALLATION/${secBeg}Installation changes${secEnd}/;
    s/\s*INTERNATIONALIZATION/${secBeg}Internationalization${secEnd}/;
    s/\s*UTILITIES/${secBeg}Utilities${secEnd}/;
    s/\s*C-LEVEL FACILITIES/${secBeg}C-level facilities${secEnd}/;
    s/\s*BUG FIXES/${secBeg}Bug fixes${secEnd}/;
    
    s/^\s+o\s+/\\item /;
    s/(\S+\([^\)]*\))/\\code{$1}/g;
# Try to avoid touching quoted strings in function calls
# using negative lookahead for a closing brace
# (not quite perfect)
# Strings with spaces require manual intervention
    s/'(\S+)'(?!.*})/\\code{$1}/g;
    s/"(\S+)"(?!.*})/\\code{"$1"}/g;
    s/PR\#/PR\\\#/g;
    s/_/\\_/g;
    s/&/\\&/g;

    print;
}
