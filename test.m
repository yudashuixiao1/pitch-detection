%{
1(E)弦空弦，音高e1，频率f = 440.0000 / 2 ^ ( 5 / 12 ) = 329.6276 Hz
2(B)弦空弦，音高b，频率 f = 440.0000 / 2 ^ ( 10 / 12 ) = 246.9417 Hz
3(G)弦空弦，音高g，频率f = 440.0000 / 2 ^ ( 14 / 12 ) = 195.9977 Hz
4(D)弦空弦，音高d，频率 f = 440.0000 / 2 ^ ( 19 / 12 ) = 146.8324 Hz
5(A)弦空弦，音高A，频率f = 440.0000 / 2 ^ ( 24 / 12 ) = 110.0000 Hz
6(E)弦空弦，音高E，频率 f = 440.0000 / 2 ^ ( 29 / 12 ) = 82.4069 Hz
%}
clc; clear all;
[YY,Fs]=audioread('F:\data\单音.wav');
%[Y] =EndDetection(YY);%端点检测
F0MinMax=[50 350];  frame_length=30;  timestep=10;  SHR_Threshold=0.4;  ceiling=1250;   med_smooth=0;  CHECK_VOICING=1;
[f0_time,f0_value,SHR,f0_candidates]=shrp(YY,Fs,F0MinMax,frame_length,timestep,SHR_Threshold,ceiling,med_smooth,CHECK_VOICING);

% SHRP - a pitch determination algorithm based on Subharmonic-to-Harmonic Ratio (SHR)
% [f0_time,f0_value,SHR,f0_candidates]=shrp(Y,Fs[,F0MinMax,frame_length,TimeStep,SHR_Threshold,Ceiling,med_smooth,CHECK_VOICING]) 
%
%   Input parameters (There are 9):
%
%       Y:              Input data 
%       Fs:             Sampling frequency (e.g., 16000 Hz)
%       F0MinMax:       2-d array specifies the F0 range. [minf0 maxf0], default: [50 550]
%                       Quick solutions:
%                       For male speech: [50 250]
%                       For female speech: [120 400]
%       frame_length:   length of each frame in millisecond (default: 40 ms)
%       TimeStep:       Interval for updating short-term analysis in millisecond (default: 10 ms)
%       SHR_Threshold:  Subharmonic-to-harmonic ratio threshold in the range of [0,1] (default: 0.4). 
%                       If the estimated SHR is greater than the threshold, the subharmonic is regarded as F0 candidate,
%                       Otherwise, the harmonic is favored.
%       Ceiling:        Upper bound of the frequencies that are used for estimating pitch. (default: 1250 Hz)       
%       med_smooth:     the order of the median smoothing (default: 0 - no smoothing);                       
%       CHECK_VOICING:  check voicing. Current voicing determination algorithm is kind of crude.
%                       0: no voicing checking (default)
%                       1: voicing checking
%   Output parameters:
%       
%       f0_time:        an array stores the times for the F0 points
%       f0_value:       an array stores F0 values
%       SHR:            an array stores subharmonic-to-harmonic ratio for each frame
%		f0_candidates:  a matrix stores the f0 candidates for each frames, currently two f0 values generated for each frame.
%						Each row (a frame) contains two values in increasing order, i.e., [low_f0 higher_f0].
%						For SHR=0, the first f0 is 0. The purpose of this is that when you want to test different SHR
%						thresholds, you don't need to re-run the whole algorithm. You can choose to select the lower or higher
%						value based on the shr value of this frame. 
