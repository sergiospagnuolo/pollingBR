## ---- eval = FALSE-------------------------------------------------------
#  if (!require("devtools")) install.packages("devtools")
#  devtools::install_github("voltdatalab/pollingBR")

## ---- message=FALSE------------------------------------------------------
library(pollingBR)

## ---- message=FALSE------------------------------------------------------
# Extrai os dados para todas as pesquisas para presidente em 2018
president_2018 <- president(2018)

# Extrai os dados para todas as pesquisas para governador em 2014
governor_2014 <- governor(2014)

## ---- message=FALSE------------------------------------------------------
# Extrai dados de todas as pesquisas de abrangencia nacional para presidente em 2014
presidente_br_2014 <- president(2014, state = "BR")

# Obtem dados de todas as pesquisas para senador nos estados do sul do pais em 2010
senador_sul_2010 <- senator(2010, state = c("RS", "SC", "PR"))

## ---- message=FALSE------------------------------------------------------
# Obtem dados de respostas espontaneas e estimuladas para pesquisas para o senado em SP no ano de 2006
senado_sp_2006 <- senator(2006, state = "SP", type = c(1, 2))

# Extrai dados de respostas de rejeicao em pesquisas nacionais para presidente em 2018
presidente_rejeicao_2018 <- president(2018, state = "BR", type = 3)

## ---- message=FALSE------------------------------------------------------
# Extrai os dados de todas as respostas estimuladas de pesquisas para o primeiro turno de eleicoes para prefeito em 2012
prefeito_2012_1t <- mayor(2012, type = 2, round = 1)

## ---- message=FALSE------------------------------------------------------
cidades <- get_cities()
head(cidades)

