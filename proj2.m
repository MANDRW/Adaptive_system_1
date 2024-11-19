% Sygnal oryginalny
N = 1000;
signal = 2;

% szum
c = sqrt(3);% VAR=(c^2)/3, z wariancji
noise = -c + (c - (-c)) * rand(1, N);
final = signal + noise;

% Sygnal z szumem
figure;
hold on
plot(t, signal,'-');
plot(t, final,'-');
title('Oryginalny sygnał z szumem');
xlabel('Czas');
ylabel('Amplituda');
grid on;
hold off

tetag=[1,1,1];

dane=cell(1000);





%yk=tetag(1,1)*final(k)+tetag(1,2)*final(k-1)+tetag(1,3)*final(k-2)+noise(k)

%



function wynik = rek(tetag, noise, final, k, wynik)
    % Wartości parametrów
    b0 = tetag(1, 1);
    b1 = tetag(1, 2);
    b2 = tetag(1, 3);
    
    % Warunek zakończenia rekurencji
    if k <= 2
        return; % Zakończenie, jeśli k <= 2, brak dalszych obliczeń
    end
    
    % Obliczanie v_k (rekurencyjnie)
    v_k = b0 * final(k) + b1 * final(k-1) + b2 * final(k-2);
    
    % Dodanie zakłócenia z rozkładu normalnego
    z_k = randn; % Zakłócenie normalne
    y_k = v_k + z_k + noise(k); % Zakłócenie do v_k
    
    % Zapisywanie wyników
    wynik(k, :) = [final(k-2:k); y_k];
    
    % Rekurencyjne wywołanie funkcji dla k-1
    wynik = rek(tetag, noise, final, k-1, wynik);
end

% Funkcja główna
N = 1000; % Liczba punktów
tetag = [1, 1, 1]; % Wartości b0, b1, b2
final = rand(N, 1); % Wektor u1, u2, ..., uN (proces losowy)
noise = randn(N, 1); % Zakłócenie z rozkładu normalnego

% Inicjalizacja tablicy wyników
wynik = zeros(N, 1);

% Wywołanie funkcji rekurencyjnej
wynik = rek(tetag, noise, final, N, wynik);

% Wyświetlenie wyników

disp(wynik);
