calibData = readmatrix('data_phan1_calibrated.txt');
validCalibData = calibData(1:500, 1:6);

ax_calib = validCalibData(:, 1) / 16384;
ay_calib = validCalibData(:, 2) / 16384;
az_calib = validCalibData(:, 3) / 16384;
gx_calib = validCalibData(:, 4) / 131;
gy_calib = validCalibData(:, 5) / 131;
gz_calib = validCalibData(:, 6) / 131;

f = figure('Position', [100, 100, 800, 600]);

subplot(2,1,1);
plot(ax_calib, 'LineWidth', 1.2); hold on;
plot(ay_calib, 'LineWidth', 1.2);
plot(az_calib, 'LineWidth', 1.2);
title('Calibrated Accelerometer Data (g)');
ylabel('Acceleration (g)');
legend('Ax', 'Ay', 'Az');
grid on;
hold off;

subplot(2,1,2);
plot(gx_calib, 'LineWidth', 1.2); hold on;
plot(gy_calib, 'LineWidth', 1.2);
plot(gz_calib, 'LineWidth', 1.2);
title('Calibrated Gyroscope Data (deg/s)');
xlabel('Sample');
ylabel('Angular Velocity (deg/s)');
legend('Gx', 'Gy', 'Gz');
grid on;
hold off;

saveas(f, 'DoThi_Calibrated_Phan1.png');