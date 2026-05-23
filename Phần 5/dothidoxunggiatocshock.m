data = readmatrix('dulieudoxunggiatocshock.txt');

ax = data(:,1);
ay = data(:,2);
az = data(:,3);

a_mag = sqrt(ax.^2 + ay.^2 + az.^2);

fs = 200; 
dt = 1/fs;
t = (0:length(a_mag)-1) * dt;

quiet_val = mean(a_mag(1:100)); 
upper_bound = quiet_val * 1.05;
lower_bound = quiet_val * 0.95;

[peak_amp, peak_idx] = max(a_mag);

threshold_pulse = quiet_val * 1.1; 
start_idx = find(a_mag > threshold_pulse | a_mag < quiet_val*0.9, 1, 'first');
if isempty(start_idx)
    start_idx = peak_idx; 
end

end_settle_idx = find(a_mag > upper_bound | a_mag < lower_bound, 1, 'last');

settling_time = t(end_settle_idx) - t(start_idx);

f = figure('Position', [100, 100, 900, 500]);
plot(t, a_mag, 'b', 'LineWidth', 1.2); hold on;
yline(quiet_val, '-k', 'LineWidth', 1);
yline(upper_bound, '--r', 'LineWidth', 1.5);
yline(lower_bound, '--r', 'LineWidth', 1.5);
plot(t(peak_idx), peak_amp, 'ro', 'MarkerSize', 8, 'LineWidth', 2);

title('Khao sat dac tinh Shock/Impact (|a| vs time)');
xlabel('Thoi gian (s)');
ylabel('Do lon Gia toc |a| (g)');
legend('|a| thuc te', 'Gia tri tinh (~1g)', 'Nguong +5%', 'Nguong -5%', 'Peak Amplitude');
grid on; hold off;

saveas(f, 'DoThi_Shock_Phan5.png');

fprintf('\n--- KET QUA PHAN TICH SHOCK ---\n');
fprintf('Gia tri yen tinh ban dau: %.3f g\n', quiet_val);
fprintf('1. Peak Amplitude (|a| max): %.3f g\n', peak_amp);
fprintf('2. Thoi gian dập tắt (Settling Time): %.3f s\n', settling_time);