data = readmatrix('DulieuGyro.txt');

gx = data(:, 1);
gy = data(:, 2);
gz = data(:, 3);

f = figure('Position', [100, 100, 800, 400]);

plot(gx, 'r', 'LineWidth', 1.2); hold on;
plot(gy, 'g', 'LineWidth', 1.2);
plot(gz, 'b', 'LineWidth', 1.2);

yline(0.05, '--k', 'LineWidth', 1.5);
yline(-0.05, '--k', 'LineWidth', 1.5);
yline(0, '-k', 'LineWidth', 1);

title('Van toc goc (Gyroscope) sau khi tu dong hieu chuan');
xlabel('Mau du lieu (Sample)');
ylabel('Van toc goc (deg/s)');
legend('Gx', 'Gy', 'Gz', 'Nguong +0.05', 'Nguong -0.05');
grid on;
ylim([-0.5 0.5]);
hold off;

saveas(f, 'DoThi_Gyro_Calibrated_Phan2.png');