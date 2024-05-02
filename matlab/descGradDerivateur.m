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

% Normalisation de la réponse impulsionnelle
RI = RI/sum2(RI);

iterations = [1, 20, 50, 100];
figure;
sub = 1;
for iter = iterations
    for k = 1:iter
        % Calculer Cx^(k) en concoluant x^(k) par la RI
        H = conv2(x, RI, 'valid');

        % Calcul de l'erreur
        size(H)
        y_trunc = y(3:503, 3:503);
        size(y_trunc)
        e = H - y_trunc;
%         e = H-y;
        
        % On tronque le résultat
        e(isnan(e)) = 0;
        
        % Convolution
        g = conv2(e, RI, 'full');
        
        % Descente de gradient avec un pas fixe
        x = x - alpha*g;
  
    end
    subplot(1, 4, sub);
    imshow(x, []);
    title(['Itérations = ', num2str(iter)]);
    sub = sub + 1;
end


