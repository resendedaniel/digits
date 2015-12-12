readData <- function() {
    train <- read.csv("data/train.csv")
}

readImg <- function(row) {
    matrix(unlist(row), 28)
}

plotImg <- function(img) {
    df <- data.frame(row=1:28, img)
    df <- melt(df, id='row') %>%
        rename(col=variable) %>%
        mutate(col=as.numeric(sub("X", "", col))) %>%
        mutate(col=-col+29)
    
    ggplot(df, aes(row, col, size=value, alpha = value / 255)) + 
        geom_point(shape=16) + 
        scale_size(range=c(1,3)) +
        xlab("") + ylab("") +
        theme_bw() + 
        theme(legend.position='none',
              axis.text.x=element_blank(),
              axis.text.y=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              axis.ticks=element_blank())
}

plotSample <- function(sample, n=9, char=NULL) {
    sample <- if(is.null(char)) {
        sample_n(sample, n)
    } else {
        sample_n(filter(sample, label==as.integer(char)), n)
    }
    
    g <- sapply(seq(n), function(i) {
        plotImg(readImg(sample[i,]))
    }, simplify=FALSE)
    
    do.call(grid.arrange, g)
}

averageImg <- function(sample, char=NULL) {
    sample <- sample %>% filter(label==as.integer(char))
    data.frame(t(colMeans(sample)))
}

plotSampleAverage <- function(data) {
    data <- raw_train
    g <- sapply(1:9, function(i) {
        img <- readImg(averageImg(data, i))
        plotImg(img)
    }, simplify=FALSE)
    
    do.call(grid.arrange, g)
}