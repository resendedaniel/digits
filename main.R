print("loading libraries")
source('source.R')

# Parameters
breaks <- 5

print("reading data")
train <- read.csv("data/train.csv")
# test <- read.csv("data/test.csv", nrows=1000)

print("generating features")
n <- nrow(train)
count <- 1
x <- apply(train, 1, function(row) {
    matrix <- readImg(row)
    chunks <- ceiling((1:28)/(28/breaks))
    
    rowMeans <- rowMeans(matrix)
    colMeans <- colMeans(matrix)
    
    ## Aspect Ratio
    aspectRatio <- sum(rowMeans > 0) / sum(colMeans > 0)
    
    rowMeans <- split(rowMeans, paste0("rows_", chunks))
    colMeans <- split(colMeans, paste0("cols_", chunks))
    
    # Rows
    ## Means
    chunkRowMeans <- lapply(rowMeans, mean)
    names(chunkRowMeans) <- paste0("mean_", names(chunkRowMeans))
    chunkRowMeans <- data.frame(chunkRowMeans)
    
    ## Sd
    chunkRowSd <- lapply(rowMeans, sd)
    names(chunkRowSd) <- paste0("sd_", names(chunkRowSd))
    chunkRowSd <- data.frame(chunkRowSd)
    
    ## Skew
    chunkRowSkew <- lapply(rowMeans, skewness)
    names(chunkRowSkew) <- paste0("skew_", names(chunkRowSkew))
    chunkRowSkew <- data.frame(chunkRowSkew)
    
    ## Kurtosis
    chunkRowKurt <- lapply(rowMeans, kurtosis)
    names(chunkRowKurt) <- paste0("kurt_", names(chunkRowKurt))
    chunkRowKurt <- data.frame(chunkRowKurt)
    
    # Cols
    ## Means
    chunkColMeans <- lapply(colMeans, mean)
    names(chunkColMeans) <- paste0("mean_", names(chunkColMeans))
    chunkColMeans <- data.frame(chunkColMeans)
    
    ## Sd
    chunkColSd <- lapply(colMeans, sd)
    names(chunkColSd) <- paste0("sd_", names(chunkColSd))
    chunkColSd <- data.frame(chunkColSd)
    
    ## Skew
    chunkColSkew <- lapply(colMeans, skewness)
    names(chunkColSkew) <- paste0("skew_", names(chunkColSkew))
    chunkColSkew <- data.frame(chunkColSkew)
    
    ## Kurtosis
    chunkColKurt <- lapply(colMeans, kurtosis)
    names(chunkColKurt) <- paste0("kurt_", names(chunkColKurt))
    chunkColKurt <- data.frame(chunkColKurt)
    
    if(count %in% round(seq(1, n, length.out=100))) {
        cat(paste0(round(count/n * 100), "% "))
    }
    count <<- count + 1
    
    data.frame(aspectRatio,
               chunkRowMeans,
               chunkRowSd,
               chunkRowSkew,
               chunkRowKurt,
               chunkColMeans,
               chunkColSd,
               chunkColSkew,
               chunkColKurt)
})
x <- do.call(rbind, x)
x[sapply(x, is.nan)] <- 0
x <- data.frame(label=factor(train$label), x)

print("machine learning")
t <- proc.time()
model <- randomForest(label ~ ., data=x, ntree=1000)
model
print(proc.time() - t)

save(model, file="data/model.rda")

wrong <- train[model$predict != x$label,]

beep(4)
# predict(model, newdata=test)

