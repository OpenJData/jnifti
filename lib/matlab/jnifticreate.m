function jnii=jnifticreate(img, varargin)
%
%    jnii=jnifticreate
%       or
%    jnii=jnifticreate('header1', value1, 'header2', value2, ...)
%    jnii=jnifticreate(img, 'header1', value1, ...)
%
%    Create a default JNIfTI structure with default header and image volume
%
%    author: Qianqian Fang (q.fang <at> neu.edu)
%
%    input:
%        img: set the jnii.NIFTIData section
%        'header_i': the header subfield name defined in the JNIfTI
%                    specification, see https://github.com/fangq/jnifti
%        value_i: set the value for the specified JNIfTI header field
%
%    output:
%        jnii: without any input, jnii gives the default jnii header
%              if img is given, jnii also includes the NIFTIData field
%
%
%    this file is part of JNIfTI specification: https://github.com/fangq/jnifti
%
%    License: Apache 2.0, see https://github.com/fangq/jnifti for details
%


jnii=struct('NIFTIHeader',struct(), 'NIFTIData', []);

jnii.NIFTIHeader.NIIHeaderSize=  0;
jnii.NIFTIHeader.DataTypeName=   'uint8';
% jnii.NIFTIHeader.A75DBName=      '';
% jnii.NIFTIHeader.A75Extends=     0;
% jnii.NIFTIHeader.A75SessionError='';
% jnii.NIFTIHeader.A75Regular=     0;
jnii.NIFTIHeader.DimInfo.Freq=   0;
jnii.NIFTIHeader.DimInfo.Phase=  0;
jnii.NIFTIHeader.DimInfo.Slice=  0;
jnii.NIFTIHeader.Dim=            [];
jnii.NIFTIHeader.Param1=         0;
jnii.NIFTIHeader.Param2=         0;
jnii.NIFTIHeader.Param3=         0;
jnii.NIFTIHeader.IntentCode=     0;
jnii.NIFTIHeader.DataType=       'uint8';
jnii.NIFTIHeader.BitDepth=       8;
jnii.NIFTIHeader.FirstSliceID=   1;
jnii.NIFTIHeader.VoxelSize=      [1,1,1,1];
jnii.NIFTIHeader.NIIByteOffset=  0;
jnii.NIFTIHeader.ScaleSlope=     0;
jnii.NIFTIHeader.ScaleOffset=    0;
jnii.NIFTIHeader.LastSliceID=    1;
jnii.NIFTIHeader.SliceCode=      0;
jnii.NIFTIHeader.Unit=           struct('L','mm','T', 's');
jnii.NIFTIHeader.MaxIntensity=   255;
jnii.NIFTIHeader.MinIntensity=   0;
jnii.NIFTIHeader.SliceTime=      1;
jnii.NIFTIHeader.TimeOffset=     0;
% jnii.NIFTIHeader.A75GlobalLMax=  255;
% jnii.NIFTIHeader.A75GlobalMin=   0;
jnii.NIFTIHeader.Description=    '';
jnii.NIFTIHeader.AuxFile=        '';
jnii.NIFTIHeader.QForm=          0;
jnii.NIFTIHeader.SForm=          0;
jnii.NIFTIHeader.QuaternB=       0;
jnii.NIFTIHeader.QuaternC=       0;
jnii.NIFTIHeader.QuaternD=       0;
jnii.NIFTIHeader.QuaternXOffset= 0;
jnii.NIFTIHeader.QuaternYOffset= 0;
jnii.NIFTIHeader.QuaternZOffset= 0;
jnii.NIFTIHeader.Affine(1,:)=    [1 0 0 0];
jnii.NIFTIHeader.Affine(2,:)=    [0 1 0 0];
jnii.NIFTIHeader.Affine(3,:)=    [0 0 1 0];
jnii.NIFTIHeader.Name=           'default';
jnii.NIFTIHeader.NIIFormat=      'JNIfTI';
% jnii.NIFTIHeader.NIIExtender=    [0,0,0,0];

if(nargin==0)
    return;
end
if(~isnumeric(img) && ~islogical(img))
    error('img input must be a numerical or logical array');
end

jnii.NIFTIHeader.Dim=size(img);
jnii.NIFTIHeader.DataTypeName=class(img);
jnii.NIFTIHeader.DataType=class(img);
info=whos('img');
jnii.NIFTIHeader.BitDepth=info.bytes/numel(img)*8;

jnii.NIFTIData=img;

if(~isempty(varargin))
     for i=1:2:length(varargin)
         jnii.NIFTIHeader.(varargin{i})=varargin{i+1};
     end
end