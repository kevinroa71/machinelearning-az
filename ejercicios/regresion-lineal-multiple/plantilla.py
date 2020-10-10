# Librerias
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Importo el dataset
dataset = pd.read_csv('./ejercicios/regresion-lineal-multiple/50_Startups.csv')
x = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# Datos categoricos
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
oencoder = OneHotEncoder()
cotransf = ColumnTransformer(
    [
        ('one_hot_encoder', oencoder, [3])
    ],
    remainder='passthrough'
)
x = cotransf.fit_transform(x)

# Evitar la trampa de las variables dummy
x = x[:, 1:]

# Separar conjunto de entrenamiento y testing
from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)

# Ajusto mi modelo de regresion
from sklearn.linear_model import LinearRegression
regresion = LinearRegression()
regresion.fit(x_train, y_train)

# Predecir el conjunto de testing
y_predic = regresion.predict(x_test)

# Optimizar el modelo utilizando la eliminacion hacia atras
import statsmodels.api as sm
x = sm.add_constant(x)
sl = 0.05 # nivel de significacion


# Eliminación hacia atrás utilizando solamente p-valores
def backward_elimination(x, y, sl):
    num_vars = len(x[0])
    for i in range(0, num_vars):
        regresion_ols = sm.OLS(endog=y, exog=x.tolist()).fit()
        max_var = max(regresion_ols.pvalues).astype(float)
        if max_var > sl:
            for j in range(0, num_vars - i):
                if (regresion_ols.pvalues[j].astype(float) == max_var):
                    x = np.delete(x, j, 1)
    regresion_ols.summary()
    return x

# Eliminación hacia atrás utilizando  p-valores y el valor de  R Cuadrado Ajustado
def backward_elimination_square(x, y, sl):
    num_vars = len(x[0])
    temp = np.zeros((50,6)).astype(int)
    for i in range(0, num_vars):
        regresion_ols = sm.OLS(y, x.tolist()).fit()
        max_var = max(regresion_ols.pvalues).astype(float)
        adjr_before = regresion_ols.rsquared_adj.astype(float)
        if max_var > sl:
            for j in range(0, num_vars - i):
                if (regresion_ols.pvalues[j].astype(float) == max_var):
                    temp[:,j] = x[:, j]
                    x = np.delete(x, j, 1)
                    tmp_regressor = sm.OLS(y, x.tolist()).fit()
                    adjr_after = tmp_regressor.rsquared_adj.astype(float)
                    if (adjr_before >= adjr_after):
                        x_rollback = np.hstack((x, temp[:,[0,j]]))
                        x_rollback = np.delete(x_rollback, j, 1)
                        print (regresion_ols.summary())
                        return x_rollback
                    else:
                        continue
    regresion_ols.summary()
    return x

x_opt = x[:, :]
print(backward_elimination(x_opt, y, sl))
print(backward_elimination_square(x_opt, y, sl))
