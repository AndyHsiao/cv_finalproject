close all
clear

image_files = dir( fullfile( 'cover', '*.jpg') );
test_files = dir( fullfile( 'test', '*.jpg') );
num_images = length(image_files);
num_test = length(test_files);
correct = 0;
score = zeros(num_images, 1);

for i = 1 : num_test
    test_img = rgb2gray(imread(fullfile( 'test', test_files(i).name)));
    test_img = imresize(test_img, 0.1);
    [~, d] = vl_sift(single(test_img));
    des1 = double(d');

    for m = 1 : num_images
        image = rgb2gray(imread(fullfile( 'cover', image_files(m).name)));
        [~, d] = vl_sift(single(image));
        des2 = double(d');
        M = SIFTSimpleMatcher(des1, des2, 0.8);
        score(m) = size(M, 1);
    end

    [~, x] = max(score);
    a = image_files(x).name;
    a = a(1:length(a)-4);
    fprintf(['This book is ', a, '\n'])
    if image_files(x).name == test_files(i).name
        correct = correct +1;
    end
end
correct/num_test