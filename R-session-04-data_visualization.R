## --------------------------------

library("readxl") # Import the data from Excel file

library("dplyr")  # filter and reformat data frames

library("ggplot2") # graphics

## ------------------------------------------------------------------------
samples <- readxl::read_excel("data/CARBOM data.xlsx", 
                         sheet = "Samples_boat") %>% 
           tidyr::fill(station)

## --------
 ggplot(data=samples, mapping = aes(x=phosphates, y=nitrates)) + 
  geom_point()

## --------
 ggplot(samples, aes(x=phosphates, y=nitrates)) + 
  geom_point()

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates), size=5)

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,color=level), size=5) 

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,color=depth), size=5) 

## --------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,
                           color=depth, shape=transect), size=5) 

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,
                           color=depth, shape=as.character(transect)), size=5) 

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates)) +
  facet_wrap(~ level) 

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,color=level), size=5) +
  geom_smooth(mapping = aes(x=phosphates, y=nitrates), method="lm")

## -------------------
 ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,color=level), size=5) +
  geom_smooth(mapping = aes(x=phosphates, y=nitrates), method="lm") +
  xlab("Phosphates") + ylab("Nitrates") + ggtitle("CARBOM cruise")

## -------------------
 g1 <- ggplot(samples) + 
  geom_point(mapping = aes(x=phosphates, y=nitrates,color=level), size=5) +
  geom_smooth(mapping = aes(x=phosphates, y=nitrates), method="lm") +
  xlab("Phosphates") + ylab("Nitrates")
 g1

## -------------------
 g2<- ggplot(samples) + 
  geom_point(mapping = aes(x=nanoeuks, y=picoeuks,color=level), size=5) +
  geom_smooth(mapping = aes(nanoeuks, y=picoeuks), method="lm") +
  xlab("Pico-eukaryotes") + ylab("Nano-eukaryotes") 
 g2

## -------------------

cowplot::plot_grid(g1, g2, nrow = 2, labels = c("A", "B") ) 


