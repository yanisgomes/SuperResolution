c = RI;

y = super_resolved_image;
Y = fft2(y);
s1 = size(Y);
N = size(Y);

lambda = fft2(c, N(1), N(2));

gmc = lambda .^ -1;

X_hat = gmc.*Y;
img_rec = ifft2(X_hat);
img_rec = reshape(img_rec, s1(1), s1(2));

figure(10);
imagesc(abs(img_rec));
colormap("gray");