#cmpfile("./individual summary.R")
cat("summarise individual trajectories ...\n")
if (i == init.year - 2011) {
  no43 <- POP[between(age, ageL, ageH), sample(id, 1)]
  indiv.traj <- vector("list", yearstoproject)
}

indiv.traj[[i + 2011 - init.year + 1]] <- POP[id == no43, 
                                              ][, year := i + init.year]

if (i == yearstoproject + init.year - 2012) {
  saveRDS(rbindlist(indiv.traj, T, T), 
          file = paste0(output.dir(), "indiv.traj.rds"))
}

cat("summarise individual output (HLE)...\n")
# hle
if (!is.null(diseasestoexclude)) {
  indiv.incid.summ <- rbindlist(indiv.incid, T, T)
  
  output <- vector("list", 3)
  
  if (exists("ind.incid.rds")) output[[1]] <- ind.incid.rds
  
  output[[2]] <- indiv.incid.summ[,
                                  .(
                                    mean = mean(age, na.rm = T),
                                    sd = sd(age, na.rm = T),
                                    n = .N
                                  ),
                                  by=.(
                                    sex,
                                    year,
                                    scenario,
                                    mc
                                  )
                                  ][
                                    ,
                                    group := "S"
                                    ]
  output[[3]] <- indiv.incid.summ[  ,
                      .(
                        mean = mean(age, na.rm = T),
                        sd = sd(age, na.rm = T),
                        n = .N
                      ), 
                      by=.(
                        sex,
                        qimd,
                        year,
                        scenario,
                        mc
                      )
                      ][,
                        group := "SQ"
                        ]
  
  ind.incid.rds <- rbindlist(output, T, T)
  
  if (i == yearstoproject + init.year - 2012) {
    ind.incid.rds[, sex := factor(sex, c("1", "2"), c("Men" ,"Women"))]
    saveRDS(ind.incid.rds, file = paste0(output.dir(), "ind.incid.rds"))
  }
}

# LE
cat("summarise individual output (LE)...\n")
indiv.mort.summ <- rbindlist(indiv.mort, T, T)

output <- vector("list", 3)

if (exists("ind.mortal.rds0")) output[[1]] <- ind.mortal.rds0
output[[2]] <- indiv.mort.summ[,
                               .(
                                 mean = mean(age, na.rm = T),
                                 sd = sd(age, na.rm = T),
                                 n = .N
                               ),
                               by=.(
                                 sex,
                                 year,
                                 scenario,
                                 mc
                               )
                               ][
                                 ,
                                  group := "S"
                                  ]

output[[3]] <- indiv.mort.summ[  ,
                               .(
                                 mean = mean(age, na.rm = T),
                                 sd = sd(age, na.rm = T),
                                 n = .N
                               ), 
                               by=.(
                                 sex,
                                 qimd,
                                 year,
                                 scenario,
                                 mc
                               )
                               ][,
                                 group := "SQ"
                                 ]

ind.mortal.rds0 <- rbindlist(output, T, T)

if (i == yearstoproject + init.year - 2012) {
  ind.mortal.rds0[, sex := factor(sex, c("1", "2"), c("Men" ,"Women"))]
  saveRDS(ind.mortal.rds0, file = paste0(output.dir(), "ind.mortal.rds0"))
}


output <- vector("list", 3)

if (exists("ind.mortal.rds65")) output[[1]] <- ind.mortal.rds65
output[[2]] <- indiv.mort.summ[age > 65,
                               .(
                                 mean = mean(age, na.rm = T),
                                 sd = sd(age, na.rm = T),
                                 n = .N
                               ),
                               by=.(
                                 sex,
                                 year,
                                 scenario,
                                 mc
                               )
                               ][
                                 ,
                                  group := "S"
                                  ]

output[[3]] <- indiv.mort.summ[age > 65 ,
                               .(
                                 mean = mean(age, na.rm = T),
                                 sd = sd(age, na.rm = T),
                                 n = .N
                               ), 
                               by=.(
                                 sex,
                                 qimd,
                                 year,
                                 scenario,
                                 mc
                               )
                               ][,
                                 group := "SQ"
                                 ]

ind.mortal.rds65 <- rbindlist(output, T, T)

if (i == yearstoproject + init.year - 2012) {
  ind.mortal.rds65[, sex := factor(sex, c("1", "2"), c("Men" ,"Women"))]
  saveRDS(ind.mortal.rds65, file = paste0(output.dir(), "ind.mortal.rds65"))
}


