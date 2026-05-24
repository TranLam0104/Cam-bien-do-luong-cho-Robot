data = readmatrix('dulieubolocbu6.3.txt');

roll = data(:, 1);
pitch = data(:, 2);
yaw = data(:, 3);

t = (1:length(roll)) * 0.02; % 50Hz (20ms)

f = figure('Position', [100, 100, 900, 500]);

plot(t, roll, 'b', 'LineWidth', 1.5); hold on;
plot(t, pitch, 'g', 'LineWidth', 1.5);
plot(t, yaw, 'r', 'LineWidth', 1.5);

% Các đường tham chiếu tiêu chuẩn (Eke)
yline(0, '--k', '0 Do');
yline(30, '--k', '30 Do');
yline(45, '--k', '45 Do');
yline(90, '--k', '90 Do');

title('Hinh 6.3: Đanh gia do chinh xac 3 Goc Euler (Roll, Pitch, Yaw) trong khong gian 3D');
xlabel('Thoi gian (s)');
ylabel('Goc (Do)');
legend('Roll (Lan)', 'Pitch (Ngang)', 'Yaw (Xoay)', 'Location', 'northwest');
grid on;
hold off;

saveas(f, 'DoThi_6_3_NghiemThu_3D.png');