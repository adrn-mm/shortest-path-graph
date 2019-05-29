function varargout = shortest_path_tree(varargin)
% SHORTEST_PATH_TREE MATLAB code for shortest_path_tree.fig
%      SHORTEST_PATH_TREE, by itself, creates a new SHORTEST_PATH_TREE or raises the existing
%      singleton*.
%
%      H = SHORTEST_PATH_TREE returns the handle to a new SHORTEST_PATH_TREE or the handle to
%      the existing singleton*.
%
%      SHORTEST_PATH_TREE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHORTEST_PATH_TREE.M with the given input arguments.
%
%      SHORTEST_PATH_TREE('Property','Value',...) creates a new SHORTEST_PATH_TREE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shortest_path_tree_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shortest_path_tree_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shortest_path_tree

% Last Modified by GUIDE v2.5 29-May-2019 05:50:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shortest_path_tree_OpeningFcn, ...
                   'gui_OutputFcn',  @shortest_path_tree_OutputFcn, ...
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


% --- Executes just before shortest_path_tree is made visible.
function shortest_path_tree_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shortest_path_tree (see VARARGIN)

% Choose default command line output for shortest_path_tree
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% GUI always in center
movegui(gcf, 'center')

% Clear variables
evalin('base', 'clear variables');

% Clear command window
evalin('base', 'clc');

% Default Panels
set(handles.panel1, 'visible', 'off');
set(handles.panel2, 'visible', 'off');
set(handles.panel3, 'visible', 'off');
set(handles.panel4, 'visible', 'off');
set(handles.panel5, 'visible', 'off');

% Default static texts
set(handles.stTitle, 'string', '');
set(handles.stJarak, 'string', '');
set(handles.stRute, 'string', '');
set(handles.stTitikAwal, 'visible', 'off');
set(handles.stTitikAkhir, 'visible', 'off');

% Default popup menu
set(handles.pmTitikAwal, 'visible', 'off');
set(handles.pmTitikAkhir, 'visible', 'off');

% Dafault axGraph
set(handles.axGraph, 'visible', 'off');
cla(handles.axGraph);

% UIWAIT makes shortest_path_tree wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shortest_path_tree_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnLoad.
function btnLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Default setup
evalin('base', 'clear variables');
set(handles.pmTitikAwal, 'visible', 'off');
set(handles.pmTitikAkhir, 'visible', 'off');
set(handles.stTitikAwal, 'visible', 'off');
set(handles.stTitikAkhir, 'visible', 'off');
set(handles.axGraph, 'visible', 'off');
cla(handles.axGraph);
set(handles.stJarak, 'string', '');
set(handles.stRute, 'string', '');
set(handles.stTitle, 'string', '');
set(handles.panel1, 'visible', 'off');
set(handles.panel2, 'visible', 'off');
set(handles.panel3, 'visible', 'off');
set(handles.panel4, 'visible', 'off');
set(handles.panel5, 'visible', 'off');
set(handles.pmLayout, 'value', 1);
% Load the file
filename = uigetfile({'*.mat'});
% to handle error when user click cancel
if filename == 0
    return;
end
command = sprintf('load(''%s'')', filename);
evalin('base', command);
assignin('base', 'filename', filename);
% Check is variables exist
e = evalin('base', 'who');
if ismember('names', e) && ismember('s',e) && ismember('t',e) && ismember('weight',e) && ismember('title',e)
    % turn on the popup menus and static texts
    set(handles.pmTitikAwal, 'visible', 'on');
    set(handles.pmTitikAkhir, 'visible', 'on');
    set(handles.stTitikAwal, 'visible', 'on');
    set(handles.stTitikAkhir, 'visible', 'on');
    % turn on the axGraph
    set(handles.axGraph, 'visible', 'on');
    % Assign the variables
    s = evalin('base', 's');
    t = evalin('base', 't');
    weight = evalin('base', 'weight');
    names = evalin('base', 'names');
    title = evalin('base', 'title'); 
    % Assign value of D
    D = digraph(s,t,weight,names);
    assignin('base', 'D', D);
    % Put values to Titik Awal popup menu
    set(handles.pmTitikAwal, 'string', names);
    % Put values to Titik Akhir popup menu
    set(handles.pmTitikAkhir, 'string', names);
    % put value to stTitle
    set(handles.stTitle, 'string', title);
    % Assign the axGraph
    axes(handles.axGraph); % switch current axes to axGraph
    p = plot(D, 'EdgeLabel', D.Edges.Weight);
else
    msgbox('Please choose the correct file', 'Error', 'error');
    evalin('base', 'clear variables');
    set(handles.pmTitikAwal, 'visible', 'off');
    set(handles.pmTitikAkhir, 'visible', 'off');
    cla(handles.axGraph);
end

% --- Executes on selection change in pmTitikAwal.
function pmTitikAwal_Callback(hObject, eventdata, handles)
% hObject    handle to pmTitikAwal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmTitikAwal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmTitikAwal


% --- Executes during object creation, after setting all properties.
function pmTitikAwal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmTitikAwal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pmTitikAkhir.
function pmTitikAkhir_Callback(hObject, eventdata, handles)
% hObject    handle to pmTitikAkhir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmTitikAkhir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmTitikAkhir


% --- Executes during object creation, after setting all properties.
function pmTitikAkhir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmTitikAkhir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnProses.
function btnProses_Callback(hObject, eventdata, handles)
% hObject    handle to btnProses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Default setup on the selected item on popup menus
evalin('base', 'clear selectedItemTitikAwal');
evalin('base', 'clear selectedItemTitikAkhir');
set(handles.stJarak, 'string', '');
set(handles.stRute, 'string', '');
% get stTitle
title = get(handles.stTitle, 'string');
% error saat filename == 0
if isempty(title)
    evalin('base', 'clear selectedItemTitikAwal');
    evalin('base', 'clear selectedItemTitikAkhir');
    set(handles.stJarak, 'string', '');
    set(handles.stRute, 'string', '');
    msgbox('Graph file is not exist', 'Error', 'error');
else
   % Selected Item Titik Awal
    allItemsTitikAwal = handles.pmTitikAwal.String; % a cell array of all strings in the popup menu
    selectedIndexTitikAwal = handles.pmTitikAwal.Value; % an integer saying which item has been selected
    selectedItemTitikAwal = allItemsTitikAwal{selectedIndexTitikAwal}; % the one, single string which was selected
    % Selected Item Titik Akhir
    allItemsTitikAkhir = handles.pmTitikAkhir.String; % a cell array of all strings in the popup menu
    selectedIndexTitikAkhir = handles.pmTitikAkhir.Value; % an integer saying which item has been selected
    selectedItemTitikAkhir = allItemsTitikAkhir{selectedIndexTitikAkhir}; % the one, single string which was selected
    % load variable
    D = evalin('base', 'D');
    % Calculate the shortest path
    [shortPath, shortLength] = shortestpath(D, selectedItemTitikAwal, selectedItemTitikAkhir);
    shortLength = num2str(shortLength);
    set(handles.stJarak, 'string', shortLength);
    set(handles.stRute, 'string', shortPath);
    % Higlight the path
    cla(handles.axGraph);
    % check if variable layout exist or not
    e = evalin('base', 'who');
    if ismember('layout', e)
        layout = evalin('base', 'layout');
        p = plot(D, 'EdgeLabel', D.Edges.Weight, 'layout', layout);
        highlight(p, shortPath, 'EdgeColor', 'r','LineWidth', 1.75, 'NodeColor', 'r', 'MarkerSize', 7, 'NodeFontWeight', 'bold')
    else
        p = plot(D, 'EdgeLabel', D.Edges.Weight);
        highlight(p, shortPath, 'EdgeColor', 'r','LineWidth', 1.75, 'NodeColor', 'r', 'MarkerSize', 7, 'NodeFontWeight', 'bold')
    end
end

% --- Executes during object creation, after setting all properties.
function axITS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axITS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow('ITS.png');
% Hint: place code in OpeningFcn to populate axITS

% --- Executes during object creation, after setting all properties.
function axMathITS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axMathITS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow('mathITS.png');
% Hint: place code in OpeningFcn to populate axMathITS


% --- Executes on button press in btnCreate.
function btnCreate_Callback(hObject, eventdata, handles)
% hObject    handle to btnCreate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Default setup
evalin('base', 'clear variables');
set(handles.pmTitikAwal, 'visible', 'off');
set(handles.pmTitikAkhir, 'visible', 'off');
set(handles.stTitikAwal, 'visible', 'off');
set(handles.stTitikAkhir, 'visible', 'off');
set(handles.axGraph, 'visible', 'off');
cla(handles.axGraph);
set(handles.stJarak, 'string', '');
set(handles.stRute, 'string', '');
set(handles.stTitle, 'string', '');
set(handles.etFilename, 'string', '');
set(handles.etTitle, 'string', '');
set(handles.etNodeNames, 'string', '');
set(handles.etWeight, 'string', '');
set(handles.panel2, 'visible', 'off');
set(handles.panel3, 'visible', 'off');
set(handles.panel4, 'visible', 'off');
set(handles.panel5, 'visible', 'off');
% Activate Panel 1
set(handles.panel1, 'visible', 'on');


function etFilename_Callback(hObject, eventdata, handles)
% hObject    handle to etFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etFilename as text
%        str2double(get(hObject,'String')) returns contents of etFilename as a double


% --- Executes during object creation, after setting all properties.
function etFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function etTitle_Callback(hObject, eventdata, handles)
% hObject    handle to etTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etTitle as text
%        str2double(get(hObject,'String')) returns contents of etTitle as a double


% --- Executes during object creation, after setting all properties.
function etTitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnToStep2.
function btnToStep2_Callback(hObject, eventdata, handles)
% hObject    handle to btnToStep2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% error saat input msh kosong
filename = get(handles.etFilename, 'string');
filename = filename(find(~isspace(filename)));
title = get(handles.etTitle, 'string');
if isempty(filename) || isempty(title)
    msgbox('Input cannot be empty', 'Error', 'error');
else
    % Save the filename and title to the workplace
    assignin('base', 'filename', filename);
    assignin('base', 'title', title);
    % change the panel
    set(handles.panel1, 'visible', 'off');
    set(handles.panel2, 'visible', 'on');
end

% --- Executes on button press in btnCancel1.
function btnCancel1_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Default Setup
evalin('base', 'clear variables');
set(handles.panel1, 'visible', 'off');
set(handles.panel2, 'visible', 'off');
set(handles.panel3, 'visible', 'off');


function etWeight_Callback(hObject, eventdata, handles)
% hObject    handle to etWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etWeight as text
%        str2double(get(hObject,'String')) returns contents of etWeight as a double


% --- Executes during object creation, after setting all properties.
function etWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDone.
function btnDone_Callback(hObject, eventdata, handles)
% hObject    handle to btnDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% check if the variable s is exist or not in workspace
e = evalin('base', 'who');
if ismember('s', e)
    % input all the important variables
    s = evalin('base', 's');
    t = evalin('base', 't');
    names = evalin('base', 'names');
    weight = evalin('base', 'weight');
    filename = evalin('base', 'filename');
    title = evalin('base', 'title');
    % clear all umimportant variables
    evalin('base', 'clear indexNames');
    evalin('base', 'clear indexNodesPair');
    % turn on the popup menus and static texts
    set(handles.pmTitikAwal, 'visible', 'on');
    set(handles.pmTitikAkhir, 'visible', 'on');
    set(handles.stTitikAwal, 'visible', 'on');
    set(handles.stTitikAkhir, 'visible', 'on');
    % turn on the axGraph
    set(handles.axGraph, 'visible', 'on');
    % Assign value of D
    D = digraph(s,t,weight,names);
    assignin('base', 'D', D);
    % save the file
    save(filename, 's', 't', 'weight', 'names', 'title', 'D');
    % Put values to Titik Awal popup menu
    set(handles.pmTitikAwal, 'string', names);
    % Put values to Titik Akhir popup menu
    set(handles.pmTitikAkhir, 'string', names);
    % put value to stTitle
    set(handles.stTitle, 'string', title);
    % Assign the axGraph
    axes(handles.axGraph); % switch current axes to axGraph
    p = plot(D, 'EdgeLabel', D.Edges.Weight);
    % close the panel
    set(handles.panel3, 'visible', 'off');
else
    msgbox('Input cannot be empty', 'Error', 'error');
end

% --- Executes on button press in btnCancel3.
function btnCancel3_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base', 'clear variables');
set(handles.panel1, 'visible', 'off');
set(handles.panel2, 'visible', 'off');
set(handles.panel3, 'visible', 'off');

% --- Executes on button press in btnInputNodePair.
function btnInputNodePair_Callback(hObject, eventdata, handles)
% hObject    handle to btnInputNodePair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Selected Index Node1
allItemsNode1 = handles.pmNode1.String; % a cell array of all strings in the popup menu
selectedIndexNode1 = handles.pmNode1.Value; % an integer saying which item has been selected
% Selected Index Node2
allItemsNode2 = handles.pmNode2.String; % a cell array of all strings in the popup menu
selectedIndexNode2 = handles.pmNode2.Value; % an integer saying which item has been selected
% value of weight
weightNode = get(handles.etWeight, 'string');
weightNode = str2num(weightNode);
if isempty(weightNode)
    msgbox('Input cannot be empty', 'Error', 'error');
elseif weightNode <= 0
    msgbox('Weight cannot be zero or negatif', 'Error', 'error');
else
    % check if variable weight is exit or not in workspace
    e = evalin('base', 'who');
    if ismember('weight', e)
        weight = evalin('base', 'weight');
        s = evalin('base', 's');
        t = evalin('base', 't');
        indexNodesPair = evalin('base', 'indexNodesPair');
    else
        weight = [];
        s = [];
        t = [];
        indexNodesPair = 1;
    end
   % save names to the workpace
   weight(indexNodesPair) = weightNode;
   s(indexNodesPair) = selectedIndexNode1;
   t(indexNodesPair) = selectedIndexNode2;
   indexNodesPair = indexNodesPair + 1; 
   assignin('base', 'weight', weight);
   assignin('base', 's', s);
   assignin('base', 't', t);
   assignin('base', 'indexNodesPair', indexNodesPair);
   % default setup
   set(handles.etWeight, 'string', '');
   set(handles.pmNode1, 'value', 1);
   set(handles.pmNode2, 'value', 1);
end



% --- Executes on selection change in pmNode2.
function pmNode2_Callback(hObject, eventdata, handles)
% hObject    handle to pmNode2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmNode2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmNode2


% --- Executes during object creation, after setting all properties.
function pmNode2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmNode2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pmNode1.
function pmNode1_Callback(hObject, eventdata, handles)
% hObject    handle to pmNode1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmNode1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmNode1


% --- Executes during object creation, after setting all properties.
function pmNode1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmNode1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function etNodeNames_Callback(hObject, eventdata, handles)
% hObject    handle to etNodeNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etNodeNames as text
%        str2double(get(hObject,'String')) returns contents of etNodeNames as a double


% --- Executes during object creation, after setting all properties.
function etNodeNames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etNodeNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnToStep3.
function btnToStep3_Callback(hObject, eventdata, handles)
% hObject    handle to btnToStep3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Check is variable name exist
e = evalin('base', 'who');
if ismember('names', e)
    names = evalin('base', 'names');
    % Put values to Nodel popup menu
    set(handles.pmNode1, 'string', names);
    % Put values to Node2 popup menu
    set(handles.pmNode2, 'string', names);
    % change the panel
    set(handles.panel2, 'visible', 'off');
    set(handles.panel3, 'visible', 'on');
else
    msgbox('Input cannot be empty', 'Error', 'error');
end
    
    
% --- Executes on button press in btnCancel2.
function btnCancel2_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Default Setup
evalin('base', 'clear variables');
set(handles.panel1, 'visible', 'off');
set(handles.panel2, 'visible', 'off');
set(handles.panel3, 'visible', 'off');


% --- Executes on button press in btnInputNodeNames.
function btnInputNodeNames_Callback(hObject, eventdata, handles)
% hObject    handle to btnInputNodeNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% error saat nodename empty
nodeNames = get(handles.etNodeNames, 'string');
if isempty(nodeNames)
    msgbox('Input cannot be empty', 'Error', 'error');
else
    % check if variable names is exit or not in workspace
    e = evalin('base', 'who');
    if ismember('names', e)
        names = evalin('base', 'names');
        indexNames = evalin('base', 'indexNames');
    else
        names = "";
        indexNames = 1;
    end
   % save names to the workpace
   names(indexNames) = nodeNames;
   indexNames = indexNames + 1; 
   assignin('base', 'names', names);
   assignin('base', 'indexNames', indexNames);
   % default setup
   set(handles.etNodeNames, 'string', '');
end


% --- Executes on button press in btnGraphLayout.
function btnGraphLayout_Callback(hObject, eventdata, handles)
% hObject    handle to btnGraphLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% check if variables names, s, t, and weight exist
e = evalin('base', 'who');
if ismember('D', e)
    % Default setup
    set(handles.panel1, 'visible', 'off');
    set(handles.panel2, 'visible', 'off');
    set(handles.panel3, 'visible', 'off');
    set(handles.panel5, 'visible', 'off');
    set(handles.pmTitikAwal, 'value', 1);
    set(handles.pmTitikAkhir, 'value', 1);
    set(handles.stJarak, 'string', '');
    set(handles.stRute, 'string', '');
    % Turn on the panel
    set(handles.panel4, 'visible', 'on');
else
    msgbox('Graph file is not exist', 'Error', 'error');
end


% --- Executes on button press in btnCancelLayout.
function btnCancelLayout_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancelLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel4, 'visible', 'off');

% --- Executes on button press in btnDoneLayout.
function btnDoneLayout_Callback(hObject, eventdata, handles)
% hObject    handle to btnDoneLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Take the value of pmLayout
allItemsLayout = handles.pmLayout.String; % a cell array of all strings in the popup menu
selectedIndexLayout = handles.pmLayout.Value; % an integer saying which item has been selected
selectedItemLayout = allItemsLayout{selectedIndexLayout}; % the one, single string which was selected
% layout value 
layout = selectedItemLayout;
e = evalin('base', 'who');
if ismember('layout', e)
    evalin('base', 'clear layout');
    assignin('base', 'layout', layout);
else
    assignin('base', 'layout', layout);
end
% Assign the variables
D = evalin('base', 'D'); 
% Assign the axGraph
axes(handles.axGraph); % switch current axes to axGraph
p = plot(D, 'EdgeLabel', D.Edges.Weight, 'Layout', layout);
% close the panel
set(handles.panel4, 'visible', 'off');

% --- Executes on selection change in pmLayout.
function pmLayout_Callback(hObject, eventdata, handles)
% hObject    handle to pmLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmLayout contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmLayout


% --- Executes during object creation, after setting all properties.
function pmLayout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCancelEdit.
function btnCancelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% close the panel5
set(handles.panel5, 'visible', 'off');

% --- Executes on button press in btnSaveEdit.
function btnSaveEdit_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% default setup
evalin('base', 'clear filename');
evalin('base', 'clear title');
evalin('base', 'clear D');
set(handles.axGraph, 'visible', 'off');
cla(handles.axGraph);
set(handles.stJarak, 'string', '');
set(handles.stRute, 'string', '');
set(handles.stTitle, 'string', '');
set(handles.pmTitikAwal, 'string', '');
set(handles.pmTitikAkhir, 'string', '');
set(handles.pmLayout, 'value', 1);
% load the variables
s = evalin('base', 's');
t = evalin('base', 't');
names = evalin('base', 'names');
weight = evalin('base', 'weight');
% ambil filename dan title yang baru
filename = get(handles.etEditFilename, 'string');
filename = filename(find(~isspace(filename)));
title = get(handles.etEditTitle, 'string');
% taruh di workspace
assignin('base', 'filename', filename);
assignin('base', 'title', title);
% Assign value of D
D = digraph(s,t,weight,names);
assignin('base', 'D', D);
% save the file
save(filename, 's', 't', 'weight', 'names', 'title', 'D');
% Put values to Titik Awal popup menu
set(handles.pmTitikAwal, 'string', names);
% Put values to Titik Akhir popup menu
set(handles.pmTitikAkhir, 'string', names);
% put value to stTitle
set(handles.stTitle, 'string', title);
% Assign the axGraph
axes(handles.axGraph); % switch current axes to axGraph
p = plot(D, 'EdgeLabel', D.Edges.Weight);
% close the panel
set(handles.panel5, 'visible', 'off');

% --- Executes on button press in btnEditVector1.
function btnEditVector1_Callback(hObject, eventdata, handles)
% hObject    handle to btnEditVector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openvar('s');

% --- Executes on button press in btnEditVector2.
function btnEditVector2_Callback(hObject, eventdata, handles)
% hObject    handle to btnEditVector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openvar('t');

% --- Executes on button press in btnEditNames.
function btnEditNames_Callback(hObject, eventdata, handles)
% hObject    handle to btnEditNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openvar('names');

% --- Executes on button press in btnEditWeight.
function btnEditWeight_Callback(hObject, eventdata, handles)
% hObject    handle to btnEditWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openvar('weight');


function etEditTitle_Callback(hObject, eventdata, handles)
% hObject    handle to etEditTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etEditTitle as text
%        str2double(get(hObject,'String')) returns contents of etEditTitle as a double


% --- Executes during object creation, after setting all properties.
function etEditTitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etEditTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function etEditFilename_Callback(hObject, eventdata, handles)
% hObject    handle to etEditFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etEditFilename as text
%        str2double(get(hObject,'String')) returns contents of etEditFilename as a double


% --- Executes during object creation, after setting all properties.
function etEditFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etEditFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnEditGraph.
function btnEditGraph_Callback(hObject, eventdata, handles)
% hObject    handle to btnEditGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Check is variables exist
e = evalin('base', 'who');
if ismember('names', e) && ismember('s',e) && ismember('t',e) && ismember('weight',e) && ismember('title',e)
    % turning on the panel
    set(handles.panel1, 'visible', 'off');
    set(handles.panel2, 'visible', 'off');
    set(handles.panel3, 'visible', 'off');
    set(handles.panel4, 'visible', 'off');
    set(handles.panel5, 'visible', 'on');
    % load the variables
    title = evalin('base', 'title');
    filename = evalin('base', 'filename');
    % delete the .mat in the filename
    if isempty(strfind(filename, '.mat'))
        % set the variables to the handles
        set(handles.etEditTitle, 'string', title);
        set(handles.etEditFilename, 'string', filename);
    else
        filename((length(filename)-4)+1:length(filename)) = [];
        % set the variables to the handles
        set(handles.etEditTitle, 'string', title);
        set(handles.etEditFilename, 'string', filename);
    end
else
    msgbox('Graph file is not exist', 'Error', 'error');
end
    
