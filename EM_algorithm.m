%设置θ初始值
mu_male = 175; %μ
sigma_male = 10; %σ
weight_male = 0.8; %π

mu_female = 165;
sigma_female = 10;
weight_female = 0.2;

filename = 'C:/Users/pyx117/OneDrive/桌面/Demo/height_data.csv';
height = csvread(filename,1);


N = 2000;
loop_num = 200; %迭代次数
omega_male = zeros(1,N);
omega_female = zeros(1,N);

for j = 1 : loop_num
    %E-Step
    for i = 1: N
        p_male = weight_male*pdf('norm',height(i),mu_male,sigma_male);
        p_female = weight_female*pdf('norm',height(i),mu_female,sigma_female);
    
        omega_male(i) = p_male / (p_male + p_female);
        omega_female(i) = p_female / (p_male + p_female);
    end

    k1 = 0;
    k2 = 0;
    t1 = 0;
    t2 = 0;
    %M-Step
    for i = 1 : N
        k1 = k1 + omega_male(i)*height(i);
        k2 = k2 + omega_female(i)*height(i);
    end

    mu_male = k1 / sum(omega_male);
    mu_female = k2 / sum(omega_female);

    weight_male = sum(omega_male) / N;
    weight_female = sum(omega_female) / N;
    for i = 1 :N
        t1 = t1 + omega_male(i)*(height(i) - mu_male)^2;
        t2 = t2 + omega_female(i)*(height(i) - mu_female)^2;
    end
    sigma_male = sqrt(t1/sum(omega_male));
    sigma_female = sqrt(t2/sum(omega_female));

end
