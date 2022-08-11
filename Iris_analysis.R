#---
# Title: Analysis of the Iris dataset
# Author : John Dalton Cannizzo
# Date: 
Sys.Date()
#---

library(tidyverse)
library(broom)
library(gghighlight)
#install.packages("GGally")
library(GGally)
# using iris dataset loaded in these packages
?iris
glimpse(iris)
# 4 dbl cols and 1 fct "species"

#see all combos:
  ggpairs(iris, columns = 1:4, legend = 1, aes(color = Species, alpha = 0.5),
          upper = list(continuous = "points"))+
  theme(legend.position = "bottom")
  
# viz it with Sepals
sepal_lw <- ggplot(iris, aes(y=Sepal.Length, x=Sepal.Width))+
              geom_point()

#faceted by Species:
sepal_lw+
  facet_wrap(~Species)


# trends apparent right away:
# in general for irises as sepal width increases, sepal length decreases
sepal_lw+
  geom_smooth(method = "lm")

#overlaid and colored of Sepal L & W:
sepal_lw_s <- ggplot(iris, aes(y=Sepal.Length, x=Sepal.Width, color=Species))+
  geom_point()

# unlike the overall trend each species has a positive s.length <> s.width correlation, 
# simpson's paradox:
sepal_lw_s +
  geom_smooth( method="lm" )

# Now with Petals
# overlaid and colored of Petal L & W:
petal_lw <- ggplot(iris, aes(y=Petal.Length, x=Petal.Width, color=Species))+
  geom_point()




      
