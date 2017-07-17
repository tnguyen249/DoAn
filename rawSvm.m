function nImgTrue = rawSvm( )
   lblTestLabelsAll = loadMNISTLabels('t10k-labels.idx1-ubyte');
    if exist('RAWSVM.mat', 'file') == 2
        load('RAWSVM.mat');
    else
        imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
        lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
        Md1 = fitcecoc(imgTrainImagesAll', lblTrainLabelsAll);
        imgTestImagesAll = loadMNISTImages('t10k-images.idx3-ubyte');
        lblResult = predict(Md1,imgTestImagesAll');
        save('RAWSVM.mat','lblResult');
    end
    nResult = (lblResult == lblTestLabelsAll);
    nImgTrue = sum(nResult);
end
