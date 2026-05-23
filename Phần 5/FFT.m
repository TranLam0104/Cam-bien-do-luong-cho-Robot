
data = readmatrix('dulieudoxunggiatocshock.txt');
ax = data(:, 1);
ax = ax - mean(ax); 
fs = 200;
N = length(ax);

fc = 15;
[b, a] = butter(2, fc/(fs/2), 'low');
ax_filtered = filtfilt(b, a, ax);
fft_raw = abs(fft(ax)) / N;
fft_raw = fft_raw(1:floor(N/2));
freqs = (0:floor(N/2)-1) * (fs / N);
fft_filtered = abs(fft(ax_filtered)) / N;
fft_filtered = fft_filtered(1:floor(N/2));
[max_amp, max_idx] = max(fft_raw);
dominant_freq = freqs(max_idx);
f = figure('Position', [100, 100, 900, 500]);
plot(freqs, fft_raw, 'Color', [0.7 0.7 0.7], 'LineWidth', 1.2); hold on;
plot(freqs, fft_filtered, 'r', 'LineWidth', 1.5);
plot(dominant_freq, max_amp, 'bo', 'MarkerSize', 8, 'LineWidth', 2);

title('So sanh Pho Tan So FFT: Truoc va Sau Low-Pass Filter');
xlabel('Tan so (Hz)');
ylabel('Bien do (Magnitude)');
legend('Pho FFT tho (Co nhieu)', 'Pho FFT sau khi qua Low-Pass Filter', 'Tan so chu dao (Dominant Freq)');
grid on;
xlim([0 60]);
hold off;
saveas(f, 'DoThi_FFT_LPF_Phan5_2.png');
fprintf('--- KET QUA PHAN TICH FFT ---\n');
fprintf('Tan so chu dao cua dao dong: %.2f Hz\n', dominant_freq);