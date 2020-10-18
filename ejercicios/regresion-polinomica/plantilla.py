# Librerias
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Importo el dataset
dataset = pd.read_csv('./ejercicios/regresion-lineal-polinomica/Position_Salaries.csv')
x = dataset.iloc[:, 1:-1].values
y = dataset.iloc[:, -1].values

# Ajustar mi dataset con las nuevas columnas polinomicas
from sklearn.preprocessing import PolynomialFeatures
poly_reg = PolynomialFeatures(degree=4)
x_poly = poly_reg.fit_transform(x)

# Crear el modelo de regresion lineal
from sklearn.linear_model import LinearRegression
regresion = LinearRegression()
regresion.fit(x_poly, y)

# Predecir el conjunto de testing
y_predic = regresion.predict(x_poly)

# Graficar los resultados
plt.scatter(x, y, color="red")
plt.plot(x, y_predic, color="blue")
plt.title("Sueldo vs Nivel")
plt.xlabel("Nivel")
plt.ylabel("Sueldo $")
plt.show()
