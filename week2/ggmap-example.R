install.packages("ggmap")
install.packages("maps")
library("ggmap")
library("mapproj")
library ("ggplot2")

#紫外線即時監測資料的 csv 檔
uv <- read.csv("d:/temps/0711-lab.CSV")

#ggplot2 紫外線即時監測資料
ggplot(data = uv, aes(x=SiteName ,y = UVI)) + geom_point(color="red")

#這裡原始的經緯度資料是以度分秒表示，在使用前要轉換為度數表示。
lon.deg <- sapply((strsplit(as.character(uv$WGS84Lon), ",")), as.numeric)
uv$lon <- lon.deg[1, ] + lon.deg[2, ]/60 + lon.deg[3, ]/3600
lat.deg <- sapply((strsplit(as.character(uv$WGS84Lat), ",")), as.numeric)
uv$lat <- lat.deg[1, ] + lat.deg[2, ]/60 + lat.deg[3, ]/3600

#使用 ggplot 的語法，把資料加入地圖中：
library(ggmap)
map <- get_map(location = 'Taiwan', zoom = 7)
ggmap(map) + geom_point(aes(x = lon, y = lat, size = UVI), data = uv)

#ggmap 負責畫出基本的地圖，然後再使用 geom_point 加上資料點
#除了指定經緯度之外，我們還使用紫外線的強度（UVI）來指定圓圈的大

#依照資料發佈單位（PublishAgency）分開畫圖
ggmap(map) +
  geom_point(aes(x = lon, y = lat, size = UVI), data = uv) +
  facet_grid( ~ PublishAgency)

#把地圖的顏色調淡一點，讓資料點更清楚
ggmap(map, darken = c(0.5, "white")) +
  geom_point(aes(x = lon, y = lat, size = UVI), data = uv)
