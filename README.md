
# xspin

<!-- badges: start -->
[![R-CMD-check](https://github.com/kdm9/xspin/workflows/R-CMD-check/badge.svg)](https://github.com/kdm9/xspin/actions)
<!-- badges: end -->

A version of knitr::spin() which functions on languages other than R. Now one
can spin() a python/shell/R script to a .Rmd, and compile outputs from there.


## Installation

You can install the development version of xspin like so:

```r
remotes::install("kdm9/xspin")
```

## Example

```r
# "spin" script to notebook
xspin::xspin(input="script.sh", output="script.Rmd")

# a one-stop-shop: xspin() followed by rmarkdown::render().
xspin::xweave(input="script.sh")
```

See [the test py/sh files](tests/testthat/data/) for example inputs and expected Rmd outputs.
