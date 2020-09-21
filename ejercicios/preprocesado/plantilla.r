# Importo el dataset
dataset <- read.csv(file = "./ejercicios/preprocesado/Data.csv")

# Limpiar los N/A
meanAge = mean(dataset$Age, na.rm=TRUE)
meanSal = mean(dataset$Salary, na.rm = TRUE)
dataset$Age[is.na(dataset$Age)] = meanAge
dataset$Salary[is.na(dataset$Salary)] = meanSal

# Datos categoricos
countries = unique(dataset$Country) 
dataset$Country = factor(
  x = dataset$Country,
  levels = countries,
  labels = seq(from = 1, to = length(countries))
)

purchased = unique(dataset$Purchased)
dataset$Purchased = factor(
  x = dataset$Purchased,
  levels = purchased,
  labels = seq(from = 0, to = length(purchased)-1)
)

# Separar conjunto de entrenamiento y testing
install.packages("caTools")
library(caTools)
set.seed(0)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
testing_set  = subset(dataset, split == FALSE)

# Escalar los datos
training_set[, 2:3] = scale(training_set[, 2:3])
testing_set[, 2:3]  = scale(testing_set[, 2:3])
