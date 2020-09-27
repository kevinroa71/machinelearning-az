# Librerias
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Importo el dataset
dataset = pd.read_csv('./ejercicios/regresion-lineal/Salary_Data.csv')
x = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# Separar conjunto de entrenamiento y testing
from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)

# Crear el modelo de regresion lineal
from sklearn.linear_model import LinearRegression
regresion = LinearRegression()
regresion.fit(x_train, y_train)

# Predecir el conjunto de testing
y_predic = regresion.predict(x_test)

# Graficar los resultados
plt.scatter(x_test, y_test, color="red")
plt.plot(x_test, y_predic, color="blue")
plt.title("Sueldo vs Años de experiencia")
plt.xlabel("Años de experiencia")
plt.ylabel("Sueldo $")
plt.show()
