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
            httr::add_headers(Authorization = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY3M2U1YmMzNDFjMzBlNTJjMDQ4YzIwNTJhY2M1MTk3N2QxNDA5ZjM4YjlmYjM2MzMyNmUzZjRkMGM4NmRlNGY5MTYwNzE4M2IyMThlZmYzIn0.eyJhdWQiOiIxIiwianRpIjoiNjczZTViYzM0MWMzMGU1MmMwNDhjMjA1MmFjYzUxOTc3ZDE0MDlmMzhiOWZiMzYzMzI2ZTNmNGQwYzg2ZGU0ZjkxNjA3MTgzYjIxOGVmZjMiLCJpYXQiOjE1ODk5MTEzODgsIm5iZiI6MTU4OTkxMTM4OCwiZXhwIjoxNjIxNDQ3Mzg4LCJzdWIiOiI0OCIsInNjb3BlcyI6W119.cAT_Gq0BIQpGFR5kj5fjEecB70E1A3UdnwLmqNPFpvNj9dYzZZ8Wb0rqIbwgPYEA7iGeQJUW49EK2clRn1J2EPFykbfaEhDJ_9Avobo6rNRiYHZf6_Teh9l_-O9GGWbfma6iSdNB2Vh-sp67hs8ZcfQ0LeOyTRyzh-I3NYDxldc0I6O9haoemm8nW8ScOkt13l4NchKYEtNHYJqpqRfFHSxvi0hsBj2lcSEJ-aiIvtsutBw2SJGm_aNlLjsw_mDXbr5h1VC0PadBfcrcvg134vLJyswADvNiNrvZ_nC_wWnj2BpC-DV01sh2tDlthIfyhuP7qbSUmLdfYej6Gy2iYkGN3xE5M6h4W-2-j-oQ7IjnSWm3WGOCXUsRQ0cDX67vnRMQj7MNMIb_OGXMrPyjCa-fTBPO6-qPQX7nplxaNeMKp-BGYICeU6857CisCbl9bEI3DD0zKNk0RGAlJgAb2393DdJPmk1vH-8l4lZuFFZBoVH_W4AHgFl-JjYtUVJ9YMu0Azd5hCUSmtboIbAFXLUxdNAyOpneL9FLMOxgRgKL-UV6U_CzLyOPIrthCYpb7oJWq7h1cwPQhElVe9bEgo3F1wtWidiq_TR5_V2d8TrOzToLVjk7CgnwrOVOCfzdDgGSRd-vORTMpPTQP3-AW6jhcwIzPmV_jZyyvplFmtI"),
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

  if(!is.numeric(year) | !year %in% seq(2000, 2020, 4)) stop("Invalid input in the argument \"year\". \nFor the mayor() function, \"year\" should be equals to 2000, 2004, 2008, 2012 or 2016.")
}

test_senator_year <- function(year){

  if(!is.numeric(year) | !year %in% seq(2006, 2018, 4)) stop("Invalid input in the argument \"year\". \nFor the senator() function, \"year\" should be equals to 2006, 2010, 2014 or 2018.")
}
