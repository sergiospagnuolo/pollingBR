# Introduction to pollingBR

*May, 2019*

`pollingBR` was created to give an easier access to data from the [data repository of electoral polls from Poder360's news website](https://www.poder360.com.br/pesquisas-de-opiniao/api/). The package facilitates extraction of information from the open data API - developed by [Volt Data Lab](https://www.voltdata.info/) - of this repository.

The data has been compiled by Brazilian journalist Fernando Rodrigues and his team for several years and has been the richest repository of polling data in the country. 

The package has **four** main functions, all with similar arguments. Each of them correspond to one of the offices for which there are electoral polls in the data repository:

* `president()` for polls to the Presidency;
* `governor()` for polls to the Governorship of the 26 Brazilian states and its Federal District;
* `senator()` for polls to Senatorial seats of the 26 Brazilian states and its Federal District;
* `mayor()` for polls to Mayor in more than 200 Brazilian cities.

Besides those main functions, the package also includes:

* `get_cities()` that returns a `data.frame` containing the complete list for cities in which there are polls for mayoral elections in Brazil and the corresponding years for which they are available.

## Instalando e carregando o pacote

No momento, o pacote `pollingBR` pode ser instalado diretamente da sua página no github:

```{r, eval = FALSE}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("voltdatalab/pollingBR")
```

Assim como os demais pacotes em R, uma vez instalado, ele deve ser carregado com a função `library()`.

```{r, message=FALSE}
library(pollingBR)
```

## Main functions

Those four functions that extract estimates of electoral polls for president, governor, senator and mayor have a similar basic structure. All of them return a `dataframe` in which each line has the estimate for a candidate in a certain electoral poll. They have four arguments: `year`, `state`, `type` and `round` (except for the `senator()` which does not include this last one).

* The `year` argument should *always* be specified and informs the election year for which the user wishes to extract polls.

```{r, message=FALSE}
# Extract data for all polls presidential polls in the 2018 elections
president_2018 <- president(2018)
# Get data for all gubernatorial polls in the 2014 elections
governor_2014 <- governor(2014)
```

* The `state` argument indicates the geographical level the poll is representative of. The default returns polls for all states and cities (besides the national-level polls, in the presidential elections (`state = "ALL"`). The user can specify only one or a few states by using their acronyms (or filter only by national-level polls, in the case of the `president()` function, using the `"BR"` acronym).

```{r, message=FALSE}
# Extract data for all national-level polls for president in 2014
president_br_2014 <- president(2014, state = "BR")
# Get data for all senatorial polls in Brazilian southern states in 2010
senate_south_2010 <- senator(2010, state = c("RS", "SC", "PR"))
```

* The `type` argument designates the type of response the estimate corresponds to: spontaneous (1), stimulated (2) or rejection (3). Default (`type = c(1, 2, 3)`) returns estimates for all three possibilites (usually, results reported by the Brazilian media are from *stimulated* responses). _Stimulated_ responses are those in which voters are asked to choose from a list of candidates; _spontaneous_ are those in which voters answer without getting any information from the interviewer on candidates' names; (3) _rejection_ are answers on a candidate's rejection (and not vote intention). The user can specify only one or more possibilities of responses.

```{r, message=FALSE}
# Obtem dados de respostas espontaneas e estimuladas para pesquisas para o senado em SP no ano de 2006
senate_sp_2006 <- senator(2006, state = "SP", type = c(1, 2))
# Extrai dados de respostas de rejeicao em pesquisas nacionais para presidente em 2018
president_rejection_2018 <- president(2018, state = "BR", type = 3)
```

* The `round` argument registers if the extracted data are from the first or second round of the elections (default returns estimates for both rounds - `round = c(1, 2)`). Senatorial elections are disputed in only one orund, so the `senator()` function does not include this optional argument.

```{r, message=FALSE}
# Extract data from all stimulated responses for polls in the first round of mayoral elections in 2012
mayor_2012_1r <- mayor(2012, type = 2, round = 1)
```

## Other functions

The `get_cities()` function returns a `data.frame` with a complete list of the cities with mayoral electoral polls in Poder360's data repository, accompanied by the election years for which they are available. Thus, users have an easier access to which municipal polls are available for them.

In the following example, we can see the first six lines of this data frame, showing that there are polls available for the mayoral races in the cities of Cruzeiro do Sul (only in 2008) and Rio Branco (in the election years between 2000 and 2016).

```{r, message=FALSE}
cities_polls <- get_cities()
head(cities_polls)
```
