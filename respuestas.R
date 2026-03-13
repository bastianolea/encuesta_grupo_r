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
  filter(contacto == "si") |> 
  select(-starts_with("time")) |> 
  select(nombre:areas)
  # select(-session_id:current_page)
  # select(time_end, nombre:areas, -sector) |> 
  # mutate(time_end = lubridate::as_datetime(time_end)) |> 
  # arrange(desc(time_end))

glimpse(resultados)

resultados |> count(nivel)
resultados |> count(frecuencia)
resultados |> count(region)
resultados |> count(asistencia)

resultados |> count(genero)

resultados |> 
  filter(region != "fuera_de_chile") |> 
  filter(frecuencia != "rara_vez") |> 
  pull(correo) |> 
  unique() |> 
  paste(collapse = ", ") |> 
  writeLines("~/Downloads/resultados_grupo_r.txt")

# readr::write_csv2(resultados, 
                  # "~/Downloads/resultados_grupo_r.csv")
