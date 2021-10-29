
xspin = function(input, output=fs::path_ext_set(input, ".Rmd"), engine=NULL, engine_path=NULL)
{
    ext = fs::path_ext(input)

    engines = list("R"="R", "py"="python", "jl"="julia", "sh"="bash")
    if (is.null(engine)) {
        engine = engines[ext]
    }

    if (!file.exists(input))
        stop("ERROR: cannot find input script: ", input)

    lines = readLines(input)

    outlines = NULL
    in_code = FALSE
    for (line in lines) {
        if (grepl("^#-", line)) {
            if (in_code) {
                outlines = c(outlines, "```")
            }
            outlines = c(outlines, sub("^#- ?", "", line))
            in_code = F
        } else if (grepl("^#+ ?", line)) {
            if (in_code) {
                outlines = c(outlines, "```", "")
            }
            outlines = c(outlines, sprintf("```{%s}", sub("^#+ ?", "", line)))
            in_code = T
        } else if (grepl("^\\s+$", line, perl=T)) {
            outlines = c(outlines, line)
        } else {
            outlines = c(outlines, line)
            in_code = T
        }
    }

    writeLines(output, outlines)
    return(invisible(NULL))
}
