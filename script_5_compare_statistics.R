################################################################################
#                       Ship density vs other variables
################################################################################

#VBastazini
#01-08-2024

#Load package
library(MASS)

#################################### NOT USED ##################################

#Load
load("/media/jorgeassis/FMestre/shipless_areas/mpa_corrected_extract_values_noNA.RData")
load("/media/jorgeassis/FMestre/shipless_areas/ebsa_extract_values_noNA.RData")
load("/media/jorgeassis/FMestre/shipless_areas/non_ebsa_extract_values_noNA.RData")
load("/media/jorgeassis/FMestre/shipless_areas/non_mpa_extract_values_noNA.RData")

mpa <- mpa_corrected_extract_values_noNA
nmpa <- non_mpa_extract_values_noNA
ebsa <- ebsa_extract_values_noNA
nebsa <- non_ebsa_extract_values_noNA

summary(mpa)
summary(nmpa)
summary(ebsa)
summary(nebsa)

rm(mpa_corrected_extract_values_noNA, non_mpa_extract_values_noNA,
   ebsa_extract_values_noNA, non_ebsa_extract_values_noNA)

################################################################################
#                               MPA - NON-MPA
################################################################################

y <- c(mpa,nmpa)
level_1 <- rep(1, length(mpa))
level_2 <- rep(2, length(nmpa))

# Combine  vectors
combined_vector <- c(level_1, level_2)

# Convert factor
factor_vector <- factor(combined_vector, levels = c(1, 2))
mean_mpa <- tapply(y,factor_vector,mean);mean_mpa

# Variance
variance <- tapply(y,factor_vector,var);variance

# number of observations in each group (np)
# total number of observations (n) 
# number of levels of the factor “group” (levels):
np <- tapply(y,factor_vector,length)
n <- sum(np)
levels1 <- length(np)
# variance calculation (Se2) 
# diagonal matrix (Vμ), 
s2hat <- sum((np-1)*variance)/(n-levels1)
Vmu <- diag(1/np)

#To simulate the posterior distribution,
#we define the quantity od desired samples
m = 5000

# amostra da precisão
tau <- rgamma(m,(n-levels1)/2,s2hat*(n-levels1)/2)

# amostra do desvio padrão (σ)
sigma <- sqrt(1/tau)
med.post <- numeric()

# calculo da média posterior
for(i in 1:m) med.post <- rbind(med.post,mvrnorm(1,as.numeric(mean_mpa),Vmu/tau[i]))
#Um exemplo de sumário estatístico para a amostra da posterior do desvio padrão (σ) seria:
c(quantile(sigma,prob=c(0.025,0.5,0.975)),media=mean(sigma),dp=sd(sigma))
#intervalo de credibilidade (ICr95%) compreende então valores entre 1.46 e 3.18. 
#Sumários estatísticos para os efeitos dos quatro níveis do fator “sitio”
for(i in 1:ncol(med.post)) {print(c(quantile(med.post[,i],prob=c(0.025,0.5,0.975)),  media=mean(med.post[,i]),dp=sd(med.post[,i]))) }
# Distribuição posterior.

#Plot
plot(density(med.post[,1]),xlab="Protected areas",ylab= "Density", main="", xlim=c(40,180), ylim=c(0,1))
lines(density(med.post[,2]),lwd=3,col="red")
#A probabilidade de que μ2 seja maior que μ1 equivale a:
sum(med.post[,1]>med.post[,2])/m
legend("topright",pch=15,c("MPA","Non MPA"),col=c("black","red"))

################################################################################
#                              EBSA - NON-EBSA
################################################################################

y2 <- c(ebsa,nebsa)
level_1_2 <- rep(1, length(ebsa))
level_2_2 <- rep(2, length(nebsa))

# Combine  vectors
combined_vector2 <- c(level_1_2, level_2_2)

# Convert factor
factor_vector2 <- factor(combined_vector2, levels = c(1, 2))
mean_ebsa <- tapply(y2,factor_vector2, mean);mean_ebsa

# Variance
variance2 <- tapply(y2,factor_vector2,var);variance2

# number of observations in each group (np)
# total number of observations (n) 
# number of levels of the factor “group” (levels):
np2 <- tapply(y2,factor_vector2,length)
n2 <- sum(np2)
levels2 <- length(np2)
# variance calculation (Se2) 
# diagonal matrix (Vμ), 
s2hat2 <- sum((np2-1)*variance2)/(n2-levels2)
Vmu2 <- diag(1/np2)

#To simulate the posterior distribution,
#we define the quantity od desired samples
m = 5000

# amostra da precisão
tau2 <- rgamma(m,(n2-levels2)/s2hat2*(n2-levels2)/2)

# amostra do desvio padrão (σ)
sigma2 <- sqrt(1/tau2)
med.post2 <- numeric()

# calculo da média posterior
for(i in 1:m) med.post2 <- rbind(med.post2, mvrnorm(1,as.numeric(mean_ebsa),Vmu2/tau2[i]))
#Um exemplo de sumário estatístico para a amostra da posterior do desvio padrão (σ) seria:
c(quantile(sigma2,prob=c(0.025,0.5,0.975)),media=mean(sigma2),dp=sd(sigma2))
#intervalo de credibilidade (ICr95%) compreende então valores entre 1.46 e 3.18. 
#Sumários estatísticos para os efeitos dos quatro níveis do fator “sitio”
for(i in 1:ncol(med.post2)) {print(c(quantile(med.post2[,i],prob=c(0.025,0.5,0.975)),  media=mean(med.post2[,i]),dp=sd(med.post2[,i]))) }
# Distribuição posterior.

#Plot
plot(density(med.post2[,1]),xlab="EBSA",ylab= "Density", main="", xlim=c(0,180), ylim=c(0,1))
lines(density(med.post2[,2]),lwd=3, col="red")
#A probabilidade de que μ2 seja maior que μ1 equivale a:
sum(med.post2[,1]>med.post2[,2])/m
legend("topright",pch=15,c("EBSA","Non EBSA"),col=c("black","red"))
