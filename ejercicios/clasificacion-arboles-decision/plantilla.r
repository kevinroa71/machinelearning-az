# Importo el dataset
dataset <- read.csv(file = './ejercicios/clasificacion-arboles-decision/Social_Network_Ads.csv')

# Datos categoricos
purchased = unique(dataset$Purchased) 
dataset$Purchased = factor(
  x = dataset$Purchased,
  levels = purchased,
  labels = seq(from = 1, to = length(purchased))
)

# Separar conjunto de entrenamiento y testing
install.packages("caTools")
library(caTools)
set.seed(0)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
testing_set  = subset(dataset, split == FALSE)


# Ajustar modelo de arboles
install.packages('rpart')
library(rpart)
clasificador = rpart(formula = Purchased ~ Age + EstimatedSalary, data = training_set, control = rpart.control(minsplit = 1))

# Prediccion de los resultados
y_predic = predict(clasificador, newdata = testing_set, type = "class")

# Crear la matriz de confusion
cm = table(testing_set[, 5], y_predic)

# Vizualizacion de los datos
library(ElemStatLearn)
set = testing_set[, 3:5]
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.1)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 250)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(clasificador, newdata = grid_set, type = "class")
plot(set[, -3],
     main = 'Clasificación (Conjunto de testing)',
     xlab = 'Edad', ylab = 'Sueldo Estimado',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))


# representacion grafica del arbol
plot(clasificador)
text(clasificador)
