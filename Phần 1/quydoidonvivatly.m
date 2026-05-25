rawData = readmatrix(['Phan1.1-du-lieu-tho.txt']);

validData = rawData(1:500, 1:6);

ax = validData(:, 1) / 16384;
ay = validData(:, 2) / 16384;
az = validData(:, 3) / 16384;
gx = validData(:, 4) / 131;
gy = validData(:, 5) / 131;
gz = validData(:, 6) / 131;

f = figure('Position', [100, 100, 800, 600]);

subplot(2,1,1);
plot(ax, 'LineWidth', 1.2); hold on;
plot(ay, 'LineWidth', 1.2);
plot(az, 'LineWidth', 1.2);
title('Accelerometer Data in Physical Units');
ylabel('Acceleration (g)');
legend('Ax', 'Ay', 'Az');
grid on;
hold off;

subplot(2,1,2);
plot(gx, 'LineWidth', 1.2); hold on;
plot(gy, 'LineWidth', 1.2);
plot(gz, 'LineWidth', 1.2);
title('Gyroscope Data in Physical Units');
xlabel('Sample');
ylabel('Angular Velocity (deg/s)');
legend('Gx', 'Gy', 'Gz');
grid on;
hold off;

saveas(f, 'DoThi_DonViVatLy_Phan1.png');