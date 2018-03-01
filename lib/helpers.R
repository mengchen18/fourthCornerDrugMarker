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