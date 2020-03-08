function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 10-Jan-2020 21:43:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%% PRZYCISKI %%%%%%%%%%%%%%%%%%%%%%%%%

% --- WCZYTYWANIE OBRAZU
function pushbutton1_Callback(hObject, eventdata, handles)
global im im2;

[path, user_cance] = imgetfile();
if user_cance
    msgbox(sprintf('Select an image'), 'Error', 'Error');
    return 
end
im = imread(path);

im = im2double(im); %konwertujemy na double
im2 = im;  %backup - do resetowania
axes(handles.axes1);
imshow(im);
axes(handles.axes2);
imhist(im);


%PRZYCISK RESET
function pushbutton2_Callback(hObject, eventdata, handles)
global im2;

axes(handles.axes1);
imshow(im2);
axes(handles.axes2);
imhist(im2);


% przycisk rgb2gray
function pushbutton3_Callback(hObject, eventdata, handles)
    global im;

    imgray = toGray(im);
    axes(handles.axes1);
    imshow(imgray);
    axes(handles.axes2);
    imhist(imgray);


%przycisk zwykla binaryzacja
function pushbutton4_Callback(hObject, eventdata, handles)
    global im;

    imgray = toGray(im);
    set(handles.slider1, 'Value', 0.5);

    edges = linspace(0, 1, 3); % Create 20 bins.

    bim = binarize(imgray, .5);
    axes(handles.axes1);
    imshow(bim);
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);


% --- Przycisk binaryzacja otsu.
function pushbutton5_Callback(hObject, eventdata, handles)
    global im;
    bim = otsu(im);
    edges = linspace(0, 1, 3); % Create 20 bins.
    axes(handles.axes1);
    imshow(bim);
    bim = bim/225;
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);
    
% --- przycisk binaryzacja adaptacyjna
function pushbutton6_Callback(hObject, eventdata, handles)
    global im;
    bim = adaptive(im);
    edges = linspace(0, 1, 3); 
    axes(handles.axes1);
    imshow(bim);
    bim = bim/225;
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);

% --- przycisk Binaryzacja RGB.
function pushbutton7_Callback(hObject, eventdata, handles)
    global im;
    global TR;
    global TG;
    global TB;
    
    set(handles.slider2, 'Value', 0.5);
    set(handles.slider3, 'Value', 0.5);
    set(handles.slider4, 'Value', 0.5);
   
    TR = 0.5;
    TG = 0.5;
    TB = 0.5;
    edges = linspace(0, 1, 3); % Create 20 bins.

    bim = binarizeRGB(im, TR, TG, TB);
    axes(handles.axes1);
    imshow(bim);
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);  

    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SUWAKI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function slider1_Callback(hObject, eventdata, handles)
    global im;

    imgray = toGray(im);
    T = get(hObject, 'Value');
    bim = binarize(imgray, T);

    edges = linspace(0, 1, 3);

    axes(handles.axes1);
    imshow(bim);
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);


function slider2_Callback(hObject, eventdata, handles)
    global im;
    global TR;
    global TG;
    global TB;
    
    TR = get(hObject, 'Value');
    bim = binarizeRGB(im, TR, TG, TB);
    
    edges = linspace(0, 1, 3); % Create 20 bins.
    
    axes(handles.axes1);
    imshow(bim);
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);


function slider3_Callback(hObject, eventdata, handles)
    global im;
    global TR;
    global TG;
    global TB;
    
    TG = get(hObject, 'Value');
    bim = binarizeRGB(im, TR, TG, TB);
    
    edges = linspace(0, 1, 3); % Create 20 bins.
    
    axes(handles.axes1);
    imshow(bim);
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);


function slider4_Callback(hObject, eventdata, handles)
    global im;
    global TR;
    global TG;
    global TB;
    
    TB = get(hObject, 'Value');
    bim = binarizeRGB(im, TR, TG, TB);
    
    edges = linspace(0, 1, 3); % Create 20 bins.

    axes(handles.axes1);
    imshow(bim);
    axes(handles.axes2);
    histogram(bim, 'BinEdges',edges);

    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNKCJE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%funkcja konwertujaca obraz do odcieni szarosci
function returnedImage = toGray(image)
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3); 
    
    for x=1:size(image,1)
       for y=1:size(image,2)
           returnedImage(x,y) = (R(x,y)*.299)+(G(x,y)*.587)+(B(x,y)*.114);
       end
    end
 
    
%funkcja zwracaj¹ca zbinaryzowany obraz dla zadanego T
function returnedImage = binarize(image, T)
    returnedImage = image;
    returnedImage(returnedImage > T) = 1;
    returnedImage(returnedImage <=T) = 0;

    
%funkcja zwracajaj¹ca zbinaryzowany kana³ czerwony dla zadanego T
function returnedImage = Rbinarize(im, T)
    R = im(:, :, 1);
    returnedImage = imbinarize(R, T);
 
%funkcja zwracajaj¹ca zbinaryzowany kana³ zielony dla zadanego T
function returnedImage = Gbinarize(im, T)
    R = im(:, :, 2);
    returnedImage = binarize(R, T);
    
    
%funkcja zwracajaj¹ca zbinaryzowany kana³ niebieski dla zadanego T
function returnedImage = Bbinarize(im, T)
    R = im(:, :, 3);
    returnedImage = binarize(R, T);
 
    
%funkcja zwracaj¹ca sumê logiczn¹ zbinaryzowanego obrazu czerwonego, zielonego i
%niebieskiego.
function imageOut = binarizeRGB(imageIn, TR, TG, TB)
    R = Rbinarize(imageIn, TR);
    G = Gbinarize(imageIn, TG);
    B = Bbinarize(imageIn, TB);
    
    imageOut = R|G;
    imageOut = imageOut|B;
    
    
 function returnedImage = toGrayOtsu(image)
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3); 
    
    returnedImage = zeros(size(i,1), size(i,2), 'uint8');

    for x=1:size(image,1)
       for y=1:size(image,2)
           returnedImage(x,y) = (R(x,y)*.299)+(G(x,y)*.587)+(B(x,y)*.114);
       end
    end   
    
%otsu
function returnedImage = otsu(image)
    i = toGrayOtsu(image);
    [counts,binLocations] = imhist(i);
    
    all = sum(counts);
    sumAll = 0.0;
    for p=0:255
        sumAll = sumAll + p * counts(p+1);
    end
    sumB = 0.0;
    weightB = 0.0;
    max = 0.0;
    t=0;
    for p=0:255
        weightB = weightB + counts(p+1);
        if(weightB == 0)
            continue;
        end
        weightF = all - weightB;
        if(weightF==0)
            continue;
        end
        sumB = sumB + p*counts(p+1);
        meanB = sumB/weightB;
        meanF = (sumAll-sumB)/weightF;
        %calculating the individual class variance
        between = weightB * weightF * (meanB - meanF)^2;
        if(between > max)
            max = between;
            t=p;
        end
    end
    
    newImage = zeros(size(i,1), size(i,2), 'uint8');
        
    for x=1:size(i,1)
        for y=1:size(i,2)
        	if i(x,y)>t
            	newImage(x,y) = 255;
            end
        end
    end
    
    returnedImage = newImage;
  
%adaptive
function returnedImage = adaptive(im)
    N = 100;
    [h, w, d] = size(im);
    returnedImage = zeros(h, w);
    N2 = floor(N/2);
    for i=1+N2:h-N2
        for j=1+N2 : w-N2
            im2 = im(i-N2:i+N2 , j-N2:j+N2);
            treshold = mean(mean(im2)) ;
            if im(i, j) > treshold
                returnedImage(i,j) = 1;
            else
                returnedImage(i,j) = 0;
            end
        end
    end
         
    
        
%%%%%%%%%%%%%%%%%%%%%  FUNKCJE TWORZACE SUWAKI %%%%%%%%%%%%%%%%%%%%%%
    
function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end