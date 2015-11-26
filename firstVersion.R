source('source.R')
char <- 1
n <- 50

train <- read.csv("data/train.csv")

row <- sample_n(train, 1)
img <- readImg(row)
img
plotImg(img)
row$label
sum(apply(img, 1, mean) > 10) / sum(apply(img, 2, mean) > 10)

ave <- sapply(0:9, function(char) {
    averageImg(train, char)
}, simplify=FALSE)

sample <- sample_n(train, n)

count <- 0
prediction <- apply(sample, 1, function(row) {
    print(count)
    count <<- count + 1
    img <- readImg(row)
    x <- unlist(lapply(ave, function(a) {
        abs(mean(unlist(matrix((img+1) / (a+1)))))
    }))
    
    predict <- which.min(x) - 1
    
    g <- plotImg(img) + ggtitle(ifelse(row[1] == predict,
                                       paste0("Yey! ", predict),
                                       paste0("Noo!, ", predict)))
    print(g)
    
    predict
})

paste0(mean(sample$label == prediction) * 100, "%")

plotImg(readImg(ave[[9]]))

