%% Analisis de Componentes Principales
%% Leer el archivo csv
opts = detectImportOptions('EjemploEstudiantes.csv');
opts = setvartype(opts, 'double');
opts = setvaropts(opts, 'DecimalSeparator', ',');
df = readtable("EjemploEstudiantes.csv", opts);
data = readtable("EjemploEstudiantes.csv", TextType="string");
column_names = [data.Properties.VariableNames];
name = data{:, "Var1"};
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
matrix_components = matrix_standardized * matrix_v;
disp("Analisis de Componentes Principales (ACP)")
disp("Matriz de componentes principales:");
disp(matrix_components);
%% Paso 6: Calculo de la matriz de calidades de individuos
matrix_components_squared = matrix_components.^2;
matrix_quality = zeros(n,m);
for i= 1:n
    sum_components = sum(matrix_standardized(i,:).^2);
    for r=1:m
        matrix_quality(i,r) = matrix_components_squared(i,r) / sum_components;
    end
end
disp("Matriz de calidades de individuos:");
disp(matrix_quality);
%% Paso 7: Calculo la matriz de coordenada de las variables 
%% Paso 8: Calcular la matriz de calidades de las variables
%% Paso 9: Calcular el vector de inercias de los ejes
matrix_i = zeros(1,m);
for i=1:m
    matrix_i(1,i) = (100*valuesEigSort(i,1))/m;
end
disp("Matriz del vector de inercias:");
disp(matrix_i)
%% Grafica de plano principal
for idx=1:2
    if idx == 1
        x = 1;
        y = 2;
    else
        x=4;
        y=5;
    end
    scores = matrix_components(:, [x y]);

    figure;
    hold on;

    plot(scores(:, 1), scores(:, 2), 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'b');

    for i = 1:size(scores, 1)
        text(scores(i, 1), scores(i, 2), name{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end

    title('Plano Principal');
    xlabel(['Componente Principal ',num2str(x)]);
    ylabel(['Componente Principal ',num2str(y)]);
    grid on;
    axis equal;
    hold off;
end
%% Grafica del circulo de correlacion
for idx=1:2
    if idx == 1
        x = 1;
        y = 2;
    else
        x=4;
        y=5;
    end
    vectors = matrix_v(:, x:y);
    correlations = vectors .* sqrt(sum(vectors.^2, 2));

    figure;
    theta = linspace(0, 2*pi, 100);
    x_circle = cos(theta);
    y_circle = sin(theta);
    plot(x_circle, y_circle, 'k--'); 
    hold on;
    quiver(zeros(size(correlations, 1), 1), zeros(size(correlations, 1), 1), correlations(:, 1), correlations(:, 2), 0, 'b');
    text(correlations(:, 1) * 1.1, correlations(:, 2) * 1.1, column_names(2:end));
    title('Círculo de Correlación');
    xlabel(['Componente Principal ',num2str(x)]);
    ylabel(['Componente Principal ',num2str(y)]);
    axis equal;
    grid on;
    hold off;
end
