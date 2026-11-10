# Introduction to DBSCAN
# Author: Levi C Nicklas
#
#
# This script is for your introduction to DBSCAN

## SETUP
library(dbscan)
library(cluster)
library(ggplot2)
load("multishapes.rda")
df <- multishapes

## Peek at data via plotting
ggplot(data = multishapes) + 
  geom_point(aes(x = x, y = y)) + 
  theme_minimal() 

## Peek at data structure
head(df, 25)

## Try K-Means
kmeans_results <- kmeans(
  as.matrix(df[,1:2]), # First two columns of data
  centers = 5
)

df$kmeans_cluster <- kmeans_results[1] |> 
    unlist() |> 
    as.factor()

# Plot the K-Means results
df |> 
  ggplot(aes(x = x, y = y, color = kmeans_cluster)) + 
  geom_point() + 
  theme_minimal() +
  scale_color_brewer(palette = "Set2")+ 
  labs(
    x = "x",
    y = "y", 
    color = "K-Means Cluster"
  ) +
  theme(legend.position = "bottom") 

## Try DBSCAN
x <- as.matrix(df[, 1:2]) # Just grab first two columns as a matrix.

# Hint: dbscan::kNNdistplot(x, k = ?) to get started
my_eps <- 0 # SET YOUR OWN VALUES
min_pts <- 0 #SET YOUR OWN VALUES

# Perform DBSCAN
df$dbscan_cluster <- dbscan(x, eps = my_eps, minPts = min_pts)$cluster |> as.factor()

# Check results...
df |> 
  ggplot(aes(x = x, y = y, color = dbscan_cluster)) + 
  geom_point() + 
  theme_minimal() +
  labs(x = "x", y = "y", color = "DBSCAN Clusters") +
  theme(legend.position = "none")



# CHALLENGE DATASET:
df2 <- readr::read_csv("moons.csv")

df2 |> 
  ggplot(aes(x = X, y = Y))+
  geom_point() + 
  theme_minimal()
