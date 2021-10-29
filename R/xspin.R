is_whitespace = function(s) grepl("^\\s*$", s, perl=T)

handle_close = function(line, output) {
    ol = length(output)
    lastline = output[ol]
    if (is_whitespace(lastline)) {
        return (c(output[1:ol-1], "```", lastline))
    }
    return(c(output, "```"))
}

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
    for (i in seq_along(lines)) {
        line = lines[i]
        if (i == 1 && grepl("^#!", line)) {
            next
        } else if (grepl("^#' ?", line)) {
            if (in_code) {
                outlines = handle_close(line, outlines)
            }
            outlines = c(outlines, sub("^#' ?", "", line, perl=T))
            in_code = F
        } else if (grepl("^#\\+ ?", line)) {
            if (in_code) {
                outlines = c(handle_close(line, outlines), "")
            }
            outlines = c(outlines, sprintf("```{%s}", sub("^#\\+ ?", "", line)))
            in_code = T
        } else if (is_whitespace(line)) {
            outlines = c(outlines, line)
        } else {
            if (!in_code) {
                outlines = c(outlines, sprintf("```{%s}", engine))
            }
            outlines = c(outlines, line)
            in_code = T
        }
    }
    if (in_code) 
        outlines = c(outlines, "```")

    writeLines(outlines, output)
    return(invisible(paste(outlines, collapse="\n")))
}
