readImg <- function(row) {
    # Read a single line of 28x28 matrix character
    t(matrix(unlist(row[-1]), 28))
}

plotImg <- function(img) {
    df <- data.frame(row=1:28, img)
    df <- melt(df, id='row') %>%
        rename(col=variable) %>%
        mutate(col=as.numeric(sub("X", "", col))) %>%
        mutate(col=-col+29)
    
    ggplot(df, aes(row, col, size=value, alpha=value/255)) + 
        geom_point(shape=16) + 
        xlab("") + ylab("") +
        theme_bw() + 
        theme(legend.position='none')
}

plotSample <- function(sample, n=9, char=NULL) {
    sample <- sample_n(filter(sample, label==as.integer(char)), n)
    g <- sapply(seq(n), function(i) {
        plotImg(readImg(sample[i,]))
    }, simplify=FALSE)
    
    do.call(grid.arrange, g)
}

averageImg <- function(sample, char=NULL) {
    sample <- sample %>% filter(label==as.integer(char))
    data.frame(t(colMeans(sample)))
}