

# 得到相关性系数列表





# 作图

library(reshape2)
library(ggplot2)
library(RColorBrewer)

b <- read.csv("C:\\Users\\Administrator\\Desktop\\zhujian\\correlation.csv")

bb = as.matrix(b[,-1]) #删去第一列转化为矩阵
rownames(bb) = names(b)[-1] #第一列作为行名
#class(bb) 矩阵
bbb = melt(bb)
names(bbb)=c("Var1","Var2","pearson_value")

ggplot(bbb, aes(Var1, Var2, fill=pearson_value))+
  #geom_tile(width=0.8, height=0.8)+
  geom_tile(color='black')+
  geom_text(label=round(bbb$pearson_value, 3))+
  scale_fill_gradient(low='#DEEBF7',high='#08519C')+
  theme(axis.text = element_text(angle=30, hjust=1,size=11,vjust=0,color='black'),
        panel.background = element_rect(fill='transparent'),
        panel.grid=element_line(color='grey'),legend.title = element_text(size = 13))+
  labs(x="",y="") 



'''
a <- read.csv("C:\\Users\\Administrator\\Desktop\\zhujian\\correlation.csv")
rownames(a) <- a[,1] #将第一列作为行名
aa <- a[,-1] # 删去第一列
class(aa) # 数据框
#data <- melt(aa) 提示没有变量
aaa <- as.matrix(aa)
data <- melt(aaa) # 成功，所以要转化为矩阵

'''