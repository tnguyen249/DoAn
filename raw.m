function nImgTrue = raw( )
    lblTestLabelsAll = loadMNISTLabels('t10k-labels.idx1-ubyte');
    if exist('RAWKNN.mat', 'file') == 2
        load('RAWKNN.mat');
    else
        imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
        lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
        Md1 = fitcknn(imgTrainImagesAll', lblTrainLabelsAll);
        imgTestImagesAll = loadMNISTImages('t10k-images.idx3-ubyte');
        lblResult = predict(Md1,imgTestImagesAll');
        save('RAWKNN.mat','lblResult');
    end
    nResult = (lblResult == lblTestLabelsAll);
    nImgTrue = sum(nResult);
end

