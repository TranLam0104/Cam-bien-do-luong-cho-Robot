clear; clc; close all;

%% ── ĐỌC 3 FILE ──────────────────────────────────────────
data_nghieng = readmatrix('du_lieu_tho_mpu_nghieng.txt');
data_ngua    = readmatrix('du_lieu_tho_mpu_ngua.txt');
data_sap     = readmatrix('du_lieu_tho_mpu_sap.txt');

fprintf('Nghieng: %d dong\n', size(data_nghieng,1));
fprintf('Ngua:    %d dong\n', size(data_ngua,1));
fprintf('Sap:     %d dong\n', size(data_sap,1));

datasets  = {data_nghieng,       data_ngua,       data_sap};
names     = {'Nghieng',          'Ngua',           'Sap'};
files_out = {'DoThi_Nghieng.png','DoThi_Ngua.png','DoThi_Sap.png'};
positions = [50  430 950 430;
             520 430 950 430;
             285  0  950 430];

C_solid = {[1 0.2 0.2], [0.2 0.8 1], [0.2 1 0.3]};
C_dash  = {[1 0.2 0.2 0.5], [0.2 0.8 1 0.5], [0.2 1 0.3 0.5]};

%% ── VẼ 3 FIGURE RIÊNG BIỆT ──────────────────────────────
for d = 1:3
    raw     = datasets{d};
    ax_data = raw(:,1);
    ay_data = raw(:,2);
    az_data = raw(:,3);
    N       = length(ax_data);
    samples = (1:N)';

    mean_ax = mean(ax_data); std_ax = std(ax_data);
    mean_ay = mean(ay_data); std_ay = std(ay_data);
    mean_az = mean(az_data); std_az = std(az_data);

    fprintf('\n════════════════════════════════════\n');
    fprintf('  FILE: %s  (%d mau)\n', names{d}, N);
    fprintf('════════════════════════════════════\n');
    fprintf('  Ax: mean=%+.4f  STD=%.4f\n', mean_ax, std_ax);
    fprintf('  Ay: mean=%+.4f  STD=%.4f\n', mean_ay, std_ay);
    fprintf('  Az: mean=%+.4f  STD=%.4f\n', mean_az, std_az);
    fprintf('════════════════════════════════════\n');

    figure(d);
    clf;
    set(gcf, 'Position',    positions(d,:), ...
             'Color',       [0.06 0.06 0.06], ...
             'Name',        names{d}, ...
             'NumberTitle', 'off');

    sp = axes;
    hold on;

    % Vùng nền ±3% quanh 0g và ±1g
    fill([1;N;N;1],[ 0.03; 0.03;-0.03;-0.03],[0 0.4 0],'EdgeColor','none','FaceAlpha',0.15);
    fill([1;N;N;1],[ 1.03; 1.03; 0.97; 0.97],[0 0.4 0],'EdgeColor','none','FaceAlpha',0.12);
    fill([1;N;N;1],[-0.97;-0.97;-1.03;-1.03],[0 0.4 0],'EdgeColor','none','FaceAlpha',0.12);

    % Đường dữ liệu
    p1 = plot(samples, ax_data, 'Color', C_solid{1}, 'LineWidth', 1.4);
    p2 = plot(samples, ay_data, 'Color', C_solid{2}, 'LineWidth', 1.4);
    p3 = plot(samples, az_data, 'Color', C_solid{3}, 'LineWidth', 1.4);

    % Đường mean nét đứt (dùng 4 giá trị RGBA thay vì 'Alpha')
    plot(samples, repmat(mean_ax,N,1), '--', 'Color', C_dash{1}, 'LineWidth', 1.2);
    plot(samples, repmat(mean_ay,N,1), '--', 'Color', C_dash{2}, 'LineWidth', 1.2);
    plot(samples, repmat(mean_az,N,1), '--', 'Color', C_dash{3}, 'LineWidth', 1.2);

    % Đường tham chiếu
    yline( 1, '-', 'Color',[1 1 1 0.25], 'LineWidth', 1);
    yline( 0, '-', 'Color',[1 1 1 0.25], 'LineWidth', 1);
    yline(-1, '-', 'Color',[1 1 1 0.25], 'LineWidth', 1);

    % Nhãn mean bên phải
    text(N+2, mean_ax, sprintf('%+.3fg', mean_ax), 'Color',C_solid{1},'FontSize',8,'FontWeight','bold');
    text(N+2, mean_ay, sprintf('%+.3fg', mean_ay), 'Color',C_solid{2},'FontSize',8,'FontWeight','bold');
    text(N+2, mean_az, sprintf('%+.3fg', mean_az), 'Color',C_solid{3},'FontSize',8,'FontWeight','bold');

    % Dark theme
    set(sp, 'Color',     [0 0 0], ...
            'XColor',    [1 1 1], ...
            'YColor',    [1 1 1], ...
            'GridColor', [0.35 0.35 0.35], ...
            'GridAlpha', 0.5, ...
            'FontSize',  10);

    title(sprintf('Accelerometer — %s', names{d}), ...
          'Color','w','FontSize',13,'FontWeight','bold');
    xlabel('Mau (Sample)', 'Color','w','FontSize',11);
    ylabel('Gia toc (g)',  'Color','w','FontSize',11);
    legend([p1 p2 p3], ...
           {sprintf('Ax  mean=%+.4f g', mean_ax), ...
            sprintf('Ay  mean=%+.4f g', mean_ay), ...
            sprintf('Az  mean=%+.4f g', mean_az)}, ...
           'TextColor','w','Color',[0.1 0.1 0.1], ...
           'EdgeColor',[0.5 0.5 0.5],'Location','northeast','FontSize',9);
    xlim([1 N]);
    ylim([-1.5 1.5]);
    grid on;
    hold off;

    exportgraphics(gcf, files_out{d}, 'Resolution', 150, ...
                   'BackgroundColor', [0.06 0.06 0.06]);
    fprintf('Da luu: %s\n', files_out{d});
end