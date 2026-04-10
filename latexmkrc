$ENV{'TZ'}='America/New_York';
$xelatex = 'xelatex -output-driver="xdvipdfmx -z 0" %O %S';

# Force BibTeX for this project to avoid inheriting a global biber override.
$bibtex = 'bibtex %O %B';
