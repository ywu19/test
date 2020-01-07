setwd("/media/yunkun/Data1/ribo-seq/XW_He")

samples = c("446", "rps801D", "rps802D")


df = read.table("446_RPF+mRNA_cov_statA.txt", header = T, sep = "\t")

df$TE = df$RPF_total/sum(df$RPF_total)/(df$mRNA_count/sum(df$mRNA_count)*1000/df$length)

df1 = df[df$RPF_coverage > 0.3 & df$mRNA_coverage > 0.5,]

df1 = df1[,c(1,2,11)]

names(df1)[3] = "446"                                        


merge.table = function(sam) {
  
  df = read.table(paste0(sam, "_RPF+mRNA_cov_statA.txt" ), header = T, sep = "\t")
  
  df$TE = df$RPF_total/sum(df$RPF_total)/(df$mRNA_count/sum(df$mRNA_count)*1000/df$length)
  
  df1 = df[df$RPF_coverage > 0.3 & df$mRNA_coverage > 0.5,]
  
  df1 = df1[,c(1,11)]
  
  names(df1)[2] = sam            
}