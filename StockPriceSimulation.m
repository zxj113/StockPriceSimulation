% StockPriceSimulation.m
% Copyright: (2017) Zhiyuan Jiang, Penn State University


pd=makedist('Gamma','a',1,'b',1);
pd_open=makedist('Gamma','a',0.1,'b',1);
pd_yin=makedist('Gamma','a',0.4,'b',1);

 
start_price=100;
 
low_price=start_price;
high_price=start_price;
open_price=start_price;
close_price=start_price;
N=100;
i=1;
 
figure
hold on;
while i<N
    tmp=random(pd_open);
    ind=rand-0.5;
    open_price=[open_price,close_price(i)+ind/abs(ind)*tmp];
    tmp=random(pd);
    ind=rand-0.5;
    close_price=[close_price,open_price(i+1)+ind/abs(ind)*tmp];
    tmp=random(pd_yin);
    high_price=[high_price,max(open_price(i+1),close_price(i+1))+tmp];
    tmp=random(pd_yin);
    low_price=[low_price,min(open_price(i+1),close_price(i+1))-tmp];
    i=i+1;
    plot([i i],[low_price(i) high_price(i)],'k');
    if close_price(i)<open_price(i)
        bar(i,close_price(i),0.6,'r','BaseValue',open_price(i),'showbaseline','off');
    else
        bar(i,close_price(i),0.6,'g','BaseValue',open_price(i),'showbaseline','off');
    end
     
end
 
hold on;
 
plot(1:N,tsmovavg(close_price,'s',5),'b');
 
plot(1:N,tsmovavg(close_price,'s',10),'r');
plot(1:N,tsmovavg(close_price,'s',20),'c');


xlabel('day');
ylabel('price');
