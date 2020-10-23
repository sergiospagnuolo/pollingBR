#' Extract data of Brazilian senatorial polls.
#'
#' \code{senator()} extracts data of Brazilian senatorial polls from the Poder
#' 360's poll agreggator API
#' (\url{https://www.poder360.com.br/pesquisas-de-opiniao/api/}). The function
#' returns a \code{data.frame} where each observation corresponds to a
#' candidate's estimate in a poll.
#'
#' @param year Election year (\code{integer}). The available years are 2006,
#'   2010, 2014, 2018.
#' @param state Initials in capital letters (\code{character}) of the state
#'   election polled. Default returns all senatorial polls for the
#'   corresponding election year (\code{state = "ALL"}).
#' @param type Number (\code{character}) indicating if the user wants the
#'   spontaneous (1), estimulated (2), or rejection (3) estimations of polls.
#'   Default returns all poll results (\code{type = c(1, 2, 3)}).
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
#'
#' @return \code{data.frame} with results from polls conducted for senatorial
#'   elections in Brazil, for the \code{year} specified, with the following
#'   variables:
#'
#'   \itemize{
#'   \item pesquisa_id: id number for each poll.
#'   \item ano: election year to which the poll corresponds to.
#'   \item unidades_federativas_id: id number for the federative unit where
#'     the poll was conducted.
#'   \item unidade_federativa_nome:  the name of the federative unit where
#'     the poll was conducted (if the poll was conducted on national-level,
#'     this variable assumes the value of "BRASIL").
#'   \item cargos_id: id number for the position polled.
#'   \item cargo: name of the position polled.
#'   \item tipo_id: id number for type of poll.
#'   \item tipo: type of poll.
#'   \item turno: indicates if election polled was a 1st round or
#'     2nd round one.
#'   \item data_pesquisa: poll date ("YYYY-MM-DD").
#'   \item instituto_id: id number for the institute which conducted the
#'     poll.
#'   \item instituto: name of the institute which conducted the poll.
#'   \item voto_tipo: indicates if the estimate relates to total votes
#'     ("Votos Totais") or valid votes ("Votos Válidos").
#'   \item cenario_id: id number for the candidates' scenario that was polled.
#'   \item cenario_descricao: description of the candidates' scenario that
#'     was polled.
#'   \item candidatos_id: candidate's id number.
#'   \item candidato_partido: candidate's name and party affiliation.
#'   \item candidato: candidate's name.
#'   \item ano_default: indicates the year-position that the candidate ran.
#'   \item condicao: indicate if it's a candidate (0) or a broad category
#'     (such as null and/or blank vote, would vote for all, etc.)
#'   \item percentual: vote estimate for the candidate in the poll, in
#'     percentage points.
#'   \item data_referencia: poll's reference date ("DD-DD.MM.YYYY")
#'   \item margem_mais: estimate of the poll's margin of error upper limit.
#'   \item margem_menos: estimate of the poll's margin of error lower limit.
#'   \item contratante: indicates who hired the poll.
#'   \item num_registro: poll's register number in the Brazilian Electoral
#'     Courts.
#'   \item orgao_registro: Brazilian Electoral Court where the poll was
#'     registered.
#'   \item qtd_entrevistas: number of interviews conducted in the poll
#'     (poll's sample size).
#'   \item partidos_id: candidate's party id number.
#'   \item partido: candidate's party abbreviated name.
#'   \item cidade: city where the poll was conducted.
#'   }
#'
#' @examples
#' # returns a data.frame with the results for all senatorial polls conducted
#' # in the 2018 elections
#' df <- senator(2018)
#'
#' # returns a data.frame with results for all polls for the first round of 2014
#' # Pernambuco's senatorial elections with candidates' rejection estimates
#' df <- senator(2014, state = "PE", type = 3)

senator <- function(year,
                     state = "ALL",
                     type = c(1, 2, 3)
){

  test_senator_year(year)

  if(state == "ALL"){

    state <- uf_initials()

  }else{

    check_uf(state)

  }

  banco <- extract_data_api(id = 4, year = year)

  banco %>%
    dplyr::filter(.data$ambito  %in% state,
                  .data$tipo_id %in% type)
}
