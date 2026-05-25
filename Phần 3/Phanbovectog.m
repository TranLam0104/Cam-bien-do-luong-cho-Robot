angles = [0, 15, 30, 45, 60, 90];
Ax_lt = sind(angles);
Ay_lt = zeros(1, length(angles));
Az_lt = cosd(angles);
Ax_do = [ 0.065,  0.262,  0.507,  0.700, 0.867,  1.009];
Ay_do = [ 0.009,  0.001,  0.006,  0.008, 0.013,  0.006];
Az_do = [ 1.021,  0.990,  0.888,  0.742,  0.531,  0.034];
f = figure('Position', [80, 80, 1100, 420], 'Color', 'white');

ax_labels = {'Ax (g)', 'Ay (g)', 'Az (g)'};
lt_data   = {Ax_lt, Ay_lt, Az_lt};
do_data   = {Ax_do, Ay_do, Az_do};
colors    = {[0.1 0.4 0.9], [0.1 0.7 0.3], [0.85 0.3 0.1]};
titles    = {'Trục X — Ax', 'Trục Y — Ay', 'Trục Z — Az'};

for i = 1:3
    subplot(1, 3, i);
    plot(angles, lt_data{i}, '-', 'Color', colors{i}, ...
         'LineWidth', 2, 'Marker', 'o', 'MarkerFaceColor', colors{i}, 'MarkerSize', 7);
    hold on;
    plot(angles, do_data{i}, '--', 'Color', colors{i} * 0.6, ...
         'LineWidth', 1.8, 'Marker', 'x', 'MarkerSize', 9, 'LineWidth', 2);
    for k = 1:length(angles)
        plot([angles(k) angles(k)], [lt_data{i}(k) do_data{i}(k)], ...
             ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
    end

    title(titles{i}, 'FontSize', 11, 'FontWeight', 'bold');
    xlabel('Góc nghiêng (°)', 'FontSize', 10);
    ylabel(ax_labels{i}, 'FontSize', 10);
    legend('Lý thuyết', 'Thực tế', 'Location', 'best', 'FontSize', 9);
    xticks(angles);
    grid on;
    xlim([-5 95]);
    hold off;
end
sgtitle('Phân Bố Vector Gia Tốc Trọng Trường — Lý Thuyết vs Thực Tế', ...
        'FontSize', 13, 'FontWeight', 'bold');

saveas(f, 'DoThi_PhanBo_VectorG_Phan3_1.png');
fprintf('\n════════════════════════════════════════════════════════════════════════════\n');
fprintf('  BẢNG KẾT QUẢ ĐO ĐẠC VÀ SAI SỐ\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf('%-8s  %-12s  %-12s  %-10s  %-12s  %-12s  %-10s  %-12s  %-12s  %-10s\n', ...
        'Góc(°)', ...
        'Ax LT', 'Ax TT', 'ΔAx(%)', ...
        'Ay LT', 'Ay TT', 'ΔAy(%)', ...
        'Az LT', 'Az TT', 'ΔAz(%)');
fprintf('%s\n', repmat('-', 1, 100));

for i = 1:length(angles)
    err_x = abs(Ax_do(i) - Ax_lt(i)) * 100;
    err_y = abs(Ay_do(i) - Ay_lt(i)) * 100;
    err_z = abs(Az_do(i) - Az_lt(i)) * 100;
    fprintf('%-8d  %-12.3f  %-12.3f  %-10.2f  %-12.3f  %-12.3f  %-10.2f  %-12.3f  %-12.3f  %-10.2f\n', ...
            angles(i), ...
            Ax_lt(i), Ax_do(i), err_x, ...
            Ay_lt(i), Ay_do(i), err_y, ...
            Az_lt(i), Az_do(i), err_z);
end

fprintf('%s\n', repmat('-', 1, 100));
fprintf('\n  KIỂM TRA TỔNG VECTOR: sqrt(Ax² + Ay² + Az²) phải ≈ 1.0 g\n');
fprintf('  %-8s  %-20s  %-8s\n', 'Góc(°)', 'sqrt(Ax²+Ay²+Az²)', 'Lệch(%)');
fprintf('  %s\n', repmat('-', 1, 42));
for i = 1:length(angles)
    mag = sqrt(Ax_do(i)^2 + Ay_do(i)^2 + Az_do(i)^2);
    fprintf('  %-8d  %-20.4f  %-8.2f\n', angles(i), mag, abs(mag - 1.0) * 100);
end
fprintf('  %s\n', repmat('=', 1, 42));
fprintf('Da luu: DoThi_PhanBo_VectorG_Phan3_1.png\n');