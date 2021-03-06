%Band Edge speifications
fs1 = 51.5e3;
fp1 = 47.5e3;
fp2 = 75.5e3;
fs2 = 71.5e3;
f_samp=260e3;

%Kaiser paramters
A = -20*log10(0.15);
if(A < 21)                                                 
    beta = 0;
elseif(A <51)
    beta = 0.5842*(A-21)^0.4 + 0.07886*(A-21);
else
    beta = 0.1102*(A-8.7);
end

N_min = ceil((A-8) / (2.285*0.0308*pi));           
N_min = N_min +1;

%Window length for Kaiser Window
n=N_min+19;
disp(n);                                     %window length

%Ideal bandpass impulse response of length "n"
bs_ideal =  ideal_lp(pi,n) -ideal_lp(0.565*pi,n) + ideal_lp(0.378*pi,n);           % cutoff frequency is the arithmatic average of fp1,fs1 and fp2, fs2 respectively


%Kaiser Window of length "n" with shape paramter beta calculated above
kaiser_win = (kaiser(n,beta))';

FIR_BandStop = bs_ideal .* kaiser_win;
fvtool(FIR_BandStop);         %frequency response

%magnitude response
[H,f] = freqz(FIR_BandStop,1,2048, f_samp);
plot(f,abs(H))
grid

% To obtain impulse sequence, uncomment to obtain the plot
%i=-29:1:29;
%stem(i,FIR_BandStop,'filled')
