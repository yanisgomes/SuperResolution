c = RI;
% 
% mu = 0.1;
% d = [2 -1;-1 0]
% 
% y = super_resolved_image;
% Y = fft2(y);
% N = size(Y);
% 
% lambda = fft2(c, N(1), N(2));
% lambda2 = fft2(d,N(1),N(2));
% gmc = conj(lambda2).*((abs(lambda).^2 + mu*abs(lambda2).^2).^-1);
% 
% X_hat = gmc.*Y;
% img_rec = ifft2(X_hat);
% img_rec = reshape(img_rec, s1(1), s1(2));
% 
% figure(10);
% imagesc(abs(img_rec));
% colormap("gray");

mu_values = [10, 20, 40];
d = [2 -1;-1 0];
y = super_resolved_image;

Y = fft2(y);
N = size(Y);
lambda = fft2(c, N(1), N(2));
lambda2 = fft2(d,N(1),N(2));

figure;
imagesc(y);
colormap("gray");

figure;

for i = 1:length(mu_values)
    mu = mu_values(i);
    gmc = conj(lambda)./((abs(lambda).^2 + mu*abs(lambda2).^2));
    X_hat = gmc.*Y;
    img_rec = ifft2(X_hat);
    img_rec = reshape(img_rec, N(1), N(2));
    
    % Display the reconstructed image
    
    subplot(1, 3, i);
    imshow(img_rec, []);
    title(['Reconstructed image for mu = ', num2str(mu)]);
end