load Donnees1;
load superResx5.mat

% Initialize the image to restore
x = ones(size(super_resolved_image, 1), size(super_resolved_image, 2));
y = super_resolved_image;

T = ones(size(super_resolved_image, 1), size(super_resolved_image, 2));
C = ones(size(super_resolved_image, 1), size(super_resolved_image, 2));

% Initialize the threshold
threshold = 0.5;

% Initialize the opt step
alpha = 0.9; % 0.015 ; 1.03

% MU to avoid edge effects
mu = 0.5;

RI = RI/sum2(RI);

% While the norm of the gradient is greater than the threshold
for iter = 1:100
    % Calculer Cx^(k) en concoluant x^(k) par la RI
    H = conv2(x, RI, 'same');
    
    % Calcul de l'erreur
%     size(H)
%     y_trunc = y(3:503, 3:503);
%     size(y_trunc)
%     e = H - y_trunc;

    e = H-y;
    
    % On tronque le résultat
    e(isnan(e)) = 0;

    g = conv2(e, RI, 'same');
    
    % Calcul du pas optimal
    norm_g = norm(g);
    alpha_opt = AlphaOptDonneeManquante(g, g, x, y, RI, 0, threshold);
    
    x = x - alpha*g;

    figure(2);
    imshow(x, []);
    drawnow;
    title('Restored Image');
end
