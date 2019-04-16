library(rpart)
library(rpart.plot)
library(readxl)
library(randomForest)
Admission_Predict_Dataset <- read_excel("~/Admission_Predict Dataset.xlsx")
View(Admission_Predict_Dataset)
nrow(Admission_Predict_Dataset * 0.6)
nrow(Admission_Predict_Dataset * 0.75)
observe_rows <- sample(400, 303)
ad_train <- Admission_Predict_Dataset[observe_rows,]
ad_test <- Admission_Predict_Dataset[-observe_rows,]
fit_model <- rpart(`University Rating` ~ `TOEFL Score` + `GRE Score`, 
                                data = ad_train, method = "class", 
                                control = rpart.control(cp = 0, maxdepth = 3, minsplit = 2))
ad_pred <- predict(fit_model, ad_test, type = "class")
mean(ad_pred==ad_test$`University Rating`)
fit2 <- randomForest(ad_train$`University Rating` ~ ad_train$`GRE Score`, data = ad_train)
plot(fit2)

