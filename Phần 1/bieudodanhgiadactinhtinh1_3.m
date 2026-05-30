axes_labels = {'Ax', 'Ay', 'Az', 'Gx', 'Gy', 'Gz'};

bias  = [0.1184, 0.0038, -0.0446, -3.7663, -1.1575, -1.5600];
noise = [0.0036, 0.0033,  0.0065,  0.1064,  0.1660,  0.1011];

accel_idx = 1:3;
gyro_idx  = 4:6;
save_dir = 'C:\cảm biến và đo lường cho robot\Phần 1';
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end
fig1 = figure('Name','Bias','NumberTitle','off','Position',[100 100 900 400]);

subplot(1,2,1);
bar(accel_idx, bias(accel_idx), 0.5, 'FaceColor',[0.2 0.5 0.8], 'EdgeColor','k');
set(gca, 'XTick', accel_idx, 'XTickLabel', axes_labels(accel_idx));
xlabel('Trục'); ylabel('Bias (g)');
title('Zero-offset Bias — Accelerometer');
yline(0,'k--','LineWidth',1.2);
grid on;
for i = accel_idx
    val = bias(i);
    offset = 0.005 * sign(val);
    if val == 0, offset = 0.005; end
    text(i, val + offset, sprintf('%.4f', val), ...
        'HorizontalAlignment','center','FontSize',9,'FontWeight','bold');
end

subplot(1,2,2);
bar(1:3, bias(gyro_idx), 0.5, 'FaceColor',[0.9 0.4 0.3], 'EdgeColor','k');
set(gca, 'XTick', 1:3, 'XTickLabel', axes_labels(gyro_idx));
xlabel('Trục'); ylabel('Bias (°/s)');
title('Zero-offset Bias — Gyroscope');
yline(0,'k--','LineWidth',1.2);
grid on;
for i = 1:3
    val = bias(gyro_idx(i));
    offset = 0.1 * sign(val);
    if val == 0, offset = 0.1; end
    text(i, val + offset, sprintf('%.4f', val), ...
        'HorizontalAlignment','center','FontSize',9,'FontWeight','bold');
end

exportgraphics(fig1, fullfile(save_dir, 'bias_chart.png'), 'Resolution', 300);
fprintf('Đã lưu: bias_chart.png\n');
fig2 = figure('Name','Noise STD','NumberTitle','off','Position',[100 550 900 400]);

subplot(1,2,1);
bar(accel_idx, noise(accel_idx), 0.5, 'FaceColor',[0.3 0.75 0.5], 'EdgeColor','k');
set(gca, 'XTick', accel_idx, 'XTickLabel', axes_labels(accel_idx));
xlabel('Trục'); ylabel('STD (g)');
title('Noise STD — Accelerometer');
grid on;
for i = accel_idx
    text(i, noise(i) + 0.0003, sprintf('%.4f', noise(i)), ...
        'HorizontalAlignment','center','FontSize',9,'FontWeight','bold');
end

subplot(1,2,2);
bar(1:3, noise(gyro_idx), 0.5, 'FaceColor',[0.85 0.65 0.1], 'EdgeColor','k');
set(gca, 'XTick', 1:3, 'XTickLabel', axes_labels(gyro_idx));
xlabel('Trục'); ylabel('STD (°/s)');
title('Noise STD — Gyroscope');
grid on;
for i = 1:3
    text(i, noise(gyro_idx(i)) + 0.005, sprintf('%.4f', noise(gyro_idx(i))), ...
        'HorizontalAlignment','center','FontSize',9,'FontWeight','bold');
end

exportgraphics(fig2, fullfile(save_dir, 'noise_std_chart.png'), 'Resolution', 300);
fprintf('Đã lưu: noise_std_chart.png\n');

fprintf('\nXong! Ảnh lưu trong thư mục: %s\n', save_dir);