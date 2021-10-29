do_test = function(input) {
    xspin(input, output=paste0(input, ".got"))
    expect = readLines(paste0(input, ".expect"))
    got = readLines(paste0(input, ".got"))

    expect_equal(expect, got)
}

test_that("xspin compiles", {
    
    do_test("data/simple.sh")

})
