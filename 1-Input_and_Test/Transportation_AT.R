library(geosphere)
library(openxlsx)

## To calculate the distance between cement plants and potential CO2 storage/port sites in Austria
# Latitudes and longitudes of plants, C1*C9
plant_lat <- c(47.797989, 47.982849, 46.735413, 47.907307, 47.25465, 47.214538, 46.84864, 47.87368, 47.727097)
plant_lon <- c(13.776930, 16.609671, 15.572505, 14.117350, 11.392583, 15.343520, 14.603621, 16.085400, 13.041887)
plant_names <- paste0("C", 1:9)

# Latitudes and longitudes of storage sites, Linz Port, Vienna Port,OMV, Storage sites, greenfield plant in Linz, Rotterdam Port
storage_lat <- c(48.29571, 48.18253, 48.14807, 48.36418, 48.28048, 51.95022)
storage_lon <- c(14.33194, 16.46582, 16.49479, 16.68164, 14.35587, 4.14326)
storage_names <- paste0("S", 1:6)

# Create a matrix to store distances
dist_matrix <- matrix(0, nrow = length(plant_lat), ncol = length(storage_lat))

# Loop through each plant and storage site to calculate distance
for (i in 1:length(plant_lat)) {
  for (j in 1:length(storage_lat)) {
    dist_matrix[i, j] <- distGeo(c(plant_lon[i], plant_lat[i]), c(storage_lon[j], storage_lat[j])) / 1000
  }
}

# Print the distance matrix
dist_matrix

# Convert matrix to data frame
total_distance_df <- as.data.frame(dist_matrix)

# Write the data frame to an Excel file
write.xlsx(total_distance_df, "Transport_distance.xlsx")

## To calculate the CO2 transported of each plants to each storage/port sites, tCO2*km
# Define the CO2 capacity matrix
co2_capacity <- matrix(c(0.476, 0.6545, 0.2975, 0.2975, 0.1785, 0.238, 0.44625, 0.1785, 0.45815),
                       ncol = 1, byrow = TRUE,
                       dimnames = list(c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9"),
                                       "CO2 Mt/y"))

# Create a matrix to store the results
co2_transportation <- matrix(0, nrow = nrow(dist_matrix), ncol = ncol(dist_matrix),
                             dimnames = list(rownames(dist_matrix), colnames(dist_matrix)))

# Multiply each row of the CO2 capacity matrix by the corresponding column of the distance matrix
for (i in 1:nrow(co2_capacity)) {
  for (j in 1:ncol(dist_matrix)) {
    co2_transportation[i, j] <- co2_capacity[i, 1] * dist_matrix[i, j]
  }
}

# Print the CO2 transported matrix
co2_transportation

# Convert matrix to data frame
co2_transportation_df <- as.data.frame(co2_transportation)

# Write the data frame to an Excel file
write.xlsx(co2_transportation_df, "CO2_transported.xlsx")

## Cost comparision of different transportation modes
# Define the transportation cost matrix
transport_cost <- matrix(c(0.019093, 0.043072, 0.00611, 0.013783, 0.047766, 0.150691, 0.103637, 0.050345,  
                           0.019093, 0.043072, 0.00611, 0.013783, 0.047766, 0.150691, 0.103637, 0.050345, 
                           0.019093, 0.043072, 0.00611, 0.013783, 0.047766, 0.150691, 0.103637, 0.050345, 
                           0.019093, 0.043072, 0.00611, 0.013783, 0.047766, 0.150691, 0.103637, 0.050345, 
                           0.019093, 0.043072, 0.00611, 0.013783, 0.047766, 0.150691, 0.103637, 0.050345, 
                           0.019093, 0.043072, 0.00611, 0.013783, 0.047766, 0.150691, 0.103637, 0.050345), 
                         ncol = 6, byrow = TRUE,
                         dimnames = list(c("Mode 1", "Mode 2", "Mode 3", "Mode 4", "Mode 5", "Mode 6", "Mode 7", "Mode 8"),
                                         c("EUR/tCO2/km", "EUR/tCO2/km", "EUR/tCO2/km", "EUR/tCO2/km", "EUR/tCO2/km", "EUr/tCO2/km")))

# Create a matrix to store the results
total_cost <- matrix(0, nrow = nrow(co2_transportation) * nrow(transport_cost), ncol = ncol(co2_transportation),
                     dimnames = list(paste0(rep(rownames(co2_capacity), nrow(transport_cost))),
                                     colnames(co2_transportation)))

# Multiply each element of the CO2 transportation matrix with the corresponding element of the transportation cost matrix
for (i in 1:nrow(co2_transportation)) {
  for (j in 1:ncol(co2_transportation)) {
    for (k in 1:ncol(transport_cost)) {
      total_cost[(i-1)*ncol(transport_cost)+k, j] <- co2_transportation[i, j] * transport_cost[k, j]
    }
  }
}

# Print the result
total_cost

# Convert matrix to data frame
total_cost_df <- as.data.frame(total_cost)

# Write the data frame to an Excel file
write.xlsx(total_cost_df, "total_transportation_cost.xlsx")