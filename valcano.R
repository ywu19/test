library(ggplot2)
library(DESeq2)
a <- read.csv('C:\\Users\\Administrator\\Desktop\\zhujian\\count.csv')
row.names(a) <- a[,1]
a <- a[,-1]
a <- round(a)
condition <- factor(c(rep("control",3),rep("treat",3)), levels = c("control","treat"))
a5 <- data.frame(row.names=colnames(a), condition)
# 构建dds
dds <- DESeqDataSetFromMatrix(a, a5, design= ~ condition)
dds <- DESeq(dds)
res <- results(dds,contrast = c("condition","treat","control")) #一定是treat 比control
res <- na.omit(res)
head(res)
summary(res)
write.csv(res,'C:\\Users\\Administrator\\Desktop\\zhujian\\all_deseq.csv')

'''
#筛选差异基因
diff_gene <- subset(res,padj<0.05 & abs(log2FoldChange)>1)
dim(diff_gene)
write.csv(diff_gene,'C:\\Users\\Administrator\\Desktop\\zhujian\\diff_gene.csv')
'''

#做火山图
data <- data.frame(logFC=res$log2FoldChange,padj=res$padj)
# 新建一列作为分组
data$Change[(data$padj > 0.05|data$padj=="NA")|(data$logFC < 1)& data$logFC > -1] <- "Not"
data$Change[data$padj <= 0.05 & data$logFC >= 1] <- "Up"
data$Change[data$padj <= 0.05 & data$logFC <= -1] <- "Down"

logFC <- res$log2FoldChange
padj=res$padj
# 选最大值作为xlim的上下边界
x_lim <- max(logFC,-logFC)
# 绘制火山图
p <- ggplot(data,aes(logFC,-1*log10(padj),
                     color = Change))+geom_point()+
  xlim(-5,5) +  labs(x="log2(FoldChange)",y="-log10(FDR)",title="siBCL3 vs siControl") #对应treat比control
p <- p + scale_color_manual(values =c("Down"="#0072B5","Not"="grey",'Up'="#BC3C28"))+
  geom_hline(yintercept=-log10(0.05),linetype=4)+
  geom_vline(xintercept=c(-1,1),linetype=4)
p <- p +theme(panel.grid =element_blank())+
  theme(axis.line = element_line(size=0))+ylim(0,15)

#p <- p  +guides(colour = FALSE)
p <- p +theme(axis.text=element_text(size=20),axis.title=element_text(size=20))
p
