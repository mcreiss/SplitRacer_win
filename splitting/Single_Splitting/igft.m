function [ y ] = igft(x)

%iFFT with sign change in exponential function in compliance with definition
%used in Numerical Recipes

% Copyright 2016 M.Reiss and G.Rümpker

N=length(x);
y=fft(x);
y=y/N;
end