## ---- eval = FALSE-------------------------------------------------------
#  if (!require("devtools")) install.packages("devtools")
#  devtools::install_github("voltdatalab/pollingBR")

## ---- message=FALSE------------------------------------------------------
library(pollingBR)

## ---- message=FALSE------------------------------------------------------
# Extract data for all polls presidential polls in the 2018 elections
president_2018 <- president(2018)

# Get data for all gubernatorial polls in the 2014 elections
governor_2014 <- governor(2014)

## ---- message=FALSE------------------------------------------------------
# Extract data for all national-level polls for president in 2014
president_br_2014 <- president(2014, state = "BR")

# Get data for all senatorial polls in Brazilian southern states in 2010
senate_south_2010 <- senator(2010, state = c("RS", "SC", "PR"))

## ---- message=FALSE------------------------------------------------------
# Obtem dados de respostas espontaneas e estimuladas para pesquisas para o senado em SP no ano de 2006
senate_sp_2006 <- senator(2006, state = "SP", type = c(1, 2))

# Extrai dados de respostas de rejeicao em pesquisas nacionais para presidente em 2018
president_rejection_2018 <- president(2018, state = "BR", type = 3)

## ---- message=FALSE------------------------------------------------------
# Extract data from all stimulated responses for polls in the first round of mayoral elections in 2012
mayor_2012_1r <- mayor(2012, type = 2, round = 1)

## ---- message=FALSE------------------------------------------------------
cities_polls <- get_cities()
head(cities_polls)

