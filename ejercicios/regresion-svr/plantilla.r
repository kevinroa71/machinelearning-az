# Importo el dataset
dataset <- read.csv(file = "./ejercicios/regresion-svr/Position_Salaries.csv")

# Ajustar el modelo de svr
install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ Level, data = dataset, type = 'eps-regression', kernel="radial")

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

