#Visualização dos dados
library(dplyr)

poemas <- read.csv("FPDataset.csv",T)[,-1]

poemas %>% count(Autor)

pie((poemas %>% count(Autor))$n,(poemas %>% count(Autor))$Autor)

poemas <- poemas %>%
  filter(Autor != "Fernando Pessoa")

poemas %>% count(Autor)

pie((poemas %>% count(Autor))$n,(poemas %>% count(Autor))$Autor)

poemas <- poemas %>%
  group_by(Autor) %>%
  filter(n() >= 90) %>%
  filter(Autor != "Alexander Search")

pie((poemas %>% count(Autor))$n,(poemas %>% count(Autor))$Autor)

poemas %>% count(Autor)
