library(ggplot2)
library(geojsonio)

## Map of Austria
AT0 <- geojson_read("https://raw.githubusercontent.com/ginseng666/GeoJSON-TopoJSON-Austria/master/2021/simplified-99.5/laender_995_geo.json", what ="sp")
AT <- tidy(AT0)
AT1 <- as.data.frame(AT)

## Cement plants in Austria
cementplants <- data.frame(
  Symbol = c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9"),
  Plant = c("Hatschek", "Mannersdorf", "Retznei", "Kirchdorf","Vils", "Peggau", "Wietersdorf", "Wopfing", "Gartenau"),
  CO2 = c(262.000,304.000,328.000,673.000,248.000,221.000,517.000,465.000,352.000), # 2019 data, kt/y
  Cement = c(0.800, 1.100, 0.500, 0.500, 0.300, 0.400, 0.750, 0.300, 0.770), # Mt/y
  long = c(13.776930, 16.609671, 15.572505, 14.117350, 11.392583, 15.343520, 14.603621, 16.085400, 13.041887),
  lat = c(47.797989, 47.982849, 46.735413, 47.907307, 47.25465, 47.214538, 46.84864, 47.87368, 47.727097),
  stringsAsFactors = FALSE
)

# Create a data frame with line endpoints
lines_df <- data.frame(
  x = c(cementplants$long[1:5], cementplants$long[c(2,6,5)]),
  y = c(cementplants$lat[1:5], cementplants$lat[c(2,6,5)])
)

# Plot it
ggplot() +
  geom_polygon(data = AT1, aes(x = long, y = lat, group = group), fill = "#D3D3D3", color = "white") +
  theme_void() + coord_map() +
  #geom_segment(data = lines_df, aes(x = x, y = y, xend = lead(x), yend = lead(y)), 
               #arrow = arrow(length = unit(0.3, "cm")), size = 1.5, color = "#89CFF0", alpha = 0.8) +
  geom_point(data = cementplants, aes(x = long, y = lat, size = CO2, color = "#FFA500")) +
  geom_text_repel(data = cementplants, aes(x = long, y = lat, label = Symbol), size = 6, force = 8) +
  scale_size(range = c(2, 8)) +
  ggtitle("Locations and CO2 Emissions of the Austrian Cement Plants") +
  theme(
    #legend.position = "top",
    #legend.justification = "right",
    #legend.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    #plot.title = element_text(size = 16, hjust = 0.1, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    #axis.text = element_text(color = "#22211d"),
    #axis.title = element_text(color = "#22211d")
  )

 print(plot)
 ggsave("cement_map_AT.png")
    