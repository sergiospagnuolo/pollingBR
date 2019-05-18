#' Get names of cities polled for mayor
#'
#' \code{get_cities()} extracts the names for all the cities with corresponding
#' polls for mayor in Poder 360's poll agreggator API
#' (\url{https://www.poder360.com.br/pesquisas-de-opiniao/api/}). The function
#' returns a \code{data.frame} where each observation corresponds to a
#' combination of city and election year for which there's a poll available.
#'
#'
#' @return \code{data.frame} with information from cities in which there are
#'   polls for mayoral elections in Brazil and the corresponding years for
#'   which they are available.
#'
#'   \itemize{
#'   \item ano: election year to which the pool corresponds to.
#'   \item cidade: city where the poll was conducted.
#'   \item unidade_federativa_nome: federative unit where the city is in.
#'   \item ambito: acronym of the federative unit where the city is in.
#'   }
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' # returns a data.frame with all combinations of cities and the election
#' # years for which they have mayoral polls available
#' df <- get_cities()

get_cities <- function(){

  cities <- NULL

  message("Extracting data from Poder 360's API of electoral polls.
           \n...
           \nPlease wait")

  for(i in seq(2000, 2016, 4)){

  banco <- suppressMessages(extract_data_api(id = 2, year = i))
  banco <- banco %>%
    dplyr::select(.data$cidade,
                  .data$cidade,
                  .data$unidade_federativa_nome,
                  .data$ambito,
                  .data$ano) %>%
    dplyr::distinct()

  cities <- rbind.data.frame(cities, banco)

  }

  cities <- cities %>%
    dplyr::arrange(.data$unidade_federativa_nome, .data$cidade, .data$ano) %>%
    dplyr::mutate(cidade = ifelse(.data$cidade == "Macaubas", "Macaúbas", .data$cidade),
                  cidade = ifelse(.data$cidade == "Cachoeiro do Itapemirim", "Cachoeiro de Itapemirim", .data$cidade),
                  cidade = ifelse(.data$cidade == "Cachoeiro de Itaperimim", "Cachoeiro de Itapemirim", .data$cidade),
                  cidade = ifelse(.data$cidade == "Anapolis", "Anápolis", .data$cidade),
                  cidade = ifelse(.data$cidade == "São Luis", "São Luís", .data$cidade),
                  cidade = ifelse(.data$cidade == "Tucurui", "Tucuruí", .data$cidade),
                  cidade = ifelse(.data$cidade == " Paranavaí", "Paranavaí", .data$cidade),
                  cidade = ifelse(.data$cidade == "Cascavél", "Cascavel", .data$cidade),
                  cidade = ifelse(.data$cidade == "São João do Meriti", "São João de Meriti", .data$cidade),
                  cidade = ifelse(.data$cidade == "Criciuma", "Criciúma", .data$cidade),
                  cidade = ifelse(.data$cidade == "Santa Bárbara D`Oeste", "Santa Bárbara d'Oeste", .data$cidade),
                  cidade = ifelse(.data$cidade == "São Bernando do Campo", "São Bernardo do Campo", .data$cidade),
                  cidade = ifelse(.data$cidade == "Aracajú", "Aracaju", .data$cidade),
                  ambito = ifelse(.data$cidade == "Feira de Santana", "BA", .data$ambito),
                  unidade_federativa_nome = ifelse(.data$cidade == "Feira de Santana", "Bahia", .data$unidade_federativa_nome)) %>%
    dplyr::filter(!grepl(" Zona Eleitoral", .data$cidade)) %>%
    dplyr::distinct()

  message("\nDone.")

  return(cities)
}
