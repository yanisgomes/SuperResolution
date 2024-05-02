load Donnees1.mat
load DonneesCor.mat

x_max = 10;
dx = 0.5;
corr_max = 0;
dep = [[]];

im_ref = data(:,:,1);
figure;
imshow(im_ref, []);

%% Estimation des décalages
decalage_x_max = 0.999;  % pixel
decalage_y_max = 0.999;  % pixel
pas = 1/5;  % pixel

for j = 2:15
    dx_max = 0;
    dy_max = 0;
    corr_max = -1;
    for dx = 0:pas:decalage_x_max
        for dy = 0:pas:decalage_y_max
            cible = data(1:end-1, 1:end-1, j);
            corr = Correlation(data(:,:,1), cible, dx, dy);
            if corr > corr_max
                dx_max = dx;
                dy_max = dy;
                corr_max = corr;
            end
        end
    end
    dep(j,:) = [dx_max, dy_max];    
end
dep(1,:)=[0,0];

%% Méthode simpliste
data_augmented = zeros(size(im_ref,1).*(1/pas), size(im_ref,2).*(1/pas), size(data, 3));
final_augmented_image = zeros(size(data_augmented,1));
matrice_ponderation = zeros(size(data_augmented,1));
for n = 1:15
    for i = 1:size(im_ref,1)
        for j = 1:size(im_ref,2)
            x = (i-1)/pas + 1 + dep(n,1)/pas;
            y = (j-1)/pas + 1 + dep(n,2)/pas;
            data_augmented(x,y,n) = data(i,j,n);
            matrice_ponderation(x,y)=matrice_ponderation(x,y)+1;
        end
    end
    final_augmented_image = final_augmented_image + data_augmented(:,:,n);
end
final_augmented_image = final_augmented_image./matrice_ponderation;
figure;

% First subplot
subplot(1, 2, 1); % Divides the figure into 1 row, 2 columns, and selects the first subplot
imshow(im_ref); % Display the first image
title('Image de référence'); % Set title for the first image

% Second subplot
subplot(1, 2, 2); % Selects the second subplot
imshow(final_augmented_image, []);
title('Image sur résolue'); % Set title for the second image

%% Approximation circulante

% On créé une RI à partir d'un matrice ones(3,3) de la taille de l'image
% fina et centrée (pour éviter de décaler l'image lorsqu'on convolue)
N = size(final_augmented_image,1);
RI = zeros(N,N);
RI(1:2,1:2)=1;
RI(N,N)=1;
RI(1:2,N)=1;
RI(N,1:2)=1;
RI = RI.*(1/9); % Pour normaliser

lambda_c = fft2(RI);
lambda_c = lambda_c+0.001;
gmc = 1./lambda_c;
Y = fft2(final_augmented_image);
X_estime = gmc.*Y;
x_estime = ifft2(X_estime);

figure;
imagesc(abs(x_estime));
colormap('gray')

%% Approximation circulante avec régularisation

c = ones(3,3);
N = size(final_augmented_image,1);
mu = 0.001;
d = [2 -1;-1 0];
lambda_d = fft2(d,N,N);
gmc = conj(lambda_c).*((abs(lambda_c).^2 + mu*abs(lambda_d).^2).^-1);
X_hat = gmc.*Y;
image_2 = ifft2(X_hat);

figure;
imagesc(abs(image_2));
colormap('gray');

%% PARTIE 2

%% Sans adoucissement

final_size = size(final_augmented_image);
seuil = 0.5;
seuila = 0;
RI = RI/sum2(RI);
n = size(RI);

% 1. Initialiser x0 à une valeur quelconque zéro par exemple
x0 = zeros(final_size(1),final_size(2));
%figure(10),imagesc(ImaVrai),colormap("gray");
xk = x0;
a = inf;
aprec = 0;
i = 1;
%%
% 2. Calculer T Cxk en convoluant xk par la réponse impulsionnelle à l’aide de la commande conv2.
while (abs(a-aprec) >0.0000000000001)
    aprec = a;
    TCxk = conv2(xk,RI,"same");

    % 3. Calculer la différence ek entre T Cxk et les données y.
    ek = TCxk - image;
    ek(isnan(ek))= 0;
    a = sum2(ek.*ek);
    a-aprec;

    % 4. Calculer CtT t(T Cxk y) en convoluant le résultat de l’étape précédente par la RI retournée.
    CtTtek = conv2(ek,flip2(RI),'same');

    % 5. Calculer D1xk en convoluant xk par le filtre dérivateur (0 1 -1) à l’aide de conv2.
    D1xk = conv2(xk,[0 1 -1],'same');
    D2xk = conv2(xk,[0;1;-1],'same');

    % 7. Calculer à l aide de l’équation (24).
    dD1xk = DerivHuber(D1xk,seuil);
    dD2xk = DerivHuber(D2xk,seuil);

    % 8. Calculer Dt(D1xk) en convoluant (D1xk) par le filtre dérivateur retournée (-1 1 0) .
    DtdD1xk = conv2(dD1xk,[-1 1 0],'same');
    DtdD2xk = conv2(dD2xk,[-1;1;0],'same');

    % 10. Calculer à l’aide de la fonction AlphaOpt.
    mu = 10;
    gk = CtTtek + mu*(DtdD1xk + DtdD2xk);
    alpha = AlphaOptDonneeManquante(gk,gk,xk,image,RI,mu,seuil);

    % 11. Mettre à jour xk en utilisant l’équation (30).
    xk = xk - alpha*(CtTtek + mu*(DtdD1xk + DtdD2xk));

    i = i + 1;
end

figure(i+3),imagesc(xk+1),colormap("gray");










