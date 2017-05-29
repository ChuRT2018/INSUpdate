function constant()
global Ra;
global Rb;
global POWE;
global GM;
global OMEGAe;
global F;
global M;

global GAMMAa;
global GAMMAb;

Ra = 6378137;
Rb = 6356752.3142;
POWE = 0.00669437999013;
GM  = 3.986004418e14;
OMEGAe =  7.292115e-5;
F = 1/298.257223563;
M = OMEGAe * OMEGAe * Ra *...
    Ra * Rb / GM;

GAMMAa = 9.7803267715;
GAMMAb = 9.8321863685;

end