data = readmatrix('kethop2boloc.txt');

pitch_acc = data(:, 1);
pitch_comp = data(:, 2);
pitch_kalman = data(:, 3);

f = figure('Position', [100, 100, 900, 500]);

plot(pitch_acc, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold on;
plot(pitch_comp, 'b', 'LineWidth', 1.5);
plot(pitch_kalman, 'r', 'LineWidth', 1.5);

title('So sanh cac phuong phap tinh goc (Accel, Complementary, Kalman)');
xlabel('Mau du lieu');
ylabel('Goc Pitch (Do)');
legend('Goc tho (Accel)', 'Bo loc bu (Complementary)', 'Bo loc Kalman', 'Location', 'best');
grid on;
hold off;

saveas(f, 'dothikethop2boloc.png');