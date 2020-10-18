# Librerias
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Importo el dataset
dataset = pd.read_csv('./ejercicios/regresion-svr/Position_Salaries.csv')
x = dataset.iloc[:, 1:-1].values
y = dataset.iloc[:, -1].values

# Escalar los datos
from sklearn.preprocessing import StandardScaler
scaler_x  = StandardScaler()
scaler_y  = StandardScaler()
x = scaler_x.fit_transform(x)
y = scaler_y.fit_transform(y.reshape(-1, 1))

# Creo el modelo de soporte vectorial
from sklearn.svm import SVR
regresion = SVR(kernel="rbf")
regresion.fit(x, np.ravel(y))

# Predecir el conjunto de testing
y_predic = regresion.predict(x)

# Graficar los resultados
plt.scatter(scaler_x.inverse_transform(x), scaler_y.inverse_transform(y), color="red")
plt.plot(scaler_x.inverse_transform(x), scaler_y.inverse_transform(y_predic), color="blue")
plt.title("Sueldo vs Nivel")
plt.xlabel("Nivel")
plt.ylabel("Sueldo $")
plt.show()
