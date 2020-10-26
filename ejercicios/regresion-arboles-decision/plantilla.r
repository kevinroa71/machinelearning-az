# Importo el dataset
dataset <- read.csv(file = "./ejercicios/regresion-arboles-decision/Position_Salaries.csv")

# Ajustar el modelo de arboles de desiciones
library(rpart)
regressor = rpart(formula = Salary ~ Level, data = dataset, control = rpart.control(minsplit = 1))

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
