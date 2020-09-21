# Librerias
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Importo el dataset
dataset = pd.read_csv('./ejercicios/preprocesado/Data.csv')
x = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# Limpiar los N/A
from sklearn.impute import SimpleImputer
imputer = SimpleImputer(missing_values=np.nan, strategy="mean", verbose=0)
imputer = imputer.fit(x[:, 1:])
x[:, 1:] = imputer.transform(x[:, 1:])

# Datos categoricos
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.compose import ColumnTransformer
lencoder = LabelEncoder()
oencoder = OneHotEncoder()
cotransf = ColumnTransformer(
    [
        ('one_hot_encoder', oencoder, [0])
    ],
    remainder='passthrough'
)

x = cotransf.fit_transform(x)
y = lencoder.fit_transform(y)

# Separar conjunto de entrenamiento y testing
from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)

# Escalar los datos
from sklearn.preprocessing import StandardScaler
scaler  = StandardScaler()
x_train = scaler.fit_transform(x_train)
x_test  = scaler.transform(x_test)
