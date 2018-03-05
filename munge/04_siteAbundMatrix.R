obj <- ls()

# read cell line mapping
cellmap <- read.delim("data/idmap_cellline.txt", stringsAsFactors = FALSE)

# load data and process
psite <- readRDS("cache/psites.nci60.trypsin.RDS")
siteAbundMat <- psite$fun_prepElnet(psite, celllines = cellmap$nameProt, panel = "NCI60")

siteAbundMat$annot <- psite$annot[rownames(siteAbundMat$imputed), ]
siteAbundMat$xref <- psite$nci60_xref[match(cellmap$nameProt, psite$nci60_xref$name_MQ), ]
colnames(siteAbundMat$imputed) <- cellmap$nameNCI
colnames(siteAbundMat$na_index) <- cellmap$nameNCI


rm(list = setdiff(ls(), c(obj, "siteAbundMat")))
gc()
