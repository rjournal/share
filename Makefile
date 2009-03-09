CRAN = fangorn.ci.tuwien.ac.at:/data/WWW/http/cran.r-project.org

all: Rnews.sty

Rnews.sty: Rnews.dtx
	@tex Rnews.ins

clean:
	@./texclean Rnews.dtx

install-web: Rnews.sty
	@scp Rnews.dtx Rnews.sty $(CRAN)/doc/Rnews
	@scp Rnews.bib $(CRAN)/doc/Rnews/bib
