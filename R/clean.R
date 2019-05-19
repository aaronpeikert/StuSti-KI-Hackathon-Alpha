if(!require("pacman"))install.packages("pacman")
pacman::p_load("tidyverse")

#----clean----
mach %>% select(-matches("\\d[E|I]$")) -> mach
mach %>% rename(Q3I = Q3A, 
                Q4I = Q4A,
                Q6I = Q6A,
                Q7I = Q7A,
                Q9I = Q9A,
                Q10I = Q10A,
                Q11I = Q11A,
                Q14I = Q14A,
                Q16I = Q16A,
                Q17I = Q17A) -> mach

mach %>% mutate(major = str_to_lower(major), 
                gender = recode_factor(gender, "1" = "m", "2" = "f", "3" = "o"),
                psy = str_detect(major, "psych") %>% ifelse(is.na(.), FALSE, .)) -> mach

mach %>% mutate_at(vars(matches("^Q\\d*I$")), ~6 - .) %>%
  mutate(., mach = rowMeans(select(., starts_with("Q")))) -> mach
