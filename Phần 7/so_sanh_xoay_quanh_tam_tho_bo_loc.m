clear; clc; close all;
data_tho    = readmatrix('du_lieu_tho_mpu_xoay_quanh_tam.txt');
data_bo_loc = readmatrix('du_lieu_bo_loc_mpu_xoay_quanh_tam.txt');
tho_total    = data_tho(:, 4);
bo_loc_total = data_bo_loc(:, 4);

N_tho    = length(tho_total);
N_bo_loc = length(bo_loc_total);

fprintf('File tho    : %d mau\n', N_tho);
fprintf('File bo loc : %d mau\n', N_bo_loc);
fprintf('\n--- Thong ke thu 4 (Total Accel) ---\n');
fprintf('Tho    : mean=%.4f  STD=%.4f  max=%.4f  min=%.4f\n', ...
    mean(tho_total), std(tho_total), max(tho_total), min(tho_total));
fprintf('Bo loc : mean=%.4f  STD=%.4f  max=%.4f  min=%.4f\n', ...
    mean(bo_loc_total), std(bo_loc_total), max(bo_loc_total), min(bo_loc_total));
figure(1);
clf;
set(gcf, 'Position', [80 200 1100 620], ...
         'Color',    [0.06 0.06 0.06], ...
         'Name',     'So sanh Tho vs Bo Loc', ...
         'NumberTitle', 'off');
C_tho    = [1.0  0.35 0.35];
C_bo_loc = [0.25 0.85 1.0 ];
C_diff   = [1.0  0.85 0.2 ];
sp1 = subplot(2,1,1);
hold on;

s_tho    = (1:N_tho)';
s_bo_loc = (1:N_bo_loc)';

p1 = plot(s_tho,    tho_total,    'Color', C_tho,    'LineWidth', 1.5);
p2 = plot(s_bo_loc, bo_loc_total, 'Color', C_bo_loc, 'LineWidth', 1.5);
plot(s_tho,    repmat(mean(tho_total),    N_tho,    1), '--', ...
     'Color', [C_tho    0.55], 'LineWidth', 1.1);
plot(s_bo_loc, repmat(mean(bo_loc_total), N_bo_loc, 1), '--', ...
     'Color', [C_bo_loc 0.55], 'LineWidth', 1.1);
N_max = max(N_tho, N_bo_loc);
text(N_max + 2, mean(tho_total),    sprintf('%.4fg', mean(tho_total)),    ...
     'Color', C_tho,    'FontSize', 8, 'FontWeight', 'bold');
text(N_max + 2, mean(bo_loc_total), sprintf('%.4fg', mean(bo_loc_total)), ...
     'Color', C_bo_loc, 'FontSize', 8, 'FontWeight', 'bold');
set(sp1, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], ...
         'GridColor', [0.35 0.35 0.35], 'GridAlpha', 0.5, 'FontSize', 10);
title('Tong gia toc — Tho vs Bo Loc (chong nhau)', ...
      'Color', 'w', 'FontSize', 13, 'FontWeight', 'bold');
xlabel('Mau (Sample)', 'Color', 'w', 'FontSize', 11);
ylabel('|Total Accel| (g)', 'Color', 'w', 'FontSize', 11);
legend([p1 p2], ...
       {sprintf('Tho     mean=%.4fg  STD=%.4fg', mean(tho_total),    std(tho_total)), ...
        sprintf('Bo loc  mean=%.4fg  STD=%.4fg', mean(bo_loc_total), std(bo_loc_total))}, ...
       'TextColor', 'w', 'Color', [0.1 0.1 0.1], ...
       'EdgeColor', [0.5 0.5 0.5], 'Location', 'northeast', 'FontSize', 9);
xlim([1 N_max]);
all_vals = [tho_total; bo_loc_total];
y_pad = (max(all_vals) - min(all_vals)) * 0.15;
ylim([min(all_vals) - y_pad, max(all_vals) + y_pad]);
grid on;
hold off;
sp2 = subplot(2,1,2);
hold on;

if N_tho == N_bo_loc
    diff_val = tho_total - bo_loc_total;
    pd = plot(1:N_tho, diff_val, 'Color', C_diff, 'LineWidth', 1.4);
    fill([1; N_tho; N_tho; 1], ...
         [0.05; 0.05; -0.05; -0.05], [0 0.4 0], ...
         'EdgeColor', 'none', 'FaceAlpha', 0.15);

    yline(0, '-', 'Color', [1 1 1 0.3], 'LineWidth', 1);
    text(N_tho + 2, mean(diff_val), sprintf('%.4fg', mean(diff_val)), ...
         'Color', C_diff, 'FontSize', 8, 'FontWeight', 'bold');

    set(sp2, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], ...
             'GridColor', [0.35 0.35 0.35], 'GridAlpha', 0.5, 'FontSize', 10);
    title('Hieu: Tho − Bo Loc  (phan trong luc bi loai)', ...
          'Color', 'w', 'FontSize', 13, 'FontWeight', 'bold');
    xlabel('Mau (Sample)',     'Color', 'w', 'FontSize', 11);
    ylabel('Delta (g)',        'Color', 'w', 'FontSize', 11);
    legend(pd, {sprintf('Tho − Bo loc  mean=%.4fg  STD=%.4fg', ...
                mean(diff_val), std(diff_val))}, ...
           'TextColor', 'w', 'Color', [0.1 0.1 0.1], ...
           'EdgeColor', [0.5 0.5 0.5], 'Location', 'northeast', 'FontSize', 9);
    xlim([1 N_tho]);
    d_pad = max(abs(diff_val)) * 1.2;
    if d_pad < 0.05, d_pad = 0.05; end
    ylim([-d_pad d_pad]);
    grid on;

else
    edges = linspace(min([tho_total; bo_loc_total]), ...
                     max([tho_total; bo_loc_total]), 40);
    histogram(tho_total,    edges, 'FaceColor', C_tho,    'FaceAlpha', 0.6, ...
              'EdgeColor', 'none');
    histogram(bo_loc_total, edges, 'FaceColor', C_bo_loc, 'FaceAlpha', 0.6, ...
              'EdgeColor', 'none');

    set(sp2, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], ...
             'GridColor', [0.35 0.35 0.35], 'GridAlpha', 0.5, 'FontSize', 10);
    title(sprintf('Phan phoi Total Accel  (so mau khac nhau: %d vs %d)', ...
          N_tho, N_bo_loc), ...
          'Color', 'w', 'FontSize', 13, 'FontWeight', 'bold');
    xlabel('Total Accel (g)', 'Color', 'w', 'FontSize', 11);
    ylabel('So lan xuat hien', 'Color', 'w', 'FontSize', 11);
    legend({'Tho', 'Bo loc'}, 'TextColor', 'w', 'Color', [0.1 0.1 0.1], ...
           'EdgeColor', [0.5 0.5 0.5], 'Location', 'northeast', 'FontSize', 9);
    grid on;
end

hold off;
out_file = 'SoSanh_Tho_BoLoc_XoayQuanhTam.png';
exportgraphics(gcf, out_file, 'Resolution', 150, ...
               'BackgroundColor', [0.06 0.06 0.06]);
fprintf('\nDa luu: %s\n', out_file);