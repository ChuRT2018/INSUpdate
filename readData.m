clear;clc; 
fid = fopen('Data1.bin');
[data, n] = fread(fid,inf,'double');
data = reshape(data,7,n/7);
fclose(fid);