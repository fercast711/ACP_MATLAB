%% Analisis de Componentes Principales
%% Leer el archivo csv
opts = detectImportOptions('EjemploEstudiantes.csv');
opts = setvartype(opts, 'double');
opts = setvaropts(opts, 'DecimalSeparator', ',');
df = readtable("EjemploEstudiantes.csv", opts);
%% Paso 1: Centrar y reducir la tabla original de datos
matrix_df = df{:,2:end};
mean_matrix = mean(matrix_df);
std_matrix = std(matrix_df);
matrix_standardized = (matrix_df - mean_matrix)./std_matrix;
%% Paso 2: Realizar el calculo de la matriz de correlaciones
[n, m] = size(matrix_standardized);
matrix_cov = ((matrix_standardized')*(matrix_standardized)) / (n-1);
%% Paso 3: Calcular y ordenar (de mayor a menor) los vectores y valores propios de la matriz
[vectorEig, diagValuesEig] = eig(matrix_cov);
valuesEig = diag(diagValuesEig);
[valuesEigSort, idx] = sort(valuesEig, "descend");
vectorEigSort = vectorEig(:, idx);
%% Paso 4: Considerando los valores y vectores propios construir una matriz
matrix_v = vectorEigSort;
%% Paso 5: Calcular la matriz de componentes principales
%% Paso 6: Calculo de la matriz de calidades de individuos
%% Paso 7: Calculo la matriz de coordenada de las variables 
%% Paso 8: Calcular la matriz de calidades de las variables
%% Paso 9: Calcular el vector de inercias de los ejes
