print("loading libraries")
source('source.R')
source('model.R')

# Parameters
n_breaks <-1:14

benchmark <- list()

t <- proc.time()
train <- readData()
benchmark$readData <- proc.time() - t

models <- sapply(n_breaks, function(breaks) {
    data <- generateFeatures(train, breaks)
    benchmark$generateFeatures <- proc.time() - t
    
    print("machine learning")
    model <- randomForest(label ~ ., data=data)
    benchmark$readData <- proc.time() - t
    wrong <- train[model$predict != data$label,]
    
    print("# Results")
    print(benchmark)
    print(model)
    
    model
}, simplify=FALSE)

error <- lapply(models, function(m) {
    sum(m$predicted != data$label) / length(data$label)
})
error <- data.frame(breaks=n_breaks, error=unlist(error))
ggplot(error, aes(breaks, error)) +
    geom_point() +
    scale_y_continuous(label=percent) +
    geom_smooth()

beep(4)
# predict(model, newdata=test)

