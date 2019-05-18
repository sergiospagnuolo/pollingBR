# Check if state's acronyms were written correctly

check_uf <- function(state) {

  # Inputs
  uf <- toupper(state)

  # UFs
  ufs <- uf_initials()

  # Test
  if(!all(is.character(uf)) | !all(nchar(uf) == 2) | !all(uf %in% ufs))
    stop("Check the input in the \"state\" argument.")

  # Return
  uf
}

# Create vector with all state's acronyms

uf_initials <- function(){

  uf_initials <- c("AC", "AL", "AP", "AM", "BA", "BR", "CE",
                   "DF", "ES", "GO", "MA", "MT", "MS", "MG",
                   "PA", "PB", "PR", "PE", "PI", "RJ", "RN",
                   "RS", "RO", "RR", "SC", "SP", "SE", "TO")

  return(uf_initials)

}

# Extract data

extract_data_api <- function(id, year){

  message("\nExtracting data from Poder 360's API of electoral polls.\n...\n")

  poder360_request <- httr::GET("https://pesquisas.poder360.com.br/api/consulta/fetch/",
            httr::add_headers(Authorization = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI3YzdhMDE4YmYyNGRkZTZiM2UwMGY5NTFmY2FlOGM0ZWEzNmY0MjJlMmNkZWMwNTgyM2MxMWFmNzU5YzdmNTg5NDgzZjI1ZTkzN2M0ZjRkIn0.eyJhdWQiOiIxIiwianRpIjoiYjdjN2EwMThiZjI0ZGRlNmIzZTAwZjk1MWZjYWU4YzRlYTM2ZjQyMmUyY2RlYzA1ODIzYzExYWY3NTljN2Y1ODk0ODNmMjVlOTM3YzRmNGQiLCJpYXQiOjE1NTQ3NjA1MjQsIm5iZiI6MTU1NDc2MDUyNCwiZXhwIjoxNTg2MzgyOTI0LCJzdWIiOiI0OCIsInNjb3BlcyI6W119.D1qzGAQMxgR90he_O8IvNFkuJncQUXXDTSiQQ_9QbU8L8_bQ9-Li2FxaMFD1JCcPoz1RmZviSwHWLIUL6zcp2va8g6DYPY92DdretkPN2LZqWacyx6yzUDhfatkcS2plfhH8bjHTbDr9OAA8frJI6GvfhQwu-LOdRjx1nZD1OOBZRt9Xq4Lrlti_c7QuQuMqrUq53iCTCYqW5jnljFkrqYnEPMGQQdfH9K5RujsQR__TvcxwzkSdXkeW0A0TkMwt4PKt5Ag0KWddax1P8T_QV6wBqzLO2bJNyh1P0ZTYuqFGvNeG0NmxgdAWrXdDiH5eeZK_ye8MtqHI8T_lH3BQElWwQ_xqxs8RKafeugqF5X2RG0qkON3oklDqY4MU46I8UOT1ipkhVv3WRq5v-uOku-lVweC1ZBjXKyJi4G_v5thgVF5QnDRUcSbgk5DvpY6EUSJDqOaC6HVX5uJ2F4vXoThZCpiCV3ATXg7Qzm3-7zeRk6mY5dKUqboYYBIOe8hjMN4he_BYbsYxhkDUM0rmkpqFZ8iXvPH2XzxEgOyq_zmtdNXoKUC1_WCM9HhjmFnMNK5b8AmKHmo4sZpEH-5FRL4uA22bqVkx4hY9tEu6fQ_jjZGarATG4rLeP_CqCuciM14zURDl3Cu1tcn96XbpsIYVn8yd-UL9ctuvbSiJZLI"),
            query = list(cargos_id = id, ano = year))

  poder360_request_data <- httr::content(poder360_request, as = "text", encoding = "utf8")

  banco <- jsonlite::fromJSON(poder360_request_data)

  message("Done.")

  return(banco)

}

# Tests election year inputs

test_federal_year <- function(year){

  if(!is.numeric(year) | !year %in% seq(2002, 2018, 4)) stop("Invalid input in the argument \"year\". \nFor the president() and governor() functions, \"year\" should be equals to 2002, 2006, 2010, 2014 or 2018.")
}

test_mayor_year <- function(year){

  if(!is.numeric(year) | !year %in% seq(2000, 2016, 4)) stop("Invalid input in the argument \"year\". \nFor the mayor() function, \"year\" should be equals to 2000, 2004, 2008, 2012 or 2016.")
}

test_senator_year <- function(year){

  if(!is.numeric(year) | !year %in% seq(2006, 2018, 4)) stop("Invalid input in the argument \"year\". \nFor the senator() function, \"year\" should be equals to 2006, 2010, 2014 or 2018.")
}
