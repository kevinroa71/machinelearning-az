# Importo el dataset
dataset <- read.csv(file = "./ejercicios/regresion-lineal-polinomica/Position_Salaries.csv")

# Ajusto el modelo polinomico
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
regressor = lm(formula = Salary ~ Level + Level2 + Level3 + Level4, data = dataset)
summary(regressor)

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
