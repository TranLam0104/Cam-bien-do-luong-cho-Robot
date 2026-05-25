Z_up   = [0.07,-0.01,0.96; 0.07,-0.00,0.96; 0.07,-0.01,0.96; 0.07,-0.01,0.96; 0.08,-0.00,0.95; 0.08,-0.00,0.96; 0.08,-0.00,0.95; 0.08,-0.01,0.96; 0.08,-0.01,0.96; 0.07,-0.01,0.96; 0.08,-0.02,0.97; 0.07,0.01,0.95; 0.07,-0.01,0.97; 0.07,-0.01,0.95; 0.07,-0.01,0.97];
Z_down = [0.02,-0.03,-1.09; 0.02,-0.03,-1.10; 0.01,-0.03,-1.09; 0.02,-0.03,-1.09; 0.02,-0.02,-1.07; 0.02,-0.02,-1.09; 0.02,-0.02,-1.09; 0.02,-0.02,-1.09; 0.02,-0.02,-1.08; 0.02,-0.03,-1.09; 0.03,-0.02,-1.09; 0.02,-0.03,-1.09; 0.02,-0.03,-1.09; 0.02,-0.03,-1.10];
X_up   = [1.04,0.00,-0.09; 1.04,0.01,-0.10; 1.04,0.00,-0.09; 1.04,0.00,-0.09; 1.04,-0.00,-0.10; 1.03,-0.00,-0.08; 1.04,0.01,-0.09; 1.05,0.00,-0.09; 1.04,-0.00,-0.09; 1.04,0.00,-0.08; 1.03,-0.00,-0.08; 1.04,0.01,-0.09];
X_down = [-0.97,-0.03,0.07; -0.97,-0.03,0.08; -0.96,-0.03,0.07; -0.97,-0.03,0.07; -0.97,-0.03,0.07; -0.97,-0.03,0.08; -0.96,-0.03,0.08; -0.96,-0.03,0.07; -0.97,-0.03,0.08; -0.97,-0.03,0.08; -0.97,-0.03,0.07; -0.97,-0.02,0.08; -0.96,-0.03,0.07; -0.96,-0.03,0.07];
Y_up   = [0.02,0.99,-0.16; 0.01,0.98,-0.17; 0.01,0.98,-0.16; 0.01,0.98,-0.15; 0.01,0.98,-0.15; 0.01,0.99,-0.14; 0.01,0.99,-0.15; 0.01,0.99,-0.15; 0.01,0.98,-0.15; 0.01,0.99,-0.15; 0.01,0.99,-0.16; 0.02,0.99,-0.15; 0.01,0.98,-0.15; 0.01,0.98,-0.15; 0.01,0.98,-0.14; 0.01,0.98,-0.16; 0.02,0.98,-0.14];
Y_down = [0.06,-1.00,0.01; 0.05,-1.01,0.02; 0.05,-1.00,0.00; 0.05,-1.01,-0.00; 0.05,-1.00,-0.00; 0.04,-1.01,-0.00; 0.05,-1.01,-0.00; 0.05,-1.00,-0.00; 0.05,-1.00,0.00; 0.05,-1.00,0.00];
mean_ax_up = mean(X_up(:,1));      mean_ax_down = mean(X_down(:,1));
mean_ay_up = mean(Y_up(:,2));      mean_ay_down = mean(Y_down(:,2));
mean_az_up = mean(Z_up(:,3));      mean_az_down = mean(Z_down(:,3));
offset_ax = -(mean_ax_up + mean_ax_down) / 2;
offset_ay = -(mean_ay_up + mean_ay_down) / 2;
offset_az = -(mean_az_up + mean_az_down) / 2;

fprintf('--- KET QUA HIEU CHUAN 6 VI TRI (Gia toc ke) ---\n');
fprintf('Offset Ax: %.4f g\n', offset_ax);
fprintf('Offset Ay: %.4f g\n', offset_ay);
fprintf('Offset Az: %.4f g\n', offset_az);
raw_data = [Z_up; Z_down; X_up; X_down; Y_up; Y_down];
calib_ax = raw_data(:,1) + offset_ax;
calib_ay = raw_data(:,2) + offset_ay;
calib_az = raw_data(:,3) + offset_az;
f = figure('Position', [100, 100, 900, 500]);
plot(calib_ax, 'r', 'LineWidth', 1.5); hold on;
plot(calib_ay, 'g', 'LineWidth', 1.5);
plot(calib_az, 'b', 'LineWidth', 1.5);
yline(1, '--k', '+1g', 'LineWidth', 1.2, 'LabelHorizontalAlignment', 'left');
yline(-1, '--k', '-1g', 'LineWidth', 1.2, 'LabelHorizontalAlignment', 'left');
yline(0, '-k', '0g', 'LineWidth', 1);

title('Đac tinh Gia toc ke tai 6 vi tri (Da bu tru Offset)');
xlabel('Mau du lieu (Xoay mach qua 6 huong)');
ylabel('Gia toc (g)');
legend('Ax', 'Ay', 'Az', 'Location', 'northeast');
grid on;
ylim([-1.5 1.5]);
x_ticks = [1, length(Z_up), length(Z_up)+length(Z_down), ...
           length(Z_up)+length(Z_down)+length(X_up), ...
           length(Z_up)+length(Z_down)+length(X_up)+length(X_down), ...
           length(Z_up)+length(Z_down)+length(X_up)+length(X_down)+length(Y_up), length(raw_data)];
xticks(x_ticks);
xticklabels({'Z-Up','Z-Down','X-Up','X-Down','Y-Up','Y-Down','End'});

hold off;
saveas(f, 'DoThi_Phan2_1_6Position.png');