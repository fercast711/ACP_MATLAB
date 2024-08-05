%% Analisis de Componentes Principales
%% Leer el archivo csv
opts = detectImportOptions('EjemploEstudiantes.csv');
opts = setvartype(opts, 'double');
opts = setvaropts(opts, 'DecimalSeparator', ',');
df = readtable("EjemploEstudiantes.csv", opts);
disp(df);
%% Paso 1: Centrar y reducir la tabla original de datos
%% Paso 2: Realizar el calculo de la matriz de correlaciones
%% Paso 3: Calcular y ordenar (de mayor a menor) los vectores y valores propios de la matriz
%% Paso 4: Considerando los valores y vectores propios construir una matriz
%% Paso 5: Calcular la matriz de componentes principales
%% Paso 6: Calculo de la matriz de calidades de individuos
%% Paso 7: Calculo la matriz de coordenada de las variables 
%% Paso 8: Calcular la matriz de calidades de las variables
%% Paso 9: Calcular el vector de inercias de los ejes
