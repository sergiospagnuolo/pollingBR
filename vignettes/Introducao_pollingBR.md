# Introdução ao pollingBR

*Maio de 2019*

O `pollingBR` foi criado para facilitar a utilização de dados contidos no [banco de dados de pesquisas eleitorais do site Poder360](https://www.poder360.com.br/pesquisas-de-opiniao/api/). O pacote facilita a extração de dados da API de dados abertos desse repositório, desenvolvida pelo [Volt Data Lab](https://www.voltdata.info/).

O pacote possui quatro funções principais, que possuem características semelhantes. Cada uma delas corresponde a um dos cargos cujas pesquisas constam no banco de dados:

* `president()` para as pesquisas eleitorais para Presidente da República;
* `governor()` para as pesquisas eleitorais para Governador dos 26 estados e do Distrito Federal (DF);
* `senator()` para as pesquisas para senador dos 26 estados e do DF;
* `mayor()` para pesquisas eleitorais para o cargo de Prefeito de diversas cidades brasileiras.

Além dessas funções principais, o pacote também inclui:

* `get_cities()` que lista todas as cidades encontradas no banco de dados com pesquisas eleitorais para prefeitos. 

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

## Funções principais

As quatro funções que extraem informações sobre pesquisas eleitorais para presidente, governador, senador e prefeito têm uma estrutura básica semelhante. Todas elas retornam um banco de dados (`dataframe`) que traz em cada linha a estimativa produzida para um candidato em certa pesquisa eleitoral.  Elas contêm quatro argumentos: `year`, `state`, `type` e `round` (com a exceção de `senator()` que não possui este último argumento).

* O argumento `year` (ano) indica o ano eleitoral ao qual as pesquisas buscadas se referem e *sempre* deve ser especificado.

```{r, message=FALSE}
# Extrai os dados para todas as pesquisas para presidente em 2018
president_2018 <- president(2018)
# Extrai os dados para todas as pesquisas para governador em 2014
governor_2014 <- governor(2014)
```

* O argumento `state` indica a abrangência territorial da pesquisa. De forma padrão, as funções retornam as pesquisas eleitorais em todos os estados ou cidades (além de todas as pesquisas de abrangência nacional, no caso de presidente da República). O usuário pode especificar somente algum(ns) estado(s) por meio da sua sigla (ou o país, no caso da função `president()`, cuja sigla é `"BR"`).

```{r, message=FALSE}
# Extrai dados de todas as pesquisas de abrangencia nacional para presidente em 2014
presidente_br_2014 <- president(2014, state = "BR")
# Obtem dados de todas as pesquisas para senador nos estados do sul do pais em 2010
senador_sul_2010 <- senator(2010, state = c("RS", "SC", "PR"))
```

* O argumento `type` indica o tipo de resposta da pesquisa: espontânea (1), estimulada (2) ou rejeição (3). De forma padrão, as funções retornam os resultados para as três possibilidades de resposta (vale lembrar que o resultado que usualmente vemos divulgado é o das respostas *estimuladas*). O usuário pode especificar uma ou mais possibilidades de respostas.

```{r, message=FALSE}
# Obtem dados de respostas espontaneas e estimuladas para pesquisas para o senado em SP no ano de 2006
senado_sp_2006 <- senator(2006, state = "SP", type = c(1, 2))
# Extrai dados de respostas de rejeicao em pesquisas nacionais para presidente em 2018
presidente_rejeicao_2018 <- president(2018, state = "BR", type = 3)
```

* Por fim, o argumento `round` registra se o banco de dados traz informações de pesquisas para o primeiro ou segundo turno das eleições (o padrão das funções retorna os dados para os dois turnos). Como as eleições para senador são de turno único, a função `senator()` não contém esse argumento.

```{r, message=FALSE}
# Extrai os dados de todas as respostas estimuladas de pesquisas para o primeiro turno de eleicoes para prefeito em 2012
prefeito_2012_1t <- mayor(2012, type = 2, round = 1)
```

## Outras funções

A função `get_cities()` retorna um `data.frame` com os registros de todas as cidades com pesquisas eleitorais para prefeitos encontradas no repositório de dados do Poder360, com os respectivos anos para os quais estão disponíveis. Dessa forma, o usuário tem acesso fácil a quais pesquisas municipais ele tem à sua disposição no repositório.

Abaixo, temos um exemplo das seis primeiras linhas desse banco de dados, registrando que estão disponíveis pesquisas para prefeito nos municípios de Cruzeiro do Sul (somente no ano de 2008) e Rio Branco (entre os anos eleitorais de 2000 a 2016).

```{r, message=FALSE}
cidades <- get_cities()
head(cidades)
```
