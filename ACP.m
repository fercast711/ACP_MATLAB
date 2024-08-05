%% Analisis de Componentes Principales
%% Leer el archivo csv
opts = detectImportOptions('EjemploEstudiantes.csv');
opts = setvartype(opts, 'double');
opts = setvaropts(opts, 'DecimalSeparator', ',');
df = readtable("EjemploEstudiantes.csv", opts);
disp(df);
%% Paso 1: Centrar y reducir la tabla original de datos

