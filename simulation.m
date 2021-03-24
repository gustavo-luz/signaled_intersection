function intersection

%Este código contém:
%1. O atraso em horas dos veículos das Ruas Elm e Main
%2. Uma média do atraso total das duas ruas e médio em 20 simulações
%3. O código que gera o gráfico de Carros x Tempo nas duas ruas


for K= 1:20 % A primeira coisa a ser feita é definir o número de runs da
simulação.
 %Utilizou-se 20 já que foi solicitado que fizessemos no mínimo 10
%Primeiramente, definiremos a chegada das duas ruas (elm e main)
% CHEGADA ELM


%As duas chegadas seguem um padrão:
%(1)primeiramente se define uma variável contadora das chegadas,
%(2)depois é gerado um tempo randômico de acordo com a distribuição
uniforme da rua
%(3)e o programa mostra que chega 1 carro na rua inicialmente


i=1; %(1)

chegada_elm(1)= unifrnd(4,7); %(2)

ncarros_chegam_elm(1)=1; %(3)

%gerar todas as chegadas na rua elm
while chegada_elm(i) <= 900; %A simulação durará 15 minutos, o que
representa 900 segundos
    T_chegada_elm= unifrnd (4,7); %é gerado um tempo randômico de chegada
    chegada_elm(i+1)= chegada_elm(i) + T_chegada_elm; %é gerado o próximo
    tempo de chegada na rua
    ncarros_chegam_elm(i+1)= i+1; %cálculo do número de carros que estão
    na rua
    i=i+1; %variável contadora que vai sendo atualizada
end
chegada_elm(i)=900; %limite da simulação, para que não sejam gerados números maiores que 900.


% CHEGADA MAIN
%as chegadas na rua main seguirão a mesma lógica da rua elm, apresentando
os 3 passos explicados.
%A única diferença entre as duas ruas é a distribuição uniforme randômica

i=1;
chegada_main(1)= unifrnd(3,5);
ncarros_chegam_main(i)=1;
while chegada_main(i)<= 900;
    T_chegada_main= unifrnd(3,5);
    chegada_main(i+1)= chegada_main(i) + T_chegada_main;
    ncarros_chegam_main(i+1)= i+1;
    i=i+1;
end
chegada_main(i)=900;


% SAIDAS
%O segundo passo é gerar as saídas das duas ruas:
%Além da variável contadora (i) , temos uma variável auxiliar de controle
(j), que indica a alternância do sinal

% SAIDA ELM

i=1;
j=1 ;
ncarros_saem_elm(i)=1;
saida_elm(1)=31; %Como o sinal da rua Elm se inicia fechado, o primeiro
carro sai de elm em 31.


while saida_elm(i)<=900;
    while(saida_elm(i)>=(j*30)+1) && (saida_elm(i)<((j+1)*30));
        if chegada_elm(i+1)< saida_elm(i); %Possibilidade: chegada do 2º antes que a saída do 1º
            saida_elm(i+1)=saida_elm(i)+2; %saída após a saída do anterior com o acréscimo de 2 segundos
            ncarros_saem_elm(i+1)=i+1; %conta quantos carros saíram

        else %2º chega e o 1º já saiu
            saida_elm(i+1)=chegada_elm(i+1); %chega no sinal e já sai

            ncarros_saem_elm(i+1)= i+1; %conta quantos carros saíram
         end
        i=i+1;
    end
    j=j+2; %próxima abertura do sinal
    saida_elm(i)=j*30+1;
end
saida_elm(i)=900;


% SAIDA MAIN
%As saídas na rua main seguirão a mesma lógica da rua elm, apresentando
os mesmos passos explicados.
%(*)A adequação realizada foi o respeito a abertura do sinal em tempos
diferentes, que ocorre inicialmente de 1 a 30s.


i=1;
j=1;
ncarros_saem_main(i)=1;
saida_main(i)=chegada_main(i);

while saida_main(i)< 900
    while(saida_main(i)>=((j-1)*30)+1) && (saida_main(i)<=(j*30))%para se adequar a condição apresentada (*)
        if chegada_main(i+1)<=(saida_main(i))
            saida_main(i+1)=saida_main(i)+2;
            ncarros_saem_main(i+1)=i+1;

        else
            saida_main(i+1)=chegada_main(i+1);

            ncarros_saem_main(i+1)= i+1;
        end
        i=i+1;
    end
    j=j+2;
   saida_main(i)=(j-1)*30+1;
end
saida_main(i)=900;


% ATRASOS
%Para o cálculo dos atrasos, primeiramente deve-se criar uma nova
variável para normalizar o vetor de saídas das ruas.
%Depois de normalizado, é calculado o atraso para cada rua a partir da
%subtração entre saídas e chegadas e se calcula o atraso total da rua, de
acordo com a variável m criada
%ATRASO MAIN


normalizado_main= ncarros_saem_main(length(ncarros_saem_main));
for M=1:normalizado_main; %M vai de 1 até a ultima saída da rua
    atraso_main(M)= saida_main(M)-chegada_main(M);
end

atraso_total_main=sum(atraso_main);


%ATRASO ELM
%Para se calcular o atraso na rua Elm, utilizou-se a mesma lógica do
atraso em main.
%A única diferença foi a variável utilizada(E).

normalizado_elm= ncarros_saem_elm(length(ncarros_saem_elm));
for E=1:normalizado_elm;
    atraso_elm(E)= saida_elm(E)-chegada_elm(E);
end
atraso_total_elm=sum(atraso_elm);


%ATRASO TOTAL MÉDIO
%Primeiramente, fez-se a soma entre os atrasos totais de elm e main.
%Depois, foi feita uma média desses atrasos, o que aparece em segundos.
atraso_elm_e_main(K)=atraso_total_elm + atraso_total_main; %O K é o mesmo
do início do programa (linha 2)

end

%Os atrasos totais aparecem aqui para que seja gerado somente um valor

atraso_total_elm = mean(atraso_total_elm)
atraso_total_main = mean(atraso_total_main)
atraso_medio= mean(atraso_elm_e_main) %em segundos

%ATRASO TOTAL EM HORAS

atraso_em_horas= (atraso_medio)/3600 %transformando o atraso em horas

% GRÁFICO
%Código para Plotar o Gráfico de Carros x Tempo nas duas ruas

plot(chegada_elm,ncarros_chegam_elm,'k') , hold on; %chegadas elm
plot(saida_elm,ncarros_saem_elm), hold on; %saidas elm
plot(chegada_main,ncarros_chegam_main), hold on; %chegadas main
plot(saida_main,ncarros_saem_main), hold off; %saidas main
title('Gráfico de Carros por Tempo nas duas ruas');
    xlabel('Tempo');
    ylabel('Carros');
    axis ([0 950 0 300]);
    legend('\color{orange}Rua Elm','\color{blue}Rua Main');
end