source('source.R')

# Parameters
breaks <- 3

train <- read.csv("data/train.csv")
# test <- read.csv("data/test.csv", nrows=1000)

x <- apply(train, 1, function(row) {
    matrix <- readImg(row)
    chunks <- ceiling((1:28)/(28/breaks))
    
    rowMeans <- rowMeans(matrix)
    rowMeans <- split(rowMeans, paste0("rows_", chunks))
    chunkRowMeans <- lapply(rowMeans, mean)
    names(chunkRowMeans) <- paste0("mean_", names(chunkRowMeans))
    chunkRowMeans <- data.frame(chunkRowMeans)
    chunkRowSd <- lapply(rowMeans, sd)
    names(chunkRowSd) <- paste0("sd_", names(chunkRowSd))
    chunkRowSd <- data.frame(chunkRowSd)
    
    colMeans <- colMeans(matrix)
    colMeans <- split(colMeans, paste0("cols_", chunks))
    chunkColMeans <- lapply(colMeans, mean)
    names(chunkColMeans) <- paste0("mean_", names(chunkColMeans))
    chunkColMeans <- data.frame(chunkColMeans)
    chunkColSd <- lapply(colMeans, sd)
    names(chunkColSd) <- paste0("sd_", names(chunkColSd))
    chunkColSd <- data.frame(chunkColSd)
    
    data.frame(chunkRowMeans, chunkRowSd, chunkColMeans, chunkColSd)
})
x <- do.call(rbind, x)
x$label <- factor(train$label)

# model <- train(label ~., data=train, method="rf")
t <- proc.time()
model <- randomForest(label ~ ., data=x, ntrees=1000)
model
print(proc.time() - t)

# predict(model, newdata=test)

