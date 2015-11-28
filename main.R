print("loading libraries")
source('source.R')
source('model.R')

# Parameters
n_breaks <-4

benchmark <- list()

t <- proc.time()
train <- readData()
benchmark$readData <- proc.time() - t

data <- generateFeatures(train, n_breaks)
benchmark$generateFeatures <- proc.time() - t

print("machine learning")
model <- randomForest(label ~ ., data=data)
benchmark$readData <- proc.time() - t
wrong <- train[model$predict != data$label,]

print("# Results")
print(benchmark)
print(model)

beep(4)

