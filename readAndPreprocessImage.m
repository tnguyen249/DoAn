function Img = readAndPreprocessImage(filename)
    I = imread(filename);
    if ismatrix(I)
        I = cat(3,I,I,I);
    end
    Img = imresize(I, [227 227]);
end