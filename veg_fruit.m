function varargout = veg_fruit(varargin)
% VEG_FRUIT MATLAB code for veg_fruit.fig
%      VEG_FRUIT, by itself, creates a new VEG_FRUIT or raises the existing
%      singleton*.
%
%      H = VEG_FRUIT returns the handle to a new VEG_FRUIT or the handle to
%      the existing singleton*.
%
%      VEG_FRUIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VEG_FRUIT.M with the given input arguments.
%
%      VEG_FRUIT('Property','Value',...) creates a new VEG_FRUIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before veg_fruit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to veg_fruit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help veg_fruit

% Last Modified by GUIDE v2.5 07-Aug-2021 23:07:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @veg_fruit_OpeningFcn, ...
                   'gui_OutputFcn',  @veg_fruit_OutputFcn, ...
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
end

% --- Executes just before veg_fruit is made visible.
function veg_fruit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to veg_fruit (see VARARGIN)

% Choose default command line output for veg_fruit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes veg_fruit wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = veg_fruit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
cla(handles.axes1);
[Sel_Img,SelImage_Path] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'},pwd,'Pick the test image file');
SelImage_Path = [SelImage_Path Sel_Img];

if Sel_Img == 0
    return;
end

image = imread(SelImage_Path);

axes(handles.axes1);
imshow(image), title('Image for Recognition');

handles.image = image;
guidata(hObject,handles);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
 shadowless_img = handles.shadowremimg;
catch err
    msgbox('Perform pre-processing steps');
end

imgbw = im2bw(shadowless_img); % Need to change the size of the resize

% Displaying the image
axes(handles.axes5);
imshow(imgbw);
title('Black & White Image');

handles.blackwhiteimg = imgbw;
guidata(hObject,handles);
end
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla(handles.axes1); title('');
axes(handles.axes2); cla(handles.axes2); title('');
axes(handles.axes3); cla(handles.axes3); title('');
axes(handles.axes4); cla(handles.axes4); title('');
axes(handles.axes5); cla(handles.axes5); title('');
axes(handles.axes6); cla(handles.axes6); title('');
axes(handles.axes8); cla(handles.axes8); title('');
set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
end
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
im = handles.blackwhiteimg;
c=input('Enter the Class(Number from 1-50)');
%% Feature Extraction
F=feature_statistical(im);
try 
    load DB;
    
    F=[F c];
    DB=[DB; F];
    save DB.mat DB 
catch 
    DB=[F c]; % 10 12 1
    save DB.mat DB
end
end
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6);
[Sel_Img,SelImage_Path] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'},pwd,'Pick the test image file');
SelImage_Path = [SelImage_Path Sel_Img];

if Sel_Img == 0
    return;
end

im1 = imread(SelImage_Path);
im = im2bw(im1);
axes(handles.axes6);
imshow(im), title('Image for Testing');

handles.Image = im;
guidata(hObject,handles);

%% Find the class the test plant image belongs
Ftest=feature_statistical(im);
%% Compare with the feature of training image in the database
load DB.mat
Ftrain=DB(:,1:2);
Ctrain=DB(:,3);
for (i=1:size(Ftrain,1));
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end
Min=min(dist);
m=find(dist==Min,1);
det_class=Ctrain(m);
msgbox(strcat('Detected Class=',num2str(det_class)));
if det_class == 1
    helpdlg(' Brinjal');
    disp('Brinjal');
elseif det_class == 2
    helpdlg(' Pepper ');
    disp(' Pepper ');
elseif det_class == 3
    helpdlg(' Banana ');
    disp(' Banana ');
elseif det_class == 4
    helpdlg(' Avocado ');
    disp(' Avocado ');
elseif det_class == 5
    helpdlg(' Tomato ');
    disp(' Tomato ');
elseif det_class == 6
    helpdlg(' Mango ');
    disp(' Mango ');
elseif det_class == 7
    helpdlg(' Pampkin ');
    disp(' Pampkin ');
elseif det_class == 8
    helpdlg(' Apple ');
    disp(' Apple ');
elseif det_class == 9
    helpdlg(' Pears ');
    disp(' Pears ');
elseif det_class == 10
    helpdlg(' Orange ');
    disp(' Orange ');
else
    helpdlg('Unable to recognize');
    disp('Unable to recognize');
end
end
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Image Resize
try
    image = handles.image;
catch err
    msgbox('Select the Image');
end


[row col channel] = size(image);
img_resized = imresize(image,[200 300]); % Need to change the size of the resize

% Displaying the image
axes(handles.axes2);
imshow(img_resized);
title('Resized Image(200*300)');

handles.ResizedImage = img_resized;
guidata(hObject,handles);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    image_resized = handles.ResizedImage;
catch err
    msgbox('Please resize the image');
end

[cleanimg] = NoiseRemoval(image_resized);

axes(handles.axes3);
imshow(cleanimg);
title('Noise removed Image');

handles.cleanimg = cleanimg;
guidata(hObject,handles);

end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    imag_for_shadow_rem = handles.cleanimg;
catch err
    msgbox('Please perform Noise Removal');
end

shadowless_img = ShadowRemoval(imag_for_shadow_rem);

axes(handles.axes4);
imshow(shadowless_img);
title('Image after Shadow Removal');

handles.shadowremimg = shadowless_img;
guidata(hObject,handles);
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end






% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
      ImageNum = 1;
    [FileName, PathName] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
      
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 0.5)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end

% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2

    set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
   set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 2;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 0.05)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end

% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3

   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 3;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 0.5)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end
% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4
   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
   set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 4;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 0.2)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton5

   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 5;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 1.3)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end
% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton6

   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 6;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 1.5)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end
% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton7
   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
   set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 7;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 1.3)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end

% --- Executes on button press in togglebutton8.
function togglebutton8_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton8

   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
   set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 8;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 0.9)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end
% --- Executes on button press in togglebutton9.
function togglebutton9_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton9
   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
   set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 9;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 1.0)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end
function togglebutton10_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton9
   set(handles.text23,'Visible','off')
    set(handles.text21,'Visible','off')
    set(handles.text24,'Visible','off')
    set(handles.text25,'Visible','off')
    set(handles.text22,'Visible','off')
    set(handles.text17, 'Visible','off');
    set(handles.text18, 'Visible','off');
    set(handles.text19, 'Visible','off');
    set(handles.text20, 'Visible','off');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    delete(findall(findall(gcf,'Type','axe'),'Type','text'))
    [FileName, PathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp'},'File Selector');
    img = fullfile(PathName, FileName);
  
    if (img ~=0)
        ImageNum = 10;
        [ImToDisp,ImToDisp2, MaskPixel] = Fruit(img,ImageNum);
        ImagePixel = SizeInPixels(img);
        [flag,percent] = CalcFruit(ImagePixel, MaskPixel, ImageNum);
        CheckDiam = Diameter(img);
        if (CheckDiam >= 0.02)
            DiamFlag = true;
        else 
            DiamFlag = false;
        end
        if (flag == true && DiamFlag == true)
            set(handles.text23,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
        elseif (flag == true && DiamFlag == false)
            set(handles.text21,'Visible','on')
            set(handles.text24,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        elseif (flag == false && DiamFlag == true)
            set(handles.text21,'Visible','on')
            set(handles.text25,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        else
            set(handles.text21,'Visible','on')
            set(handles.text22,'Visible','on')
            set(handles.text17, 'Visible','on');
            set(handles.text18, 'String', sprintf('%f', CheckDiam));
            set(handles.text18, 'Visible','on');
            set(handles.text19, 'Visible','on');
            set(handles.text20, 'String', sprintf('%.2f%%', percent));
            set(handles.text20, 'Visible','on');
            axes(handles.axes8);
            imshow(ImToDisp2);
            title('Masked Image');
        end
    
    end
end


% --- Executes on selection change in check.
function check_Callback(hObject, eventdata, handles)
% hObject    handle to check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns check contents as cell array
%        contents{get(hObject,'Value')} returns selected item from check
val = get(handles.check,'Value');
   if val == 1
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
        
   elseif val == 2
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
         set(handles.togglebutton1,'Visible','on')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
   elseif val == 3
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','on')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
   elseif val == 4
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','on')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
   elseif val == 5
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','on')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
    elseif val == 6
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','on')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
       set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
    elseif val == 7
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','on')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
    elseif val == 8
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','on')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
    elseif val == 9
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','on')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','off')
       set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
    elseif val == 10
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','on')
        set(handles.togglebutton10,'Visible','off')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off') 
      elseif val == 11
        delete(findall(findall(gcf,'Type','axe'),'Type','text'))
        set(handles.togglebutton1,'Visible','off')
        set(handles.togglebutton2,'Visible','off')
        set(handles.togglebutton3,'Visible','off')
        set(handles.togglebutton4,'Visible','off')
        set(handles.togglebutton5,'Visible','off')
        set(handles.togglebutton6,'Visible','off')
        set(handles.togglebutton7,'Visible','off')
        set(handles.togglebutton8,'Visible','off')
        set(handles.togglebutton9,'Visible','off')
        set(handles.togglebutton10,'Visible','on')
        set(handles.text23,'Visible','off')
        set(handles.text24,'Visible','off')
        set(handles.text21,'Visible','off')
        set(handles.text25,'Visible','off')
        set(handles.text22,'Visible','off')
        set(handles.text17, 'Visible','off');
        set(handles.text18, 'Visible','off');
        set(handles.text19, 'Visible','off');
        set(handles.text20, 'Visible','off');
        set(get(handles.axes8,'children'),'Visible','off')
   end
end
% --- Executes during object creation, after setting all properties.
function check_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
