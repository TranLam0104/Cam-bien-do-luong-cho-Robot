data = readmatrix('dulieuaccelerometer.txt');

roll_acc = data(:, 1);
pitch_acc = data(:, 2);

t = (1:length(roll_acc)) * 0.02; 

f = figure('Position', [100, 100, 800, 450]);

plot(t, roll_acc, 'b', 'LineWidth', 1.5); hold on;
plot(t, pitch_acc, 'r', 'LineWidth', 1.5);

title('Hinh 6.1: Goc Roll va Pitch tinh toan tu Accelerometer');
xlabel('Thoi gian (s)');
ylabel('Goc nghieng (Do)');
legend('Goc Roll (Lan quanh truc X)', 'Goc Pitch (Ngang quanh truc Y)', 'Location', 'best');
grid on;
hold off;

saveas(f, 'DoThi_6_1_Accelerometer.png');