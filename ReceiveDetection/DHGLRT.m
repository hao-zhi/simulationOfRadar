clear all;
clc;
M=2;
N=2;
J = M*N;
alpha = 0.5;
pfa = 1e-4;
lo = -2*log(pfa)%цеоч1
SCNR =(1:25);%db
Pd = zeros(size(SCNR));
for lamda = SCNR
    pd = alpha*power(pfa,1/(1+lamda)) + (1-alpha)*pfa;
    k =2 ;
    P1dk = binopdf(J,k,pd);

    beta = ( alpha*power(pfa,1/(1+lamda)) ) /pd;
%     Pd = 0;
    for K=1:J
       p2d = 0;
       p1d = binopdf(k,J,pd);
       for m=0:K    
           p2d = p2d + binopdf(m,K,beta)*gamcdf(lo,m,J);
       end
       Pd(lamda) = Pd(lamda) +p1d*p2d;
       if Pd(lamda) > 1
           Pd(lamda) = 1;
       end
    end
end
figure;
plot(SCNR,Pd,'--o');

