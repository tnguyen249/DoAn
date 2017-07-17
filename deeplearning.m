function nImgTrue = deeplearning( )
    net = alexnet()
    featureLayer = 'fc7';
    if exist('DataTrainAlexnet.mat','file') == 2
        load('DataTrainAlexnet.mat');
    else
        strFolderDataTrain = fullfile('DataTrain');   
        categories = {'0', '1', '2','3','4','5','6','7','8','9'};
        imdsDataTrain = imageDatastore(fullfile(strFolderDataTrain, categories), 'LabelSource', 'foldernames');
        imdsDataTrain.ReadFcn = @(filename)readAndPreprocessImage(filename);
        featuresDataTrain = activations(net, imdsDataTrain, featureLayer,'MiniBatchSize', 32, 'OutputAs', 'columns');
        lblDataTrain = imdsDataTrain.Labels;    
        save('DataTrainAlexnet.mat','featuresDataTrain','lblDataTrain');
    end
    if exist('ClassifierAlexnet.mat','file') == 2
        load('ClassifierAlexnet.mat');
    else
        classifier = fitcecoc(featuresDataTrain, lblDataTrain,'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
        save('ClassifierAlexnet.mat','classifier');
    end
    if exist('DataTestAlexnet.mat','file') == 2
        load('DataTestAlexnet.mat');
    else
        strFolderDataTest = fullfile('DataTest');   
        categories = {'0', '1', '2','3','4','5','6','7','8','9'};
        imdsDataTest = imageDatastore(fullfile(strFolderDataTest, categories), 'LabelSource', 'foldernames');
        imdsDataTest.ReadFcn = @(filename)readAndPreprocessImage(filename);
        featuresDataTest = activations(net, imdsDataTest, featureLayer, 'MiniBatchSize',32);
        lblActualDataTest = imdsDataTest.Labels;
        lblResult = predict(classifier, featuresDataTest);
        save('DataTestAlexnet.mat','featuresDataTest','lblActualDataTest','lblResult'); % Luu lai de dung cho ham DeepLearning_ThucThi
    end
    nResult = (lblActualDataTest == lblResult);
    nImgTrue = sum(nResult);
end
