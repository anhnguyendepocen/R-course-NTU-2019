## ----libraries, message= FALSE, warning=FALSE----------------------------

library("readxl") # Import the data from Excel file
library("readr")  # Import the data from Excel file

library("dplyr")  # filter and reformat data frames
library("tidyr")  # make data tidy

library("stringr") # manipulate strings
library("lubridate") # manipulate date 

library("ggplot2") # graphics

## ------------------------------------------------------------------------
  samples <- readr::read_tsv("data/CARBOM data.txt")

## ------------------------------------------------------------------------
  samples <- readxl::read_excel("data/CARBOM data.xlsx", 
                           sheet = "Samples_boat")

## ------------------------------------------------------------------------
  samples <- tidyr::fill(samples, station)

## ------------------------------------------------------------------------
  colnames(samples)

## ------------------------------------------------------------------------
  summary(samples$depth)

## ------------------------------------------------------------------------
samples_select <- dplyr::select(samples, transect, `sample number`,
                                 station, depth, latitude, longitude, 
                                 picoeuks, nanoeuks)

## ------------------------------------------------------------------------
  samples_select <- dplyr::select(samples, transect:nanoeuks)

## ------------------------------------------------------------------------
  samples_select <- dplyr::select (samples, -nitrates, -phosphates)

## ------------------------------------------------------------------------
  samples_select <- samples %>% dplyr::select(transect:nanoeuks)

## -------------------------------------------------------------------------
  samples_select <- samples %>% 
    dplyr::select(transect:nanoeuks)

## ------------------------------------------------------------------------
  samples <- samples %>% 
    dplyr::rename(sample_number = `sample number`)

## -------------------------------------------------------------------------
  samples <- samples %>% 
    dplyr::mutate(pico_pct = picoeuks/(picoeuks+nanoeuks)*100)

## -------------------------------------------------------------------------
  samples_select <- samples  %>% 
    dplyr::select(sample_number:nanoeuks, level) %>% 
    dplyr::mutate(pico_pct = picoeuks/(picoeuks+nanoeuks)*100)

## -------------------------------------------------------------------------
  samples <- samples %>% 
    dplyr::mutate(sample_label = str_c("TR",transect,"St",station, sep="_"))

## -------------------------------------------------------------------------
  samples <- samples %>% 
    dplyr::mutate(time = str_c(lubridate::hour(time), 
                               lubridate::minute(time), sep=":"))

## ------------------------------------------------------------------------
  samples <- samples %>% 
    dplyr::arrange(transect, station)

## -------------------------------------------------------------------------
  samples <- samples %>% 
    dplyr::mutate(station = as.numeric(station)) %>% 
    dplyr::arrange(transect, station)

## -------------------------------------------------------------------------
  samples_mean <- samples %>% 
    dplyr::group_by(transect, station) %>% 
    dplyr::summarise(n_samples = n(), 
              mean_pico_percent = mean(pico_pct, na.rm=TRUE))

## ------------------------------------------------------------------------
  samples_surf <- samples %>% 
    dplyr::filter(level == "Surf" ) 

## -------------------------------------------------------------------------
  sequences <- readxl::read_excel("data/CARBOM data.xlsx", 
                           sheet = "Samples_sequencing") 

## ---- echo=TRUE, tidy=TRUE-----------------------------------------------
  samples_select <- samples  %>% 
    dplyr::select(sample_number:longitude)

## ------------------------------------------------------------------------
  sequences_join <- left_join(sequences, samples_select)

## -------------------------------------------------------------------------
  sequences <- sequences %>% 
    rename(sample_code = sample_number)

## -------------------------------------------------------------------------
  sequences_join <- left_join(sequences, samples_select, 
                            by= c("sample_code" = "sample_number"))

## -------------------------------------------------------------------------
  samples_select <- samples_select %>% 
    filter(sample_number != "10")

## -------------------------------------------------------------------------
  sequences_join <- left_join(sequences, samples_select, 
                            by= c("sample_code" = "sample_number"))

## -------------------------------------------------------------------------
  samples_select <- samples  %>% 
    dplyr::select(sample_number:nanoeuks)

## -------------------------------------------------------------------------
  samples_long <- samples_select  %>% 
    tidyr::gather(key="population", value="cell_ml", picoeuks, nanoeuks)

## -------------------------------------------------------------------------
  samples_wide <- samples_long  %>% 
    tidyr::spread(key="population", value="cell_ml")

