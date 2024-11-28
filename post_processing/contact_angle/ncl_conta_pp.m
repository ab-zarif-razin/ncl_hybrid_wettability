clear;
data = load("density_profile_w_0.02_1.data","-ascii");
%data=density;
data = data(data(:,6)>0.7,[1:3 6]);
[n,m]=size(data);
x = data(:,2);
y = data(:,3);
x1 = x(1);
output=zeros(n,2);
output(1,:)=[x1 y(1)];
i=2;
for j=2:n
    x2=x(j);
    if x2 ~= x1
        output(i,:)=[x1, y(j-1)];
        output(i+1,:)=[x2,y(j)];
        i=i+2;
        x1=x2;
    end

end
output=output(output(:,2)>3.7,:)
hold on;
plot(output(:,1),output(:,2),"o");
[z, r] = fitcircle(output','linear');
% And plot the results
t = linspace(0, 2*pi, 100);
plot(z(1)  + r  * cos(t), z(2)  + r * sin(t), 'k')
h=3.3875; 
% h=8
R=z(1)+sqrt(r^2-(h-z(2))^2)
L=z(1)-sqrt(r^2-(h-z(2))^2)
m_R = (-(R-z(1))/(h-z(2)))
m_L = (-(L-z(1))/(h-z(2)))
theta_r = 180-atan(m_R)*180/pi
theta_l = 180+atan(m_L)*180/pi
theta = (theta_l+theta_r)/2

