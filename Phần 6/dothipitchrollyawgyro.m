data = readmatrix('dulieupitchrollyawgyro.txt');

roll_gyro = data(:, 1);
pitch_gyro = data(:, 2);
yaw_gyro = data(:, 3);

t = (1:length(roll_gyro)) * 0.02;
f = figure('Position', [100, 100, 800, 450]);

plot(t, roll_gyro, 'b', 'LineWidth', 1.5); hold on;
plot(t, pitch_gyro, 'g', 'LineWidth', 1.5);
plot(t, yaw_gyro, 'r', 'LineWidth', 1.5);
yline(0, '--k', 'LineWidth', 1);

title('Hinh 6.2: Goc Roll, Pitch, Yaw tich phan tu Gyroscope');
xlabel('Thoi gian (s)');
ylabel('Goc (Do)');
legend('Roll (Lan)', 'Pitch (Ngang)', 'Yaw (Xoay)', 'Location', 'best');
grid on;
hold off;

saveas(f, 'DoThi_6_2_Gyroscope.png');