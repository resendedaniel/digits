# Digit Recognizer

Hi, I am still learning R, but I manage to do something. I guess I can team up.

The code calculates splits the image in quadrants. The image can splited in 3x3 like a hashtag or in different dimensions. Then for each dimension it calculates some statistical variable. Mean, Standard Deviation, Skewness and Kurtosis. then randomForest.

I rekon that I barely undertand the concept of Kurtosis. The fun of machine learning is that it might show some success even if you don't know that properly. If something is unknow, it is possible to go after it to understand.

The system calculates its variables for each row and create a new data frame of features. It binds the label and is passed trough a randomForest.

No parameters are set yet. The most I did wwas make some changes on ntree. It shows improvement, but not meaningfull to worth the brute force. There is a higher asymptote.

Now I am doing some experiments with diferents break numbers. I will let it processing overnight. In small samples indicates that around 4 breaks the second derivative slows, so that might be a good break point.

It's a little bit messy yet, but I pretend to work some more, but it can me delayed. I am kind of busy trying to set up the first robo advisor in my country.

