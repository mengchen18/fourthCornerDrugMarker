library(openxlsx)
library(reshape2)
library(matrixStats)

source("lib/helpers.R")

obj <- ls()

tab <- read.xlsx("data/kinobeadScreen/Supplementary Table 2 Target Lists.xlsx", sheet = 3)
tab$Drug <- make.names(tab$Drug)

# fix names 
setdiff(tab$Drug, colnames(oneDoseGiprcnt))
grep("OTS", colnames(oneDoseGiprcnt), value = TRUE)
grep("ONO", colnames(oneDoseGiprcnt), value = TRUE)
tab$Drug[tab$Drug == "ONO.4059.analogue"] <- "ONO.4059_analogue"
tab$Drug[tab$Drug == "OTS.167"] <- "OTSSP167"

# filtering, remove low confidence
tab <- tab[tab$Target.Classification == "High confidence", ]

# filtering, remove drugs not measured in one doese experiment
tab <- tab[tab$Drug %in% colnames(oneDoseGiprcnt), ]

# target inhibition
tab$ti10mM <- targetInhibition(10000, b = tab$Slope, c = tab$Bottom, d = tab$Top, e = tab$Apparent.Kd)

# bounded to 0 and 1
tab$ti10mM[tab$ti10mM > 1] <- 1
tab$ti10mM[tab$ti10mM < 0] <- 0

# to matrix
imat <- acast(data = tab, formula = Gene.Name ~ Drug, value.var = "ti10mM")

# missing value to 1, no inhibition
imat[is.na(imat)] <- 1

# filter proteins not inhibited
imat <- imat[rowMins(imat) < 0.8, ]


targetInhibitMat <- imat

# clear space
rm(list = setdiff(ls(), c(obj, "targetInhibitMat")))
gc()

