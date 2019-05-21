# pollingBR

`pollingBR` offers a set of functions to extract data from the API of [Poder 360's Brazilian electoral polls data repository](https://www.poder360.com.br/pesquisas-de-opiniao/api/), which contains polls from several institutes for presidential, gubernatorial, senatorial and mayoral elections since the 2000 elections.

The data has been compiled by Brazilian journalist Fernando Rodrigues and his team for several years and has been the richest repository of polling data in the country. 

## Installation

Currently, `pollingBR` can be installed directly from GitHub:

```
if (!require("devtools")) install.packages("devtools")
devtools::install_github("voltdatalab/pollingBR")
```

## Functions

The package has **four** main functions, all with similar arguments. Each of them correspond to one of the offices for which there are electoral polls in the data repository:

* `president()` for polls to the Presidency;
* `governor()` for polls to the Governorship of the 26 Brazilian states and its Federal District;
* `senator()` for polls to Senatorial seats of the 26 Brazilian states and its Federal District;
* `mayor()` for polls to Mayor in more than 200 Brazilian cities.

Users need to specify the election year (using the argument `year`) that they wish to obtain polls. 

```{r, eval=FALSE}
# Extract data from all polls for president in 2018

president_2018 <- president(2018)
```

They can also filter polls from a certain *geographical level* by specifying the argument `state`, *type* (spontaneous, stimulated or rejection estimates) - `type` -, and from which *round* (first or second) - `round`.

```{r, eval=FALSE}
# Extract data from first round polls for governor of Sao Paulo in 2014

governor_sp_2014 <- governor(2014, state = "SP", round = 1)

# Get data from spontaneous responses to polls for a senate seat in Minas Gerais in 2018

senator_mg_2018 <- senator(2018, state = "MG", type = 1)
```

Besides those four basic functions, `get_cities()` returns a `data.frame` containing the complete list for cities in which there are polls for mayoral elections in Brazil and the corresponding years for which they are available.

## More information

For more information on how the package works and for a complete list of functions, see the vignettes (in [English](https://github.com/voltdatalab/pollingBR/blob/master/vignettes/Introduction_pollingBR.md) and [Portuguese](https://github.com/voltdatalab/pollingBR/blob/master/vignettes/Introducao_pollingBR.md)).

## Authors

[Lucas Gelape](https://github.com/lgelape), for [Volt Data Lab](https://www.voltdata.info/).

## Contributors

[Sérgio Spagnuolo](https://github.com/voltdatalab), [Denisson Silva](https://github.com/silvadenisson) and [Fernando Meireles](https://github.com/meirelesff)
