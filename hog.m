function nImageTrue  = hog(m, n)
    lblTest = loadMNISTLabels('t10k-labels.idx1-ubyte');
    if exist(['HOG',num2str(m),num2str(n),'.mat'], 'file') == 2
        load(['HOG',num2str(m),num2str(n),'.mat']);
    else
        imgTrain = loadMNISTImages('train-images.idx3-ubyte');
        lblTrain = loadMNISTLabels('train-labels.idx1-ubyte');
        imgI = imgTrain(:,1);
        img2D = reshape(imgI,28,28);
        [featureVector,hogVisualization] = extractHOGFeatures(img2D,'CellSize',[m m]);
        nBins = size(featureVector,2);
        nNumTrain = size(imgTrain, 2);
        imgTrain_hist = zeros(nBins, nNumTrain);
        for i=1:nNumTrain
            imgI = imgTrain(:,i);
            img2D = reshape(imgI,28,28);
            [featureVector,hogVisualization] = extractHOGFeatures(img2D,'CellSize',[m n]);
            imgTrain_hist(:,i) = featureVector;
        end
        Mdl = fitcknn(imgTrain_hist',lblTrain);
        imgTest = loadMNISTImages('t10k-images.idx3-ubyte');
        nNumTest = size(imgTest,2);
        imgTest_hist = zeros(nBins, nNumTest);
        for i=1:nNumTest
            imgI = imgTest(:,i);
            img2D = reshape(imgI,28,28); 
            imgTest_hist(:,i) = extractHOGFeatures(img2D,'CellSize',[m n]);
        end
        lblResult = predict(Mdl,imgTest_hist');
        save(['HOG',num2str(m),num2str(n),'.mat'],'lblResult');
    end
    nResult = (lblResult == lblTest);
    nImageTrue = sum(nResult);
end

