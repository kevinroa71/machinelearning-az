# Importo el dataset
dataset <- read.csv(file = "./ejercicios/regresion-lineal/Salary_Data.csv")

# Separar conjunto de entrenamiento y testing
install.packages("caTools")
library(caTools)
set.seed(0)
split = sample.split(dataset$Salary, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
testing_set  = subset(dataset, split == FALSE)

# Crear el modelo de regresion lineal
regressor = lm(formula = Salary ~ YearsExperience, data = training_set)

# Predecir el conjunto de testing
y_predict = predict(regressor, newdata = testing_set)

# Graficar los resultados
install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = testing_set$YearsExperience, y = testing_set$Salary), colour = "red") +
  geom_line(aes(x = testing_set$YearsExperience, y = y_predict), colour = "blue") +
  ggtitle("Sueldo vs Años de experiencia") +
  xlab("Años de experiencia") +
  ylab("Sueldo")
