data = readmatrix('Phan2.1.txt');

ax_raw = data(:, 1);
ay_raw = data(:, 2);
az_raw = data(:, 3);

offset_ax = 0.035;
offset_ay = -0.005;
offset_az = -0.065;

ax = ax_raw - offset_ax;
ay = ay_raw - offset_ay;
az = az_raw - offset_az;

f = figure('Position', [100, 100, 800, 500]);

plot(ax, 'r', 'LineWidth', 1.5); hold on;
plot(ay, 'g', 'LineWidth', 1.5);
plot(az, 'b', 'LineWidth', 1.5);

yline(1, '--k', 'LineWidth', 1);
yline(-1, '--k', 'LineWidth', 1);
yline(0, '--k', 'LineWidth', 1);

title('Calibrated Gravity Verification (1g) in 6 Positions');
xlabel('Sample');
ylabel('Acceleration (g)');
legend('Ax', 'Ay', 'Az');
grid on;
ylim([-1.5 1.5]);
hold off;

saveas(f, 'DoThi_KiemChung_1g_Calibrated.png');