# Librerias
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Importo el dataset
dataset = pd.read_csv('./ejercicios/regresion-bosques-aleatorios/Position_Salaries.csv')
x = dataset.iloc[:, 1:-1].values
y = dataset.iloc[:, -1].values

# Creo el modelo de bosques aleatorios
from sklearn.ensemble import RandomForestRegressor
regresion = RandomForestRegressor(n_estimators=300, random_state=0)
regresion.fit(x, y)

# Predecir el conjunto de testing
y_predic = regresion.predict(x)

# Graficar los resultados
plt.scatter(x, y, color="red")
plt.plot(x, y_predic, color="blue")
plt.title("Sueldo vs Nivel")
plt.xlabel("Nivel")
plt.ylabel("Sueldo $")
plt.show()
