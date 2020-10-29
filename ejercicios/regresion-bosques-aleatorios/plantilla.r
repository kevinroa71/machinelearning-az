# Importo el dataset
dataset <- read.csv(file = "./ejercicios/regresion-bosques-aleatorios/Position_Salaries.csv")

# Ajustar el modelo de bosques aleatorios
install.packages('randomForest')
library(randomForest)
regressor = randomForest(formula = Salary ~ Level, data = dataset)

# Predecir el conjunto
y_predict = predict(regressor, newdata = dataset)

# Graficar los resultados
install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), colour = "red") +
  geom_line(aes(x = dataset$Level, y = y_predict), colour = "blue") +
  ggtitle("Sueldo vs Nivel") +
  xlab("Nivel") +
  ylab("Sueldo")
