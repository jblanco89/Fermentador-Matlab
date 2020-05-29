mumax=11.76; %por definor
Km=7.79; %por definir

ts=0; %tiempo inicial
tf=250; %tiempo final, horas
n=40; %resultados a mostrar
SO=2500; %concentracion inicial etanol
PO=0;%concentracion inicial Tryptofano

YO = [SO PO];

%creamos la función 

function dydt = batchfermen(t,y)

mumax=10;
Km=7;

S=y(1); P=y(2);

r=mumax*(S/(Km+S)); %ecuación cinétiva por definir

dSdt = -r; %consumo de etanol
dPdt = r; %producción de tryptofano

dydt = [dSdt;dPdt];
end

%ODE
tspan=[ts tf];
options = odeset('RelTol',1e-6,'AbsTol',1e-6);

[t,y]=ode45(@batchfermen,tspan,YO,options);

t_n = linspace(ts,tf,n);
y_n=interp1(t,y,t_n,'spline');

Ssim = y_n(:,1);Psim=y_n(:,2);

Valores_finales=y_n(end,:);

rsim = mumax.*(Ssim./(Ssim+Km));

figure(1)
plot(t_n,y_n,'linewidth',3);
title('Reactor Fermentación','FontSize',16);
xlabel('tiempo,horas');
ylabel('Etanol,Trypto,Kg/l');
legend('r');
grid

figure(2) 
plot(t_n,rsim,'linewidth',3); 
title('Reactor Fermentación','FontSize',16,'FontWeight','bold');
xlabel('tiempo,horas','FontSize',16,'FontWeight','bold');
ylabel('r, mg/mL/h','FontSize',16,'FontWeight','bold'); 
legend('r'); 
grid

figure(4) 
subplot(2,1,1) 
plot(t_n,Ssim,'r','linewidth',3); 
xlabel('tiempo,horas','FontSize',12,'FontWeight','bold'); 
ylabel('Etanol, Kg/L','FontSize',12,'FontWeight','bold');
legend('Etanol'); 
grid 
subplot(2,1,2) 
plot(t_n,Psim,'g','linewidth',3); 
xlabel('tiempo,horas','FontSize',12,'FontWeight','bold'); 
ylabel('Tryp, Kg/L','FontSize',12,'FontWeight','bold'); 
legend('Tryp'); 
grid

resultados=[t_n',Ssim,Psim]