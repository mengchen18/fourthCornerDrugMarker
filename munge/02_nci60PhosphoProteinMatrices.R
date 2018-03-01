
'
sl1 <- readRDS("/media/general/projects/NCI_60_phospho/Chen/Res/20170110_mq15processLOD2/nci60.proteinGroups.RDS")
sl2 <- readRDS("/media/general/projects/NCI_60_phospho/Chen/Res/20170110_mq15processLOD2/sites.trypsin.RDS")
sl3 <- readRDS("/media/general/projects/NCI_60_phospho/Chen/Res/20170719_nci60.proteinGroups.gluc/nci60.proteinGroups.gluc.RDS")
sl4 <- readRDS("/media/general/projects/NCI_60_phospho/Chen/Res/20170110_mq15processLOD2/sites.gluC.RDS")


names(sl1)

names(sl2)
sl2$crc65_idtype <- NULL
sl2$crc65_expr <- NULL
sl2$crc65_xref <- NULL
sl2$hela_expr <- NULL
sl2$hela_idtppe <- NULL

names(sl3)
names(sl4)

sl4$hela_expr <- NULL
sl4$hela_idtppe <- NULL


saveRDS(sl1, file = "cache/proteinGroup.nci60.trypsin.RDS")
saveRDS(sl2, file = "cache/psites.nci60.trypsin.RDS")

saveRDS(sl3, file = "cache/proteinGroup.nci60.gluc.RDS")
saveRDS(sl4, file = "cache/psites.nci60.gluc.RDS")

'
