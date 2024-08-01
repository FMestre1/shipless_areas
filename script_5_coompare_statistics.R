################################################################################
#                       Ship density vs other variables
################################################################################

#VBastazini
#01-08-2024

library(MASS)

y=rbind(mpa,mpa)
level_1 <- rep(1, length(mpa))
level_2 <- rep(2, length(nmpa))

# Combinar  vetores
combined_vector <- c(level_1, level_2)

# Converter fator
factor_vector <- factor(combined_vector, levels = c(1, 2))
ymg = tapply(y,x,mean);ymg
# variância
variancia =tapply(y,x,var);variancia



# número de observações em cada sitio (np)
#número total de observações (n) 
#número de níveis do fator “sitio” (niveis):
np = tapply(y,x,length)
n = sum(np)
niveis = length(np)
#cálculo da variância (Se2) 
#matriz diagonal (Vμ), 
s2hat <- sum((np-1)*variancia)/(n-niveis)
Vmu <- diag(1/np)
#Para a simular da distribuição posterior, definimos quantidade de amostras desejada
m = 5000
# amostra da precisão
tau <- rgamma(m,(n-niveis)/2,s2hat*(n-niveis)/2)
# amostra do desvio padrão (σ)
sigma <- sqrt(1/tau)
med.post <- numeric()
# calculo da média posterior
for(i in 1:m) med.post <- rbind(med.post,mvrnorm(1,as.numeric(ymg),Vmu/tau[i]))
#Um exemplo de sumário estatístico para a amostra da posterior do desvio padrão (σ) seria:
c(quantile(sigma,prob=c(0.025,0.5,0.975)),media=mean(sigma),dp=sd(sigma))
#intervalo de credibilidade (ICr95%) compreende então valores entre 1.46 e 3.18. 
#Sumários estatísticos para os efeitos dos quatro níveis do fator “sitio”
for(i in 1:ncol(med.post)) {print(c(quantile(med.post[,i],prob=c(0.025,0.5,0.975)),  media=mean(med.post[,i]),dp=sd(med.post[,i]))) }
# Distribuição posterior.
plot(density(med.post[,1]),xlab="Protected areas",ylab= "Density", main="")
lines(density(med.post[,2]),lwd=3,col="red")
#A probabilidade de que μ2 seja maior que μ1 equivale a:
sum(med.post[,1]>med.post[,2])/m
legend("topright",pch=15,c("MPA ","Non MPA"),col=c("black","red"))