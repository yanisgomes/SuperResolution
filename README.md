# SuperResolution
The GitHub repository for this project contains code and documentation for implementing super-resolution techniques using MATLAB, focusing on enhancing image quality by correcting deficiencies in low-resolution images through alignment, overlay, deconvolution, and optimization methods such as least squares and regularized least squares.

# Introduction
Dans ce TP nous nous intéresseronsà la reconstruction d’une image sur-résolue c’est-à-dire avec une résolution supérieur à celle du détecteur à partir de n images basse résolution. Ce problème entre dans la classe des problèmes inverses qui peuvent se poser lors de l’utilisation de systèmes de mesure réels. Le but de la sur-résolution est d’inverser le repliement présent dans les images basse résolution.

![low_res_img]()

# Super-Resolution x3

This repository contains MATLAB code and documentation for a super-resolution project aimed at enhancing image resolution beyond the capabilities of traditional detectors. The project applies various techniques to improve detail and sharpness by processing multiple low-resolution images.

## Estimation of Shifts

In super-resolution, accurately estimating the shifts between different low-resolution images is crucial. This process aligns the images more precisely, enhancing the composite image quality. The estimation is based on maximizing the similarity measure, which in this case, is the correlation insensitivity to intensity variations.

The mathematical representation of the correlation is as follows:
$$
\operatorname{cor}=\frac{\left(\mathbb{E}\left\{I_{m 1}-\mathbb{E}\left\{I_{m 1}\right\}\right\}\right)\left(\mathbb{E}\left\{I_{m 2}-\mathbb{E}\left\{I_{m 2}\right\}\right\}\right)}{\operatorname{std}\left(I_{m 1}\right) \operatorname{std}\left(I_{m 2}\right)}'''
$$

![shift super res x5]()

# Deconvolution

Deconvolution is applied to the aggregated high-resolution image to reverse the blurring effects caused by the imaging sensor's response, thereby refining the final image output.

## Resolution by Circular Approximation

This method simplifies the deconvolution by assuming a circular structure in the convolution matrix, allowing the use of Fast Fourier Transforms (FFT) for efficient computation. The core equation in circular approximation can be described by:

$$
\tilde{\boldsymbol{C}}=\boldsymbol{W}^{\dagger} \boldsymbol{\Lambda}_c \boldsymbol{W}
$$

where $\tilde{\boldsymbol{C}}$ is the circulant matrix approximation of the convolution matrix $C$, and $\boldsymbol{\Lambda}_c$ is a diagonal matrix containing the eigenvalues obtained from the FFT of the convolution kernel.

![super res yo]()

![noir et quadrillé]()

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

![alpha 1]()

![alpha 2]()

![alpha 3]()

## Correction of Edge Effects
Addressing edge effects is crucial for maintaining the quality across the entire image. This involves adjusting the convolution operations to prevent artifacts at the boundaries of the image, which could otherwise lead to distortions in the final high-resolution output.

![alpha2 1]()

![alpha2 2]()

![alpha2 3]()