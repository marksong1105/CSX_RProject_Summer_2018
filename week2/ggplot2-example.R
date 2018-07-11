install.packages("ggplot2")
library ("ggplot2")

iris

#單變數：類別型
ggplot(data = iris, aes(x = Species)) +
  geom_bar(fill = "lightblue", colour = "black")


#單變數：連續型
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram()

#雙變數：連續 vs 連續
ggplot(data = iris, aes(x = Sepal.Length, y=Petal.Length)) +
  geom_point()

#雙變數：離散 vs 連續
ggplot(iris, aes(x=Species, y=Sepal.Length)) +
  geom_boxplot()

#多變量：鑽石銷售總體的關係
install.packages("GGally")
install.packages("scales")
install.packages("memisc")

library(ggplot2)
library(GGally)
library(scales)
library(memisc)

set.seed(20022012)
iris_samp <- iris[sample(1:length(iris$Sepal.Length), 100), ]
ggpairs(iris_samp,lower= list(continuous = wrap("points", shape = I('.'))),
        upper = list(combo = wrap("box", outlier.shape = I('.'))))


