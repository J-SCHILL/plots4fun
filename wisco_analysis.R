library(data.table)
library(ggplot2)
setwd("C:/Users/joshs/iCloudDrive/R Practice")
wisdat <- fread("Wisconsin_Data2.csv")

education <- wisdat |> melt.data.table(id.vars = "Fact",
                          measure.vars = 2:7,
                          variable.name = "Location",
                          value.name = "Value") |> 
  dcast(Location ~ Fact)

education |> ggplot(
  aes(as.double(`Bachelor's degree or higher, percent of persons age 25 years+, 2015-2019`),
      as.double(`Median household income (in 2019 dollars), 2015-2019`))) +
  geom_point(aes(color = Location)) +
  geom_text(aes(label = Location), 
            hjust = ifelse(education$Location == "Madison", 1.1, -.1)) +
  labs(x = "Bachelor's Degree or Higher % (2015-2019)",
       y = "Median 2019 Household Income",
       caption = "source: www.census.gov",
       title = "Getting a Bachelor's Degree Doesn't \nGuarentee Higher Income in Wisconsin") +
  theme_classic() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = .4),
        text = element_text(family = "serif")) +
  scale_y_continuous(labels = scales::dollar) +
  scale_x_continuous(labels = scales::percent)

ggsave("bach_income.png", 
       units = "px",
       width = 1200,
       height = 675,
       scale = 1.5)
