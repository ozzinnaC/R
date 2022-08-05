# R_for_Data_Science
# exercises
# JDC, 8-5-22
# url: https://r4ds.had.co.nz/data-visualisation.html

library(tidyverse)
library(broom)
library(gghighlight)
#pg 14:

#displacement vs hwy faceted by both drivetrain & cyl
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# just plots of displacement vs hwy faceted by cylinders
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

# facet_wrap vs above.... plots of displacement vs hwy faceted by cylinders
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(. ~ cyl)

glimpse(mpg)


#exercise # 1:What happens if you facet on a continuous variable?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()+
  facet_grid(. ~ displ)
#answer = not good! impossible to read, 
#only facet by factors or discrete variables


#What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl), size = 25)
#drv at 4 has no 5 cyl & drv r has no 4 or 5 cyl 
# these are combinations that simply do not exist in the data. 
#DNE


#What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# are the slopes the same? 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color=year)) + 
  geom_point(data = . %>% filter(year==1999))+
  geom_smooth(method = "lm", se= FALSE, color="red")+
  geom_point(data = mpg %>% filter(year==2008))+
  geom_smooth(method = "lm", se= FALSE, color="blue")
#check cor for both:
coef_1999_cty_hwy <- mpg %>%
  filter(year == 1999)%>%
  lm(hwy ~ cty +0, data = .)%>%
  coef() #%>%
  #pluck(2)

coef_2008_cty_hwy <- mpg %>%
  filter(year == 2008)%>%
  lm(hwy ~ cty +0, data = .)%>%
  coef()#%>%
  #pluck(2)

bind_rows(coef_1999_cty_hwy, coef_2008_cty_hwy)%>%
  add_column("year" = c(1999, 2008))

ggplot(mpg, aes(cty, hwy, colour = factor(year))) +
  geom_point() + 
  gghighlight::gghighlight() + 
  facet_wrap(vars(year))+
  geom_smooth(method = "lm", se=FALSE)
  


ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point() + 
  gghighlight::gghighlight() + 
  facet_wrap(vars(cyl))
  #geom_text(label = slope,
  # nudge_y = 1, nudge_x = 1)
#both aesthetics vs the faceting var are displayed, . means the previous aes/data. 
