clc;
clear all;
close all;

%--------READ IMAGES----------
tic;
img1 = imread('C:\CVIT\Practice\Pictures\monalisa1.jpg');
img2 = imread('C:\CVIT\Practice\Pictures\monalisa2.jpg');
[h1, w1, s1] = size(img1);
[h2, w2, s2] = size(img2);
if s1 == 3
    img1 = rgb2gray(img1);
end
img1 = im2single(img1);
% img1 = imresize(img1, 2);
% img2 = imresize(img2, 2);
if s2 == 3
    img2 = rgb2gray(img2);
end
img2 = im2single(img2);


%-------FIND FEATURES----------
[frames, desc] = vl_sift(img1);
numTotal = size(frames);
numTotal = numTotal(2);
[f, d] = vl_sift(img2);
numFeatures = size(f);
numFeatures = numFeatures(2);

[h, w] = size(img1);
[height, width] = size(img2);
i1 = img1;
i2 = img2;
matches = vl_ubcmatch(desc,d);
matchedFeatures = size(matches);
matchedFeatures = matchedFeatures(2);

%-----PLOTTING FEATURES------
for i = 1:numTotal
    a = frames(1,i);
    b = frames(2,i);
    i1 = insertMarker(i1, [a b], 'Color', 'blue');
end
for i = 1:numFeatures
    c = f(1,i);
    d = f(2,i);
    i2 = insertMarker(i2, [c d], 'Color', 'red');
end
figure, imshow(i1);
title('Features of original image');
figure, imshow(i2);
title('Features of object');

%-------VOTING---------
img = img1;
h = 10000;
w = 10000;
bins1 = zeros(h, w);
bins2 = zeros(h, w);
bins3 = zeros(h, w);
bins4 = zeros(h, w);
[h1, w1] = size(bins1);
margin = 5;

r = img1;
s = img1;

for l = 1:matchedFeatures
    i = matches(1,l);
    j = matches(2,l);
    th = (frames(4,i) - f(4,j));
    local1 = [-f(1,j); -f(2,j)];
    local2 = [width - f(1,j); -f(2,j)];
    local3 = [width - f(1,j); height - f(2,j)];
    local4 = [-f(1,j); height - f(2,j)];
    orient = [cos(th) -sin(th);sin(th) cos(th)];
    m2 = frames(3,i);
    m1 = f(3,j);
    m = m2/m1;
    v1 =  m*orient*local1;
    v1 = transpose(v1);
    v1 = [frames(1,i) frames(2,i)] + v1;
    refx1 = v1(1);
    refy1 = v1(2);
    if round(refx1) >= 1 && round(refy1) >= 1 && refx1-margin <= w && refy1-margin <= h
        a1 = round(refx1)-margin;
        a2 = round(refx1)+margin;
        b1 = round(refy1)-margin;
        b2 = round(refy1)+margin;
        if a1 <= 0
            a1 = 1;
        end
        if a2 > w
            a2 = w;
        end
        if b1 <= 0
            b1 = 1;
        end
        if b2 > h
            b2 = h;
        end
        bins1(a1:a2, b1:b2) = bins1(a1:a2, b1:b2) + 1;
    end
    v2 =  m*orient*local2;
    v2 = transpose(v2);
    v2 = [frames(1,i) frames(2,i)] + v2;
    refx2 = v2(1);
    refy2 = v2(2); 
    if round(refx2) >= 1 && round(refy2) >= 1 && refx2-margin <= w && refy2-margin <= h 
        a1 = round(refx2)-margin;
        a2 = round(refx2)+margin;
        b1 = round(refy2)-margin;
        b2 = round(refy2)+margin;
        if a1 <= 0
            a1 = 1;
        end
        if a2 > w
            a2 = w;
        end
        if b1 <= 0
            b1 = 1;
        end
        if b2 > h
            b2 = h;
        end
        bins2(a1:a2, b1:b2) = bins2(a1:a2, b1:b2) + 1;
    end
    v3 =  m*orient*local3;
    v3 = transpose(v3);
    v3 = [frames(1,i) frames(2,i)] + v3;
    refx3 = v3(1);
    refy3 = v3(2);
    if round(refx3) >= 1 && round(refy3) >= 1 && refx3-margin <= w && refy3-margin <= h 
        a1 = round(refx3)-margin;
        a2 = round(refx3)+margin;
        b1 = round(refy3)-margin;
        b2 = round(refy3)+margin;
        if a1 <= 0
            a1 = 1;
        end
        if a2 > w
            a2 = w;
        end
        if b1 <= 0
            b1 = 1;
        end
        if b2 > h
            b2 = h;
        end
        bins3(a1:a2, b1:b2) = bins3(a1:a2, b1:b2) + 1;
    end
    v4 =  m*orient*local4;
    v4 = transpose(v4);
    v4 = [frames(1,i) frames(2,i)] + v4;
    refx4 = v4(1);
    refy4 = v4(2);
    if round(refx4) >= 1 && round(refy4) >= 1 && refx4-margin <= w && refy4-margin <= h 
        a1 = round(refx4)-margin;
        a2 = round(refx4)+margin;
        b1 = round(refy4)-margin;
        b2 = round(refy4)+margin;
        if a1 <= 0
            a1 = 1;
        end
        if a2 > w
            a2 = w;
        end
        if b1 <= 0
            b1 = 1;
        end
        if b2 > h
            b2 = h;
        end
        bins4(a1:a2, b1:b2) = bins4(a1:a2, b1:b2) + 1;
    end
    mark = [refx1 refy1;refx2 refy2;refx3 refy3;refx4 refy4];
    color = {'red','white','green','magenta'};
    img = insertMarker(img,mark,'x','color',color,'size',10);  
end
figure, imshow(img);
title('Voting Points');

%-------REFERENCE POINTS------------
image = img1;
maxval1 = max(bins1(:));
index1 = find(bins1(:) == maxval1);
[i1, j1] = ind2sub(size(bins1), index1);
image = insertMarker(image, [i1 j1], 'color', 'red');
maxval2 = max(bins2(:));
index2 = find(bins2(:) == maxval2);
[i2, j2] = ind2sub(size(bins2), index2);
image = insertMarker(image, [i2 j2], 'color', 'blue');
maxval3 = max(bins3(:));
index3 = find(bins3(:) == maxval3);
[i3, j3] = ind2sub(size(bins3), index3);
image = insertMarker(image, [i3 j3], 'color', 'green');
maxval4 = max(bins4(:));
index4 = find(bins4(:) == maxval4);
[i4, j4] = ind2sub(size(bins4), index4);
image = insertMarker(image, [i4 j4], 'color', 'yellow');
figure, imshow(image);
title('Showing maximum reference points');

meanx1 = mean(i1);
meany1 = mean(j1);
meanx2 = mean(i2);
meany2 = mean(j2);
meanx3 = mean(i3);
meany3 = mean(j3);
meanx4 = mean(i4);
meany4 = mean(j4);

corners = img1;
corners = insertMarker(corners, [meanx1 meany1]);
corners = insertMarker(corners, [meanx2 meany2]);
corners = insertMarker(corners, [meanx3 meany3]);
corners = insertMarker(corners, [meanx4 meany4]);
figure, imshow(corners);
title('Plotted mean corners');

%-----PLOTTING BOUNDARIES---------
yvectors = [meany1 meany2 meany3 meany4];
xvectors = [meanx1 meanx2 meanx3 meanx4];
[dvals, dindex] = sort(yvectors, 'ascend');
a = dindex(1);
b = dindex(2);
if xvectors(a) < xvectors(b)
    topleftx = xvectors(a);
    toplefty = yvectors(a);
    toprightx = xvectors(b);
    toprighty = yvectors(b);
else
    topleftx = xvectors(b);
    toplefty = yvectors(b);
    toprightx = xvectors(a);
    toprighty = yvectors(a);
end
c = dindex(3);
d = dindex(4);
if xvectors(c) < xvectors(d)
    bottomleftx = xvectors(c);
    bottomlefty = yvectors(c);
    bottomrightx = xvectors(d);
    bottomrighty = yvectors(d);
else
    bottomleftx = xvectors(d);
    bottomlefty = yvectors(d);
    bottomrightx = xvectors(c);
    bottomrighty = yvectors(c);
end

figure, imshow(img1);
line([topleftx toprightx], [toplefty toprighty], 'LineWidth',4);
line([topleftx bottomleftx], [toplefty bottomlefty], 'LineWidth', 4);
line([bottomleftx bottomrightx], [bottomlefty bottomrighty], 'LineWidth', 4);
line([bottomrightx toprightx], [bottomrighty toprighty], 'LineWidth', 4);
title('Boundaries plotted');
toc;