library(surveydown)
library(dplyr)

db <- sd_db_connect()

data <- sd_get_data(db) |> 
  tibble() |> 
  arrange(desc(time_end))

glimpse(data)

data |> 
  filter(!is.na(correo)) |> 
  count(nivel)

data |> 
  filter(!is.na(correo)) |> 
  count(frecuencia)

resultados <- data |> 
  filter(!is.na(correo)) |> 
  select(-starts_with("time"), time_end) |> 
  select(time_end, nombre:areas, -sector) |> 
  mutate(time_end = lubridate::as_datetime(time_end)) |> 
  arrange(desc(time_end))

resultados

resultados |> count(genero)

readr::write_csv2(resultados, 
                  "~/Downloads/resultados_grupo_r.csv")
