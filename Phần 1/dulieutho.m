rawData = readmatrix('Phan1.1-du-lieu-tho.txt');

validData = rawData(1:500, 1:6);

ax = validData(:, 1);
ay = validData(:, 2);
az = validData(:, 3);
gx = validData(:, 4);
gy = validData(:, 5);
gz = validData(:, 6);

f = figure('Position', [100, 100, 800, 600]);

subplot(2,1,1);
plot(ax, 'LineWidth', 1.2); hold on;
plot(ay, 'LineWidth', 1.2);
plot(az, 'LineWidth', 1.2);
title('Raw Accelerometer Data');
ylabel('LSB');
legend('Ax', 'Ay', 'Az');
grid on;
hold off;

subplot(2,1,2);
plot(gx, 'LineWidth', 1.2); hold on;
plot(gy, 'LineWidth', 1.2);
plot(gz, 'LineWidth', 1.2);
title('Raw Gyroscope Data');
xlabel('Sample');
ylabel('LSB');
legend('Gx', 'Gy', 'Gz');
grid on;
hold off;

saveas(f, 'DoThi_RawData_Phan1.png');