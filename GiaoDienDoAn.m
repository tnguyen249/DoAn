function varargout = GiaoDienDoAn(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GiaoDienDoAn_OpeningFcn, ...
                   'gui_OutputFcn',  @GiaoDienDoAn_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GiaoDienDoAn is made visible.
function GiaoDienDoAn_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.axes1 = imshow('logo.png');
    set(handles.cellSize,'Enable','off');
    set(handles.numNeighbors,'Enable','off');
    set(handles.radius,'Enable','off');
    set(handles.kq,'string','');
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GiaoDienDoAn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GiaoDienDoAn_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
    set(handles.xuly,'string','Du lieu lon nen chuong trinh can thoi gian xu ly khi nhan nut "Nhan dang", vui long cho ket qua!');
    listbox = get(handles.popupmenu1,'Value');
    if listbox == 1
        set(handles.cellSize,'Enable','off');
        set(handles.numNeighbors,'Enable','off');
        set(handles.radius,'Enable','off');
        set(handles.knnSvm,'Enable','on');
    elseif listbox == 2
        set(handles.cellSize,'Enable','on');
        set(handles.numNeighbors,'Enable','off');
        set(handles.radius,'Enable','off');
        set(handles.knnSvm,'Enable','on');
    elseif listbox == 3
        set(handles.cellSize,'Enable','off');
        set(handles.numNeighbors,'Enable','on');
        set(handles.radius,'Enable','on');
        set(handles.knnSvm,'Enable','on');
    elseif listbox == 4
        set(handles.knnSvm,'Enable','off');
        set(handles.cellSize,'Enable','off');
        set(handles.numNeighbors,'Enable','off');
        set(handles.radius,'Enable','off');
    elseif listbox == 5
        set(handles.cellSize,'Enable','off');
        set(handles.numNeighbors,'Enable','off');
        set(handles.radius,'Enable','off');
        set(handles.knnSvm,'Enable','off');
    end
        

function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cellSize.
function cellSize_Callback(hObject, eventdata, handles)
    set(handles.xuly,'string','Du lieu lon nen chuong trinh can thoi gian xu ly khi nhan nut "Nhan dang", vui long cho ket qua!');

function cellSize_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    listbox = get(handles.popupmenu1,'Value');
    if listbox == 1
        if get(handles.knnSvm,'Value')==1
            nImageTrue = raw();
        else
            nImageTrue = rawSvm();
        end
    elseif listbox == 2
        if get(handles.cellSize,'Value') == 1
            if get(handles.knnSvm,'Value')==1
                nImageTrue = hog(2,2);
            else
                nImageTrue = 'Loi! Chon CellSize khac';
            end
        elseif get(handles.cellSize,'Value') == 2
            if get(handles.knnSvm,'Value')==1
                nImageTrue = hog(4,4);
            else
                nImageTrue = hogSvm(4,4);
            end
        elseif get(handles.cellSize,'Value') == 3
            if get(handles.knnSvm,'Value')==1
                nImageTrue = hog(8,8);
            else
                nImageTrue = hogSvm(8,8);
            end
        end
    elseif listbox == 3
        varNei = get(handles.numNeighbors,'Value')+3;
        varRadius = get(handles.radius,'Value');
        if get(handles.knnSvm,'Value') == 1
            nImageTrue = lbp(varNei,varRadius);
        else
            nImageTrue = lbpSvm(varNei,varRadius);
        end
    elseif listbox == 4
        nImageTrue = bow();
    elseif listbox == 5
        nImageTrue = deeplearning();
    end
    if listbox == 4
        set(handles.kq,'string',[num2str(nImageTrue),'%']);
    else
        set(handles.kq,'string',num2str(nImageTrue));
    end
    set(handles.xuly,'string','');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)



function edit1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)

function popupmenu4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)

function popupmenu5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)

function popupmenu6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function numNeighbors_Callback(hObject, eventdata, handles)
    set(handles.xuly,'string','Du lieu lon nen chuong trinh can thoi gian xu ly khi nhan nut "Nhan dang", vui long cho ket qua!');

function numNeighbors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in radius.
function radius_Callback(hObject, eventdata, handles)
    set(handles.xuly,'string','Du lieu lon nen chuong trinh can thoi gian xu ly khi nhan nut "Nhan dang", vui long cho ket qua!');

function radius_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function knnSvm_Callback(hObject, eventdata, handles)
    set(handles.xuly,'string','Du lieu lon nen chuong trinh can thoi gian xu ly khi nhan nut "Nhan dang", vui long cho ket qua!');

function knnSvm_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu2_Callback(hObject, eventdata, handles)

function popupmenu2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
