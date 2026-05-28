clear; clc; close all;
data_nghieng = readmatrix('du_lieu_bo_loc_mpu_nam_nghieng.txt');
data_ngua    = readmatrix('du_lieu_bo_loc_mpu_nam_ngua.txt');

fprintf('Nghieng (bo loc): %d dong\n', size(data_nghieng,1));
fprintf('Ngua    (bo loc): %d dong\n', size(data_ngua,1));
datasets  = {data_nghieng,                    data_ngua};
names     = {'Nam Nghieng (Bo Loc)',           'Nam Ngua (Bo Loc)'};
files_out = {'DoThi_BoLoc_Nghieng.png',       'DoThi_BoLoc_Ngua.png'};
positions = [50  430 950 430;
             520 430 950 430];

C_solid = {[1 0.2 0.2], [0.2 0.8 1], [0.2 1 0.3]};
C_dash  = {[1 0.2 0.2 0.5], [0.2 0.8 1 0.5], [0.2 1 0.3 0.5]};
for d = 1:2
    raw      = datasets{d};
    lin_ax = raw(:,1);
    lin_ay = raw(:,2);
    lin_az = raw(:,3);
    N      = length(lin_ax);
    samples = (1:N)';

    mean_ax = mean(lin_ax); std_ax = std(lin_ax);
    mean_ay = mean(lin_ay); std_ay = std(lin_ay);
    mean_az = mean(lin_az); std_az = std(lin_az);

    fprintf('\n════════════════════════════════════════\n');
    fprintf('  FILE: %s  (%d mau)\n', names{d}, N);
    fprintf('════════════════════════════════════════\n');
    fprintf('  lin_ax: mean=%+.4f  STD=%.4f\n', mean_ax, std_ax);
    fprintf('  lin_ay: mean=%+.4f  STD=%.4f\n', mean_ay, std_ay);
    fprintf('  lin_az: mean=%+.4f  STD=%.4f\n', mean_az, std_az);
    fprintf('════════════════════════════════════════\n');

    figure(d);
    clf;
    set(gcf, 'Position',    positions(d,:), ...
             'Color',       [0.06 0.06 0.06], ...
             'Name',        names{d}, ...
             'NumberTitle', 'off');

    sp = axes;
    hold on;
    fill([1;N;N;1],[ 0.05; 0.05;-0.05;-0.05], [0 0.4 0], ...
         'EdgeColor','none','FaceAlpha',0.15);
    p1 = plot(samples, lin_ax, 'Color', C_solid{1}, 'LineWidth', 1.4);
    p2 = plot(samples, lin_ay, 'Color', C_solid{2}, 'LineWidth', 1.4);
    p3 = plot(samples, lin_az, 'Color', C_solid{3}, 'LineWidth', 1.4);
    plot(samples, repmat(mean_ax, N, 1), '--', 'Color', C_dash{1}, 'LineWidth', 1.2);
    plot(samples, repmat(mean_ay, N, 1), '--', 'Color', C_dash{2}, 'LineWidth', 1.2);
    plot(samples, repmat(mean_az, N, 1), '--', 'Color', C_dash{3}, 'LineWidth', 1.2);
    yline(0, '-', 'Color', [1 1 1 0.3], 'LineWidth', 1);
    text(N+2, mean_ax, sprintf('%+.4fg', mean_ax), ...
         'Color', C_solid{1}, 'FontSize', 8, 'FontWeight', 'bold');
    text(N+2, mean_ay, sprintf('%+.4fg', mean_ay), ...
         'Color', C_solid{2}, 'FontSize', 8, 'FontWeight', 'bold');
    text(N+2, mean_az, sprintf('%+.4fg', mean_az), ...
         'Color', C_solid{3}, 'FontSize', 8, 'FontWeight', 'bold');
    set(sp, 'Color',     [0 0 0], ...
            'XColor',    [1 1 1], ...
            'YColor',    [1 1 1], ...
            'GridColor', [0.35 0.35 0.35], ...
            'GridAlpha', 0.5, ...
            'FontSize',  10);

    title(sprintf('Gia toc tuyen tinh (Bo loc) — %s', names{d}), ...
          'Color', 'w', 'FontSize', 13, 'FontWeight', 'bold');
    xlabel('Mau (Sample)',           'Color', 'w', 'FontSize', 11);
    ylabel('Gia toc tuyen tinh (g)', 'Color', 'w', 'FontSize', 11);

    legend([p1 p2 p3], ...
           {sprintf('lin\\_ax  mean=%+.4f g', mean_ax), ...
            sprintf('lin\\_ay  mean=%+.4f g', mean_ay), ...
            sprintf('lin\\_az  mean=%+.4f g', mean_az)}, ...
           'TextColor', 'w', 'Color', [0.1 0.1 0.1], ...
           'EdgeColor', [0.5 0.5 0.5], ...
           'Location',  'northeast', 'FontSize', 9);

    xlim([1 N]);
    all_vals = [lin_ax; lin_ay; lin_az];
    y_range  = max(abs(all_vals)) * 1.3;
    if y_range < 0.1, y_range = 0.1; end
    ylim([-y_range y_range]);

    grid on;
    hold off;

    exportgraphics(gcf, files_out{d}, 'Resolution', 150, ...
                   'BackgroundColor', [0.06 0.06 0.06]);
    fprintf('Da luu: %s\n', files_out{d});
end

fprintf('\nHoan thanh! Da xuat 2 file PNG.\n');