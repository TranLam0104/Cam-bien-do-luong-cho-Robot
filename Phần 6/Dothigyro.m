data = readmatrix('dulieugyro.txt');

roll_gyro  = data(:, 1);
pitch_gyro = data(:, 2);
roll_acc   = data(:, 3);
pitch_acc  = data(:, 4);

t = (0:length(roll_gyro)-1)' * 0.02;

% ---- Figure 1: Roll ----
f1 = figure('Position', [100, 100, 1000, 450]);
plot(t, roll_gyro, 'b-', 'LineWidth', 1.5); hold on;
plot(t, roll_acc,  'Color', [0.7 0.7 0.7], 'LineWidth', 1);
yline(0,  '--k', '0°',  'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(15, '--c', '15°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(30, '--r', '30°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(45, '--m', '45°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(90, '--g', '90°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
title('6.2 Goc Roll - Tich phan Gyroscope vs Accelerometer');
xlabel('Thoi gian (giay)');
ylabel('Goc Roll (Do)');
legend('Roll Gyro (tich phan)', 'Roll Accel (tham chieu)', 'Location', 'best');
grid on;
hold off;
saveas(f1, 'roll_gyro.png');

% ---- Figure 2: Pitch ----
f2 = figure('Position', [100, 600, 1000, 450]);
plot(t, pitch_gyro, 'r-', 'LineWidth', 1.5); hold on;
plot(t, pitch_acc,  'Color', [0.7 0.7 0.7], 'LineWidth', 1);
yline(0,  '--k', '0°',  'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(15, '--c', '15°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(30, '--r', '30°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(45, '--m', '45°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
yline(90, '--g', '90°', 'LineWidth', 1, 'LabelHorizontalAlignment', 'left');
title('6.2 Goc Pitch - Tich phan Gyroscope vs Accelerometer');
xlabel('Thoi gian (giay)');
ylabel('Goc Pitch (Do)');
legend('Pitch Gyro (tich phan)', 'Pitch Accel (tham chieu)', 'Location', 'best');
grid on;
hold off;
saveas(f2, 'pitch_gyro.png');