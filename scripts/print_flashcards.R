#!/usr/bin/env Rscript --vanilla


library(pdftools)

args=commandArgs(trailingOnly=TRUE)



fn <- args[1]
ncol <- 3
nrow <- 5

n_per_side <- ncol * nrow
n_per_page <- n_per_side * 2

n_pdf_pages <- pdf_info(fn)$pages

n_print_page <- ceiling(n_pdf_pages / n_per_page)
n_print_side <- n_print_page * 2
n_print_facets <- n_per_page * n_print_page


odd_pages <- seq(1, n_print_facets, 2)
even_pages <- seq(2, n_print_facets, 2)


odd_pages <- array(odd_pages, dim = c(ncol, nrow, n_print_page))
even_pages <- array(even_pages, dim = c(ncol, nrow, n_print_page))

even_pages <- even_pages[ncol:1,,]


all_pages <- array(0, c(ncol, nrow, n_print_side))
all_pages[,,seq(1, n_print_side, 2)] <- odd_pages
all_pages[,,seq(2, n_print_side, 2)] <- even_pages

all_pages[all_pages > n_pdf_pages] <- "{}"

selection <- paste(all_pages, collapse = ",")

fn_out <- file.path(dirname(fn), paste0("PRINT-", basename(fn)))
cmd <- paste("pdfjam", fn, selection, "--nup 3x5", "--frame true", "--no-tidy",
             "--outfile", fn_out)
system(cmd)
