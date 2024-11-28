function c_v = postnc(filename)
  if ~(ischar(filename)|| isstring(filename))
    error('Wrong file name');
  else
    data=readmatrix(filename,'NumHeaderLines',2);
    %data=load(filename,'-ascii'); %loading data from file
    N_A=6.02e23; %avogadros number
    e = 1.60e-19; % charge of elecron
    k_B= 8.629e-5; % boltzman constant (ev)
    N = mean(data(:,2));
    f = mean(data(:,3));
    T = mean(data(:,4));
    E = mean(data(:,7));
    sqE = mean(data(:,6));
    varE = sqE-E^2;  %ev^2
    PE = mean(data(:,8));
    sqPE = mean(data(:,9));
    KE = mean(data(:,10));
    sqKE = mean(data(:,11));
    P = mean(data(:,5));
    varPE = sqPE -PE^2;
    varKE = sqKE -KE^2;
    n= N/N_A;
    c_v = (varE*e)/(k_B*T^2*n);
    fp=fopen('specific_heat.txt','a++');
    if fp==-1
      error('can not open file');
    end
    fprintf(fp,'No of atom = %d\nTemperature = %0.2f K\n',N,T);
    fprintf(fp,'Variance of energy = %f ev^2\nSpecific Heat = %f J/mol.k\n\n',varE,c_v);
    fclose(fp);
    fp=fopen('plot.txt','a++');
    if fp==-1
    error('can not open file');
    end
    if ftell(fp)==0;
        fprintf(fp,'f\tc_v\tPress\tvarKE\tvarPE\n');
    end
  fprintf(fp,'%0.2f\t%0.3f\t%0.3f\t%0.3f\t%0.3f \n',f*100,c_v, P,varKE,varPE);
  fclose(fp);
  return c_v;
  end
