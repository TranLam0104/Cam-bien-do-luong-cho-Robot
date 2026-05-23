angles = [0, 15, 30, 45, 60, 90];
Ax_ly_thuyet = sind(angles);
Ax_do_duoc = [0.065, 0.262, 0.507, 0.700, 0.867, 1.009]; 
f = figure('Position', [100, 100, 800, 500]);
plot(angles, Ax_ly_thuyet, '-b', 'LineWidth', 2, 'Marker', 'o'); hold on;
plot(angles, Ax_do_duoc, '--r', 'LineWidth', 2, 'Marker', 'x');

title('So sanh Phan bo vector Gia toc (Ax) - Ly thuyet va Thuc te');
xlabel('Goc nghieng (Do)');
ylabel('Gia toc truc X (g)');
legend('Ax Ly thuyet', 'Ax Do dac (Trung binh 200 mau)', 'Location', 'northwest');
grid on;
xticks(angles);
hold off;

saveas(f, 'DoThi_PhanBo_VectorG_Phan3_1.png');
fprintf('\n--- BẢNG KẾT QUẢ ĐO ĐẠC VÀ SAI SỐ (THEO THANG ĐO 1g) ---\n');
fprintf('Góc (Độ)\tAx Lý thuyết\tAx Đo được\tSai số (%%)\n');
fprintf('------------------------------------------------------\n');
for i = 1:length(angles)
    sai_so = abs(Ax_do_duoc(i) - Ax_ly_thuyet(i)) / 1.0 * 100;
    fprintf('%d\t\t%.3f\t\t%.3f\t\t%.2f %%\n', angles(i), Ax_ly_thuyet(i), Ax_do_duoc(i), sai_so);
end
fprintf('------------------------------------------------------\n');