rawData = readmatrix('Phan1.1-du-lieu-tho.txt');
validData = rawData(1:500, 1:6);

offset_ax = mean(validData(:, 1));
offset_ay = mean(validData(:, 2));
offset_az = mean(validData(:, 3)) - 16384;
offset_gx = mean(validData(:, 4));
offset_gy = mean(validData(:, 5));
offset_gz = mean(validData(:, 6));

disp('--- GIA TRI OFFSET ---');
fprintf('offset_ax = %d \n', round(offset_ax));
fprintf('offset_ay = %d \n', round(offset_ay));
fprintf('offset_az = %d \n', round(offset_az));
fprintf('offset_gx = %d \n', round(offset_gx));
fprintf('offset_gy = %d \n', round(offset_gy));
fprintf('offset_gz = %d \n', round(offset_gz));