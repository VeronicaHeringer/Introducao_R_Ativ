# EXERCÍCIO DO MÓDULO 2 - APLICAÇÃO DE OPERAÇÕES ESPACIAIS

# BARRAGENS

# Carregar pacotes
library(sf)
library(geobr)
library(dplyr)

# 1- A mesorregião Jequitinhonha contém barragens?

# Carregar o shape das barragens
barra= read_sf('Barragens_MG.shp')
plot(barra$geometry)

# Carregar a região 
estados= read_state()

# Filtrar estados para MG
mg= estados %>% filter(abbrev_state == 'MG')
mg
plot(mg$geom)
plot(barra$geometry, add=T)

# Filtrar a mesorregião de Jequitinhonha
meso = read_meso_region()

meso_mg = meso %>% filter(abbrev_state == 'MG')

jequi = meso_mg %>% filter(name_meso == 'Jequitinhonha')
jequi

st_contains(jequi, barra, sparse = F)
plot(jequi$geom)
plot(barra$geometry, add=T)

#2- A mesorregião Triangulo Moneiro/Alto Paranaiba contém barragens?
triang = meso_mg %>% filter(name_meso == 'Triângulo Mineiro/Alto Paranaíba')
triang
plot(triang$geom)
plot(barra, add=T)
st_contains(triang, barra, sparse = F)

#3- A região do Triangulo Mineiro/Alto Paranaiba intercepta MG?
st_intersects(triang, mg, sparse = F)
plot(mg$geom)
plot(triang$geom, add=T)

# 4- Quais as microrregiões de MG contém barragens?

micro = read_micro_region()
micro_mg = micro %>% filter(abbrev_state == 'MG')
mmg =st_contains(micro_mg, barra, sparse = T)

# 5- A barragem de Tres Marias está contida na mesorregiao Norte de Minas?
barra
tres= barra %>% filter(BAR_NM=='Três Marias')
nortemg = meso_mg %>% filter(name_meso == 'Norte De Minas')
st_within(tres, nortemg, sparse = F)
plot(nortemg$geom, add=T)
plot(tres$geometry, add=T)

# 6- A mesorregião Zona da Mata toca a mesorregião Norte de Minas?
zmata = meso_mg %>% filter(name_meso == 'Zona Da Mata')
st_touches(zmata, nortemg, sparse = T)
plot(zmata$geom, add=TRUE)
plot(nortemg$geom, add=T)
