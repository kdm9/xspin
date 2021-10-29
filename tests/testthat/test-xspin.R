
test_that("xspin produces correct output", {
    do_test = function(input) {
        res = xspin(input, output=paste0(input, ".got"))
        expect = readLines(paste0(input, ".expect"))
        got = readLines(paste0(input, ".got"))

        expect_equal(expect, got)
        expect_equal(paste(expect, collapse="\n"), res)
    }
    
    do_test("data/simple.sh")
    do_test("data/simple.py")

})

test_that("xrender works", {
    do_test("data/simple.sh")
    do_test("data/simple.py")

    if (file.exists("data/simple.html")) unlink("data/simple.html")
    xrender("data/simple.sh")
    expect_true(file.exists("data/simple.html"))

})
