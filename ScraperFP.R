#Web scraoing fernando pessoa
library(dplyr)
library(tidyverse)
library(rvest)

valid_url <- function(url_in,t=2){
  con <- url(url_in)
  check <- suppressWarnings(try(open.connection(con,open="rt",timeout=t),silent=T)[1])
  suppressWarnings(try(close.connection(con),silent=T))
  ifelse(is.null(check),TRUE,FALSE)
}

columns <- c("ID","Autor","Titulo","Tipo","Corpo","Data","Biblio")
FPDataset = data.frame(matrix(nrow=0, ncol=length(columns)))
colnames(FPDataset) <- columns

for(i in 1:5000){
  url <- paste0("http://arquivopessoa.net/textos/",i)
  if(valid_url(url)){
    html <- read_html(url)
    autor <- html |> html_element(".autor") |> html_text2()
    titulo <- html |> html_element(".titulo-texto") |> html_text2()
    if(is.na(html |> html_element(".texto-poesia"))){
      tipo <- "prosa"
      corpo <- html |> html_element(".texto-prosa") |> html_text2()
    } else {
      tipo <- "poesia"
      corpo <- html |> html_element(".texto-poesia") |> html_text2()
    }
    data <- html |> html_element(".data") |> html_text2()
    biblio <- html |> html_element(".biblio") |> html_text2()
    FPDataset[nrow(FPDataset)+1,] <- c(i,autor,titulo,tipo,corpo,data,biblio)
  }
}

write.csv(FPDataset,"FPDataset.csv")
