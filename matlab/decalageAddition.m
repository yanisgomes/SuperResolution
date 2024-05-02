clear all;
load Donnees1;

decalage_x_max = 0.999;  % pixel    
decalage_y_max = 0.999;  % pixel
pas = 1/5;  % pixel

tab_decalages = [[]];

for j = 2:15
    j_max = 2;
    dx_max = 0;
    dy_max = 0; 
    corr_max = -1;
    for dx = 0:pas:decalage_x_max
        for dy = 0:pas:decalage_y_max
            cible = data(1:end-1, 1:end-1, j);
            corr = Correlation(data(:,:,1), cible, dx, dy);
            if corr > corr_max
                j_max = j;
                dx_max = dx;
                dy_max = dy;
                corr_max = corr;
            end
        end
    end
    tab_decalages(j,:) = [dx_max, dy_max, corr_max];
end

tab_decalages
save('tab_decalages.mat', "tab_decalages");