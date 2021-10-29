do_test = function(input) {
    res = xspin(input, output=paste0(input, ".got"))
    expect = readLines(paste0(input, ".expect"))
    got = readLines(paste0(input, ".got"))

    expect_equal(expect, got)
    expect_equal(paste(expect, collapse="\n"), res)
}

test_that("xspin compiles", {
    
    do_test("data/simple.sh")
    do_test("data/simple.py")

})
