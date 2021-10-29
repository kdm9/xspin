#' rmarkdown::render() for any spinscript
#'
#' @description rmarkdown::render() is a user-friendly entry point to render an
#' Rmardkown document. This function is an equivalent for a spin() script in
#' any language Rmardkown supports.
#'
#' @param input     Input script name
#' @param output    Path to compiled output.
#' @param engine    Passed to xspin()
#' @param keep_rmd  Should we keep the .Rmd file?
#' @param ...       Extra args passed to rmarkdown::render
#'
#' @export xrender
xrender = function(input, output=NULL, engine=NULL, keep_rmd=F, ...) 
{
    if (is.null(output)) {
        output = fs::path_ext_set(input, ".html")
    }
    tmprmd = paste0(input, ".tmp.Rmd")
    xspin(input, tmprmd, engine=engine)

    rmarkdown::render(input=tmprmd, output_file=output, ...)

    if (!keep_rmd) {
        unlink(tmprmd, force=F, recursive=F, expand=F)
    }


    



}

