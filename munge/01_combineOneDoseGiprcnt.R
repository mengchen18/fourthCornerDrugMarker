# this file turn separate .csv files to a combined 

dataDir <- "data/oneDose_nci60/csv"
files <- dir(dataDir)

l <- lapply(files, function(x) read.csv(file.path(dataDir, x), stringsAsFactors = FALSE))
cellnames <- make.names(unique(unlist(lapply(l, "[[", "CELLNAME"))))

oneDoseGiprcnt <- matrix(NA, length(cellnames), length(files), 
              dimnames = list(cellnames, 
                              make.names(gsub(".csv", "", files))))

for (i in seq_along(l)) {
  f <- l[[i]]
  f <- structure(f$GIPRCNT, names = make.names(f$CELLNAME))
  oneDoseGiprcnt[, i] <- f[cellnames]
}

rm(list = setdiff(ls(), "oneDoseGiprcnt"))
gc()




