data = readmatrix('bolocbu.txt');

pitch_acc = data(:, 1);
pitch_05 = data(:, 2);
pitch_08 = data(:, 3);
pitch_098 = data(:, 4);

f = figure('Position', [100, 100, 900, 500]);

plot(pitch_acc, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold on;
plot(pitch_05, 'g', 'LineWidth', 1.5);
plot(pitch_08, 'b', 'LineWidth', 1.5);
plot(pitch_098, 'r', 'LineWidth', 2);

title('Khao sat trong so Alpha trong Bo loc bu');
xlabel('Mau du lieu');
ylabel('Goc Pitch (Do)');
legend('Accel Tho (Nhieu)', '\alpha = 0.5 (Con nhieu nhieu)', '\alpha = 0.8', '\alpha = 0.98 (Muot nhat)', 'Location', 'best');
grid on;
hold off;

saveas(f, 'dothikhaosatbolocbu.png');