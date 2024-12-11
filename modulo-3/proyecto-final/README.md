
# Proyecto (Final): "Music makes the people come together"

## Motivación

El proyecto surge como idea familiar para salir del bucle de canciones que escuchamos en viajes largos.

El set de datos se ha obtenido de [Kaggle](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset). Debido al tamaño (5MB) no está incluido en el proyecto (GitHub tan sólo permite 2MB como tamaño de fichero máximo en las cuentas gratuitas).

## EDA (Exploratory Data Analysis)

En general se trata de un dataset bastante limpio, aunque no por ello exento de algunas anomalías:

- Las columnas `'Licensed'` y `'official_video'`, siendo de tipo __string__, presentaban valores de distinta índole en el sentido de que había mezclados 'True', 'False' y '0'. 

- La columna `'Title'` no siempre presenta valor; algunas veces es '0'.

- Algunos nulos en la columna `'EnergyLiveness'`.

### Columnas Categóricas

Los valores anómalos en `'Licensed'` y `'official_video'` quedan descubiertos al visualizar dichas columnas mediante gráficos de pastel.

<img src="./figures/eda_categorical.png" alt="Categorical columns" width="750"/>

<!--<img src="./figures/eda_categorical.png" alt="Categorical columns" width="1024" style="margin-left:50px"/>-->

### Columnas Numéricas

Las columnas numéricas son muy diversas, tanto en valores absolutos, como en distribución y varianza.

<img src="./figures/eda_numerical.png" alt="Numerical columns" width="1024"/>
<br/><br/>

<img src="./figures/eda_numerical_statistics.png" alt="Numerical columns statistics" width="550" style="margin-left:50px"/>
<br/><br/>

Asimismo, presentan numerosos valores atípicos.

<img src="./figures/eda_numerical_violin.png" alt="Violinplot of numerical columns" width="1024"/>
<br/><br/>

Es impracticable trazar un _paiplot_ de todas las variables numéricas; la gráfica queda minúscula y poco útil. Como ejemplo, mostraremos el gráfico de dispersión entre dos variables cualesquiera.

<img src="./figures/eda_dispersion_energy_danceability.png" alt="Scatter plot between Energy and Danceability" width="800"/>
<br/><br/>

Del aspecto de nube deducimos que esas dos variables no están correlacionadas. De hecho, lo comprobamos mediante la matriz de correlación.

<img src="./figures/eda_correlacion.png" alt="Matriz de correlacion" width="800"/>
<br/><br/>





