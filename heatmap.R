library(pheatmap)
a <- read.csv('C:\\Users\\Administrator\\Desktop\\zhujian\\diff_fpkm.csv')
rownames(a)<- a[,2]
a <- a[,c(-1,-2,-3)]

data <- log2(a[,]+1)
pheatmap(data,show_rownames=F,
         color = colorRampPalette(c("blue","white","red"))(256),
         fontsize=10, gaps_row=1,scale="row",
         treeheight_row=50,treeheight_col =30,
         cellwidth = 80, cellheight = 0.08,cluster_row = T,border=FALSE,)


