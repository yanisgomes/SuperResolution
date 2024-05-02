# SuperResolution
I use MATLAB to implement super-resolution techniques by correcting deficiencies in low-resolution images through alignment, overlay, deconvolution, and optimization methods such as regularized least squares.

![low2super](https://github.com/yanisgomes/SuperResolution/assets/115785457/dfaf6e30-244c-4736-aee1-a4389f42c870)

## Estimation of Shifts
In super-resolution, accurately estimating the shifts between different low-resolution images is crucial. This process aligns the images more precisely, enhancing the composite image quality. The estimation is based on maximizing the similarity measure, which in this case, is the correlation insensitivity to intensity variations.

The mathematical representation of the correlation is as follows:
$$
\operatorname{cor}=\frac{\left(\mathbb{E}\left\{I_{m 1}-\mathbb{E}\left\{I_{m 1}\right\}\right\}\right)\left(\mathbb{E}\left\{I_{m 2}-\mathbb{E}\left\{I_{m 2}\right\}\right\}\right)}{\operatorname{std}\left(I_{m 1}\right) \operatorname{std}\left(I_{m 2}\right)}'''
$$

![Super resolved shit & add](https://github.com/yanisgomes/SuperResolution/assets/115785457/5957a30b-6fc2-49d7-8433-7c513be25319)


# Deconvolution

Deconvolution is applied to the aggregated high-resolution image to reverse the blurring effects caused by the imaging sensor's response, thereby refining the final image output.

## Resolution by Circular Approximation

This method simplifies the deconvolution by assuming a circular structure in the convolution matrix, allowing the use of Fast Fourier Transforms (FFT) for efficient computation. The core equation in circular approximation can be described by:

$$
\tilde{\boldsymbol{C}}=\boldsymbol{W}^{\dagger} \boldsymbol{\Lambda}_c \boldsymbol{W}
$$

where $\tilde{\boldsymbol{C}}$ is the circulant matrix approximation of the convolution matrix $C$, and $\boldsymbol{\Lambda}_c$ is a diagonal matrix containing the eigenvalues obtained from the FFT of the convolution kernel.

![superRes3](https://github.com/yanisgomes/SuperResolution/assets/115785457/21341d76-1df7-4c79-a336-4f79835cc24d)

![Moindres carrés](https://github.com/yanisgomes/SuperResolution/assets/115785457/965bff65-b11c-41e0-b3e9-e9301956edff)

## Regularization and Smoothing

To further refine the image quality, regularization techniques are applied to smooth the restored image. This involves penalizing changes between adjacent pixels to reduce noise and artifacts, which is especially crucial when dealing with high-resolution outputs. The regularization term is often expressed as:

$$
\mu \boldsymbol{x}^{\mathrm{t}} \boldsymbol{D}^{\mathrm{t}} \boldsymbol{D} \boldsymbol{x}
$$

where $\mu$ is the regularization parameter, and 𝐷 is a matrix that approximates the first-order difference, which helps in smoothing.

# Least Squares

The least squares method is employed to optimize the fit of the super-resolved image to the observed low-resolution images.

## Gradient Descent
Gradient descent is used to find the optimal parameters that minimize the least squares error function. This iterative method updates parameters in the direction of the steepest descent as defined by the gradient of the error function.


![$\alpha$ = 0.015](https://github.com/yanisgomes/SuperResolution/assets/115785457/6bf07de4-df17-48eb-9578-fd4686bac8f9)

![$\alpha$ = 0.9](https://github.com/yanisgomes/SuperResolution/assets/115785457/ecf73b34-b0fe-4b72-b74d-84f0b5f72cf0)

![$\alpha$ = 1.03](https://github.com/yanisgomes/SuperResolution/assets/115785457/5d792c50-4409-4626-bffc-5d133cf6cceb)

## Correction of Edge Effects
Addressing edge effects is crucial for maintaining the quality across the entire image. This involves adjusting the convolution operations to prevent artifacts at the boundaries of the image, which could otherwise lead to distortions in the final high-resolution output.

![$\alpha$ = 0.015](https://github.com/yanisgomes/SuperResolution/assets/115785457/20b0592c-d834-4db5-8bb0-da878af4911b)

![$\alpha$ = 0.9](https://github.com/yanisgomes/SuperResolution/assets/115785457/939a308b-2ac8-471c-b2ee-bf50fa0edc5e)

![$\alpha$ = 1.03](https://github.com/yanisgomes/SuperResolution/assets/115785457/78f6cb47-a142-46f3-ae5d-c09222a43268)

