% Sygnal oryginalny
N = 500;
t = linspace(0, 5*pi, N); 
signal = 2 * sin(t); % y=2sin(t)

% szum
c = sqrt(3);% VAR=(c^2)/3, z wariancji
noise = -c + (c - (-c)) * rand(1, N);
final = signal + noise;

% Sygnal z szumem
figure;
hold on
plot(t, signal,'-');
plot(t, final,'.');
title('Oryginalny sygnał z szumem');
xlabel('Czas');
ylabel('Amplituda');
grid on;
hold off

% optymalne H wzgledem MSE
tab_H = 5:1:50;                % H z przedzialu 5-50
tab_mse = zeros(1, length(tab_H)); 


for i = 1:length(tab_H)
    H = tab_H(i);
    temp = zeros(1, N);
    for j = 1:N
        if j < H
            temp(j) = mean(final(1:j)); % jezeli ilosc wzcesniejszych punktow <H
        else
            temp(j) = mean(final(j-H+1:j));
        end  
    end
    estimated_signal = temp;  
    % mse dla danego H
    tab_mse(i) = mean((signal - estimated_signal).^2);
end

% Wykres MSE dla H
figure;
plot(tab_H, tab_mse, '.-');
title('Porównanie MSE dla różnych wartości H');
xlabel('H');
ylabel('MSE');
grid on;

% sygnał dla najlepszego H
H_best = 10; 
temp_best = zeros(1, N);

for j = 1:N
    if j < H_best
        temp_best(j) = mean(final(1:j)); 
    else
        temp_best(j) = mean(final(j-H_best+1:j)); 
    end
end

% Wykres estymowanego sygnału dla najlepszego H
figure;
hold on;
plot(t, signal, '-', 'DisplayName', 'Sygnał oryginalny');
plot(t, temp_best, '-', 'DisplayName', 'Estymowany sygnał dla H = 10');
plot(t, final, '.', 'DisplayName', 'Sygnał zaszumiony');
title('Estymacja sygnału dla H = 10');
xlabel('Czas');
ylabel('Amplituda');
grid on;
hold off;

% mse od wariancji zaklocen
tab_var = linspace(0.01, 1, 50);%var od 0.01 do 1
tab_mse_var = zeros(1, length(tab_var));

for k = 1:length(tab_var)
    var = tab_var(k);
    c = sqrt(3 * var);          
    noise = -c + (c - (-c)) * rand(1, N); 
    final = signal + noise;           
    tab_mse_var(k) = mean((signal - final).^2);
end
% wykres mse od var
figure;
plot(tab_var, tab_mse_var,'.-');
title('Zależność MSE od wariancji');
xlabel('VAR');
ylabel('MSE');
grid on;

