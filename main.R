print("loading libraries")
source('source.R')
source('model.R')

# Parameters
n_breaks <-4

print("reading data")
raw_train <- readData()
label <- raw_train$label

print("generating features")
train <- generateFeatures(raw_train, n_breaks)
train$label <- factor(label)

plotSample(raw_train, 9)

print("machine learning")
model <- randomForest(label ~ ., data=train, ntree=1000)
print(model)

print("predictions")
test <- read.csv("data/test.csv")
test <- generateFeatures(test, n_breaks)
predictions <- predict(model, newdata=test)
predictions <- data.frame(ImageId=1:nrow(test), Label=predictions)

write.csv(predictions, "data/predictions.csv", row.names=FALSE) 
