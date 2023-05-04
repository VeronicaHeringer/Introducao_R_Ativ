library(readxl)
library(dplyr)
library(readxl)
dados_IQA <- read_excel("dados_IQA.xlsx")
View(dados_IQA)

#EXERCÍCIOS
#1 - QUAL A ESTAÇÃO DA UPGRH DO2-RIO PIRACICABA TEVE O MENOR VALOR DE TURBIDEZ EM 2013?

D_1 = dados_IQA %>% filter(UPGRH == "DO2 - Rio Piracicaba") %>%
  filter(Ano == 2013) %>%
  arrange(Turbidez) %>%
  head(1)

  
#2 - QUAL ERA A TEMPERATURA DA ÁGUA MÉDIA EM CADA UPGRH ENTRE OS ANOS DE 2013 E 2015?

D_2 = dados_IQA %>% filter(Ano > 2013 & Ano < 2015) %>%
group_by(UPGRH) %>%
summarise(mean(Tem_agua))


#3 - QUAIS AS 5 ESTAÇÕES TEM A MAIOR CONCENTRAÇÃO DE OD EM TODOS OS ANOS JUNTOS?

D_3 = dados_IQA %>% group_by(estacao) %>%
  mutate(OD) %>%
  summarise(totalOD = sum(OD)) %>%
  arrange(desc(totalOD)) %>%
  head(5)

#4 - QUAIS AS 10 ESTAÇÕES TEM A CORRELAÇÃO + FORTE ENTRE ST A A TURBIDEZ?
dados_IQA <- read_excel("dados_IQA.xlsx")
View(dados_IQA)

D_4 = dados_IQA %>% group_by(estacao) %>%
  summarise(c = cor(ST, Turbidez), method = c('pearson')) %>%
  mutate_if(is.numeric, abs) %>%
  arrange(desc(c)) %>%
  head(10)
  
#5 - QUAIS 3 UPGRH TIVERAM A TEMPERATURA DO AR COM MENOR DESVIO PADRÃO AO LONGO
# DOS ANOS DA SÉRIE DE DADOS?

D_5 = dados_IQA %>% group_by(UPGRH) %>%
summarise(dp = sd(tem_ar)) %>%
  arrange(dp) %>%
  head(3)
