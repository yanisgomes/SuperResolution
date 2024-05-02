% Initialize the super-resolved image and the weight image
im_ref = data(:,:,1);
super_resolved_images = zeros(size(data, 1).*5, size(data, 2).*5, 15);
weight_image = zeros(size(data, 1).*5, size(data, 2).*5);

% For each image
for n = 1:size(data, 3)
    for i = 1:size(data, 1)
        for j = 1:size(data, 2)
            x =1 + (i-1)/pas + tab_decalages(n, 1)/pas;
            y =1 + (j-1)/pas + tab_decalages(n, 2)/pas;
            % Create a super-resolved image using the previously used shift step
            super_resolved_images(x,y,n) = data(i,j,n);
            % Generate a weight image that is the same size as the super-resolved image. 
            % Increment this weight image each time a data is added to the super-resolved image
            weight_image(x,y) = weight_image(x,y) + 1;
        end
    end
end

% Divide term by term the obtained image by the weight image
super_resolved_image = sum(super_resolved_images, 3) ./ weight_image;
save('superResx5.mat', 'super_resolved_image');

% Display the reference image and the super-resolved image side by side
figure;
subplot(1, 2, 1);
imshow(im_ref, []);
title('Reference Image');
subplot(1, 2, 2);
imshow(super_resolved_image, []);
title('Super-Resolved Image');