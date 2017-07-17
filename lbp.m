function nImgTrue = lbp(m,n)
    lblTest = loadMNISTLabels('t10k-labels.idx1-ubyte');
    if exist(['LBP',num2str(m),num2str(n),'.mat'], 'file') == 2
        load(['LBP',num2str(m),num2str(n),'.mat']);
    else
        imgTrain = loadMNISTImages('train-images.idx3-ubyte');
        lblTrain = loadMNISTLabels('train-labels.idx1-ubyte');
        imgI = imgTrain(:,1);
        img2D = reshape(imgI,28,28);
        featureVector = extractLBPFeatures(img2D,'NumNeighbors',m,'Radius',n);
        nSize = length(featureVector);
        nNumTrain = size(imgTrain, 2);
        featuresDataTrain = zeros(nSize, nNumTrain);
        for i=1:nNumTrain
            imgI = imgTrain(:,i);
            img2D = reshape(imgI,28,28);
            featuresDataTrain(:,i) = extractLBPFeatures(img2D,'NumNeighbors',m,'Radius',n);
        end
        Mdl = fitcknn(featuresDataTrain',lblTrain);
        imgTest = loadMNISTImages('t10k-images.idx3-ubyte');
        nNumTest = size(imgTest,2);
        featuresDataTest = zeros(nSize, nNumTest);
        for i=1:nNumTest
            imgI = imgTest(:,i);
            img2D = reshape(imgI,28,28);
            featuresDataTest(:,i) = extractLBPFeatures(img2D,'NumNeighbors',m,'Radius',n);
        end
        lblResult = predict(Mdl,featuresDataTest');
        save(['LBP',num2str(m),num2str(n),'.mat'],'lblResult');
    end
    nResult = (lblResult == lblTest);
    nImgTrue = sum(nResult);
end
