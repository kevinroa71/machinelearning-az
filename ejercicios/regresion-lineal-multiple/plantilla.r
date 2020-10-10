# Importo el dataset
dataset <- read.csv(file = "./ejercicios/regresion-lineal-multiple/50_Startups.csv")

# Datos categoricos
states = unique(dataset$State) 
dataset$State = factor(
  x = dataset$State,
  levels = states,
  labels = seq(from = 1, to = length(states))
)

# Separar conjunto de entrenamiento y testing
install.packages("caTools")
library(caTools)
set.seed(0)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
testing_set  = subset(dataset, split == FALSE)

# Ajusto el modelo de regresion lineal multiple
regressor = lm(formula = Profit ~ . , data = training_set)
summary(regressor)

# Predecir el conjunto de testing
y_predict = predict(regressor, newdata = testing_set)

# Opimizar el modelo
backward_elimination <- function(x, sl) {
  num_vars = length(x)
  for (i in c(1:num_vars)){
    regressor = lm(formula = Profit ~ ., data = x)
    max_var = max(coef(summary(regressor))[c(2:num_vars), "Pr(>|t|)"])
    if (max_var > sl) {
      j = which(coef(summary(regressor))[c(2:num_vars), "Pr(>|t|)"] == max_var)
      x = x[, -j]
    }
    num_vars = num_vars - 1
  }
  return(summary(regressor))
}

sl = 0.05
backward_elimination(dataset, sl)
