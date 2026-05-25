clear; clc; close all;
Z_up = [
    0.07,-0.01, 0.96; 0.07,-0.00, 0.96; 0.07,-0.01, 0.96;
    0.07,-0.01, 0.96; 0.08,-0.00, 0.95; 0.08,-0.00, 0.96;
    0.08,-0.00, 0.95; 0.08,-0.01, 0.96; 0.08,-0.01, 0.96;
    0.07,-0.01, 0.96; 0.08,-0.02, 0.97; 0.07, 0.01, 0.95;
    0.07,-0.01, 0.97; 0.07,-0.01, 0.95; 0.07,-0.01, 0.97];

Z_down = [
    0.02,-0.03,-1.09; 0.02,-0.03,-1.10; 0.01,-0.03,-1.09;
    0.02,-0.03,-1.09; 0.02,-0.02,-1.07; 0.02,-0.02,-1.09;
    0.02,-0.02,-1.09; 0.02,-0.02,-1.09; 0.02,-0.02,-1.08;
    0.02,-0.03,-1.09; 0.03,-0.02,-1.09; 0.02,-0.03,-1.09;
    0.02,-0.03,-1.09; 0.02,-0.03,-1.10];

X_up = [
    1.04, 0.00,-0.09; 1.04, 0.01,-0.10; 1.04, 0.00,-0.09;
    1.04, 0.00,-0.09; 1.04,-0.00,-0.10; 1.03,-0.00,-0.08;
    1.04, 0.01,-0.09; 1.05, 0.00,-0.09; 1.04,-0.00,-0.09;
    1.04, 0.00,-0.08; 1.03,-0.00,-0.08; 1.04, 0.01,-0.09];

X_down = [
   -0.97,-0.03, 0.07;-0.97,-0.03, 0.08;-0.96,-0.03, 0.07;
   -0.97,-0.03, 0.07;-0.97,-0.03, 0.07;-0.97,-0.03, 0.08;
   -0.96,-0.03, 0.08;-0.96,-0.03, 0.07;-0.97,-0.03, 0.08;
   -0.97,-0.03, 0.08;-0.97,-0.03, 0.07;-0.97,-0.02, 0.08;
   -0.96,-0.03, 0.07;-0.96,-0.03, 0.07];

Y_up = [
    0.02, 0.99,-0.16; 0.01, 0.98,-0.17; 0.01, 0.98,-0.16;
    0.01, 0.98,-0.15; 0.01, 0.98,-0.15; 0.01, 0.99,-0.14;
    0.01, 0.99,-0.15; 0.01, 0.99,-0.15; 0.01, 0.98,-0.15;
    0.01, 0.99,-0.15; 0.01, 0.99,-0.16; 0.02, 0.99,-0.15;
    0.01, 0.98,-0.15; 0.01, 0.98,-0.15; 0.01, 0.98,-0.14;
    0.01, 0.98,-0.16; 0.02, 0.98,-0.14];

Y_down = [
    0.06,-1.00, 0.01; 0.05,-1.01, 0.02; 0.05,-1.00, 0.00;
    0.05,-1.01,-0.00; 0.05,-1.00,-0.00; 0.04,-1.01,-0.00;
    0.05,-1.01,-0.00; 0.05,-1.00,-0.00; 0.05,-1.00, 0.00;
    0.05,-1.00, 0.00];
mean_ax_up   = mean(X_up(:,1));   mean_ax_down = mean(X_down(:,1));
mean_ay_up   = mean(Y_up(:,2));   mean_ay_down = mean(Y_down(:,2));
mean_az_up   = mean(Z_up(:,3));   mean_az_down = mean(Z_down(:,3));

offset_ax = -(mean_ax_up + mean_ax_down) / 2;
offset_ay = -(mean_ay_up + mean_ay_down) / 2;
offset_az = -(mean_az_up + mean_az_down) / 2;
fprintf('════════════════════════════════════════════\n');
fprintf('  HIỆU CHỈNH ACCELEROMETER — 6 VỊ TRÍ\n');
fprintf('════════════════════════════════════════════\n');
fprintf('  Trục  │ Mean Up   │ Mean Down │ Offset (g)\n');
fprintf('  ──────┼───────────┼───────────┼───────────\n');
fprintf('  X     │ %+.4f   │ %+.4f   │ %+.4f\n', mean_ax_up, mean_ax_down, offset_ax);
fprintf('  Y     │ %+.4f   │ %+.4f   │ %+.4f\n', mean_ay_up, mean_ay_down, offset_ay);
fprintf('  Z     │ %+.4f   │ %+.4f   │ %+.4f\n', mean_az_up, mean_az_down, offset_az);
fprintf('════════════════════════════════════════════\n');
fprintf('\n  NHUNG VAO ARDUINO (Raw LSB, scale 16384):\n');
fprintf('  int16_t offset_ax = %d;\n', round(offset_ax * 16384));
fprintf('  int16_t offset_ay = %d;\n', round(offset_ay * 16384));
fprintf('  int16_t offset_az = %d;\n', round(offset_az * 16384));
fprintf('════════════════════════════════════════════\n\n');
raw_all = [Z_up; Z_down; X_up; X_down; Y_up; Y_down];
cal_ax  = raw_all(:,1) + offset_ax;
cal_ay  = raw_all(:,2) + offset_ay;
cal_az  = raw_all(:,3) + offset_az;
mag = sqrt(cal_ax.^2 + cal_ay.^2 + cal_az.^2);
n = [length(Z_up), length(Z_down), length(X_up), ...
     length(X_down), length(Y_up), length(Y_down)];
bounds = cumsum(n);
mids   = [bounds(1)/2, bounds(1)+n(2)/2, bounds(2)+n(3)/2, ...
          bounds(3)+n(4)/2, bounds(4)+n(5)/2, bounds(5)+n(6)/2];
labels = {'Z↑','Z↓','X↑','X↓','Y↑','Y↓'};
N      = size(raw_all, 1);

f = figure('Position', [80, 80, 1100, 620], 'Color', 'white');
ax1 = subplot(2,1,1);
hold on;
plot(cal_ax, 'r',  'LineWidth', 1.4, 'DisplayName', 'Ax');
plot(cal_ay, 'Color',[0.1 0.7 0.1], 'LineWidth', 1.4, 'DisplayName', 'Ay');
plot(cal_az, 'b',  'LineWidth', 1.4, 'DisplayName', 'Az');
yline( 1, '--k', '+1g', 'LineWidth', 1.2, 'LabelHorizontalAlignment','left','FontSize',9);
yline(-1, '--k', '-1g', 'LineWidth', 1.2, 'LabelHorizontalAlignment','left','FontSize',9);
yline( 0, '-k',  'LineWidth', 0.8, 'Alpha', 0.4);
for b = bounds(1:end-1)
    xline(b+0.5, '--', 'Color', [0.65 0.65 0.65], 'LineWidth', 1);
end
xlim([1 N]); ylim([-1.4 1.4]);
xticks(mids); xticklabels(labels);
title('Gia toc ke (Accelerometer) tai 6 vi tri — sau hieu chinh offset', ...
      'FontSize', 12, 'FontWeight', 'bold');
ylabel('Gia toc (g)', 'FontSize', 11);
legend('Location','northeast','FontSize',10);
grid on; hold off;
ax2 = subplot(2,1,2);
hold on;
plot(mag, 'Color',[0.6 0 0.8], 'LineWidth', 1.6, 'DisplayName', '|a| = \surdAx²+Ay²+Az²');
yline(1.0, '--k', '1.0 g (ly tuong)', 'LineWidth', 1.5, ...
      'LabelHorizontalAlignment','left','FontSize',9);
yline(1.03, ':r', '+3%', 'LineWidth', 1, 'LabelHorizontalAlignment','right','FontSize',8);
yline(0.97, ':r', '-3%', 'LineWidth', 1, 'LabelHorizontalAlignment','right','FontSize',8);
for b = bounds(1:end-1)
    xline(b+0.5, '--', 'Color', [0.65 0.65 0.65], 'LineWidth', 1);
end
xlim([1 N]); ylim([0.90 1.10]);
xticks(mids); xticklabels(labels);
title('Kiem tra tong vector: \surd(Ax^2 + Ay^2 + Az^2) phai xap xi 1g', ...
      'FontSize', 12, 'FontWeight', 'bold');
ylabel('|a| (g)', 'FontSize', 11);
xlabel('Vi tri do (6 huong)', 'FontSize', 11);
legend('Location','northeast','FontSize',10);
grid on; hold off;

sgtitle('HIEU CHINH ACCELEROMETER — PHUONG PHAP 6 VI TRI', ...
        'FontSize', 14, 'FontWeight', 'bold');

saveas(f, 'DoThi_Phan2_1_6Position.png');

fprintf('Da luu: DoThi_Phan2_1_6Position.png\n');