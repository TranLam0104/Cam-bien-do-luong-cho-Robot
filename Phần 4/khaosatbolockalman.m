data = readmatrix('bolockalman.txt');

pitch_acc_raw = data(:, 1);
pitch_kalman = data(:, 2);

f = figure('Position', [100, 100, 800, 400]);

plot(pitch_acc_raw, 'Color', [0.8 0.8 0.8], 'LineWidth', 1); hold on;
plot(pitch_kalman, 'r', 'LineWidth', 1.5);

title('So sanh Goc Pitch tho (Accel) va sau khi qua boloc Kalman');
xlabel('Mau du lieu');
ylabel('Goc Pitch (Do)');
legend('Goc Tho tu Accel (Nhieu cao)', 'Goc sau khi loc Kalman', 'Location', 'best');
grid on;
hold off;

saveas(f, 'Dothikhaosatbolockalman.png');