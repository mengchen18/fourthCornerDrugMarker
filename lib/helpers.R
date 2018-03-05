#' @description using four parameters - top, bottom, slope and kd - to 
#'   determine the precentage of inhibition of a protein
#' @param x the concentration in nM
#' @param b slope
#' @param c bottom
#' @param d top
#' @param e kd or apparent kd
#' @example 
#' tab$ip500 <- inhibition(10000, b = tab$Slope, c = tab$Bottom, d = tab$Top, e = tab$Apparent.Kd)
#' 
targetInhibition <- function(x, b, c, d, e) {
  c + (d-c)/(1+exp(b*(log(x) - log(e))))
}

#' Use to evaluate whether a string far from a distribution
#' @param x the reference distribution, a numerical vector 
#' @param f a \code{data.frame} every column consist of two unique values
#' @description This function is used to evaluate if drugs with specific targets
#'   are located on the positive/negative end of a distribution (defined by x)

quantref <- function(x, f) {
  
  stat <- sapply(f, function(f1) {
    ff1 <<- f1
    if (length(unique(f1)) != 2)
      stop("columns of f should have two unique values")
    l <- split(x, f1)
    ll <<- l
    ks <- ks.test(l[[1]], l[[2]])
    c(ks$p.value, ks$statistic)
  })
  data.frame(pvalue = stat[1, ], 
             fdr = p.adjust(stat[1, ]), 
             D = stat[2, ])
}
