% Funkcja wyjściowa
N = 500;
t = linspace(0, 5*pi, N); 
signal = sin(t); 
c = sqrt(3);
noise = -c + (c - (-c)) * rand(1, N);
final = signal + noise;

% Zakres H co 5 jednostek od 5 do 50
H_v = 5:5:50;  
mse_values = zeros(1, length(H_v));  % Tablica na wartości MSE

% Obliczenie MSE dla każdego H w zakresie H_v
for i = 1:length(H_v)
    H = H_v(i);
    temp = zeros(1, N);          
    for j = 1:N
        if j < H
            temp(j) = mean(final(1:j)); % Średnia z początkowych próbek
        else
            temp(j) = mean(final(j-H+1:j)); % Średnia ruchoma
        end
    end
    estimated_signal = temp;  % Estymowany sygnał dla danego H
    
    % Obliczenie MSE dla danego H
    mse_values(i) = mean((signal - estimated_signal).^2);  % MSE dla danego H
end

% Tworzenie wykresu MSE w funkcji H
figure;
plot(H_v, mse_values, '-o', 'LineWidth', 1.5, 'MarkerSize', 8);
title('Porównanie MSE dla różnych wartości H');
xlabel('H (Długość okna średniej ruchomej)');
ylabel('Błąd średniokwadratowy (MSE)');
grid on;

% Dodatkowy krok: wybór H przez użytkownika
H_user = input('Wprowadź wartość H do wizualizacji (np. 5, 10, 30): ');

% Wykres dla wybranego przez użytkownika H
temp_user = zeros(1, N);          
for j = 1:N
    if j < H_user
        temp_user(j) = mean(final(1:j)); % Średnia z początkowych próbek
    else
        temp_user(j) = mean(final(j-H_user+1:j)); % Średnia ruchoma
    end
end

% Rysowanie estymacji sygnału dla wybranego H przez użytkownika
figure;
hold on;
plot(t, final, '.', 'DisplayName', 'Sygnał zaszumiony');
plot(t, temp_user, '-', 'DisplayName', ['Estymowany sygnał dla H = ', num2str(H_user)]);
plot(t, signal, '-', 'DisplayName', 'Sygnał oryginalny');
hold off;