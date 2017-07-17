function nImageTrue = bow( )
    rootFolder = fullfile('DataTrain');
    categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
    tbl01 = countEachLabel(imds);
    minSetCount = min(tbl01{:, 2});
    imds = splitEachLabel(imds, minSetCount, 'randomize');
    tbl02 = countEachLabel(imds);
    if exist('BoW.mat', 'file') == 2 % Kiem tra neu ton tai thi doc len (Giup chuong trinh chay nhanh hon)
        load('BoW.mat');
    else
        bag = bagOfFeatures(imds);
        save('BoW.mat', 'bag');
    end
    img = readimage(imds, 1);
    featureVector = encode(bag, img);
    if exist('BoWClassifier.mat', 'file') == 2
        load('BoWClassifier.mat');
    else
        categoryClassifier = trainImageCategoryClassifier(imds, bag);
        save('BoWClassifier.mat', 'categoryClassifier');
    end
    rootFolder = fullfile('DataTest');
    categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
    tbl01 = countEachLabel(imds);
    if exist('evaluateBoW.mat','file') == 2
        load('evaluateBoW.mat');
    else
        confMatrixTest = evaluate(categoryClassifier, imds);
        save('evaluateBoW.mat','confMatrixTest');
    end
    nImageTrue = mean(diag(confMatrixTest))*100;
end

