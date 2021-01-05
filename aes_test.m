%% aes_test.m
clc;
clear;

dbstop if error
% cleanupObj = onCleanup(@cleanMeUp);

rng shuffle
%%rng(1);
%addpath(genpath('./utils'));
%addpath(genpath('./bin2hex'));
%addpath(genpath('./textprogressbar'));

format long;
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end
% 
myComPort = serial('COM7','BaudRate',9600,'Timeout',200); %4800 %921600 460800 115200
fopen(myComPort);

Key = '000102030405060708090A0B0C0D0E0F';
Plaintext = '00112233445566778899AABBCCDDEEFF';
b = Cipher(Key,Plaintext);
% 
% Send Key
for k = 1:length(Key)/2
    sendbyte = Key((2*k-1):(2*k));
    x=uint8(hex2dec(sendbyte));
    fwrite(myComPort,x,'uint8');
end

% Send PT
for k = 1:length(Plaintext)/2
    sendbyte = Plaintext((2*k-1):(2*k));
    x=uint8(hex2dec(sendbyte));
    fwrite(myComPort,x,'uint8');
end
 
cipher = fread(myComPort,16,'uint8')
fclose(myComPort);