package_list <- c('dplyr',
                  'reshape2',
                  'ggplot2',
                  'gridExtra',
                  'caret',
                  'randomForest',
                  'moments',
                  'scales')
for(p in package_list) {
    if(!(p %in% rownames(installed.packages()))) install.packages(p, repos='http://cran.rstudio.com', lib='/usr/local/lib/R/site-library/')
    library(p, character.only = TRUE)
}
source('api.R')


library(dplyr)
library(reshape2)
library(ggplot2)
library(gridExtra)
library(caret)
library(randomForest)
library(moments)
library(beepr)
