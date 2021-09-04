img = imread("rock.png");
figure;
hFig = imshow(img);
%% 
% 

info = imfinfo("rock.png");
disp(['image width:' num2str(info.Width) '; image height:' num2str(info.Height) '; color depth:' num2str(info.BitDepth)]);
%%
class(img)
size(img)
%%
tmpImg=uint8(zeros(size(img)));
tmpImg(:,:,1)=img(:,:,1)
figure; imshow(tmpImg); % display the red channel

tmpImg=uint8(zeros(size(img)));
tmpImg(:,:,2)=img(:,:,2)
figure; imshow(tmpImg); % display the green channel

tmpImg=uint8(zeros(size(img)));
tmpImg(:,:,3)=img(:,:,3)
figure; imshow(tmpImg); % display the blue channel
%%
imgGray=rgb2gray(img);
imshow(imgGray);
%% 
% frequency space

imgFFT=fft2(imgGray);
imagesc(abs(fftshift(imgFFT))); colormap gray; axis equal; axis off;
%%
imagesc(abs(fftshift(imgFFT))); colormap turbo; axis equal; axis off;
%% 
% frequency space in log scale

imgFFTb=abs(fftshift(imgFFT));
imagesc(log(abs(fftshift(imgFFT))+1)); colormap gray; axis equal; axis off;
%% 
% spatial-frequency view

[LoD,HiD] = wfilters('haar', 'd');
[cA,cH,cV,cD] = dwt2(imgGray,LoD,HiD,'mode','symh');
figure;
subplot(2,2,1); imagesc(cA); colormap gray; title('Approximation')
subplot(2,2,2); imagesc(cH); colormap gray; title('Horizontal')
subplot(2,2,3); imagesc(cV); colormap gray; title('Vertical')
subplot(2,2,4); imagesc(cD); colormap gray; title('Diagonal')
%% 
% Edge Features

figure;
imagesc(edge(imgGray, 'sobel', 0.04)); colormap gray; axis equal; axis off;
%%
figure;
imagesc(edge(imgGray, 'sobel', 0.1)); colormap gray; axis equal; axis off;
%%
imagesc(uint8(double(imgGray)+255*double(edge(imgGray, 'sobel', 0.04)))); colormap gray; axis equal; axis off;
%% 
% Image Histogram

imhist(img);
%%
imhist(imgGray);