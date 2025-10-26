# Assignment 9: Visualization in R – Base, Lattice, ggplot2
# Author: Tasfique Imam | Course: LIS 4370

# ------------------------------------------------------------
# Setup
# ------------------------------------------------------------
dir.create("images", showWarnings = FALSE)

data("mtcars")   # built-in dataset
df <- mtcars
df$cyl  <- factor(df$cyl)
df$gear <- factor(df$gear)

# ------------------------------------------------------------
# Base R Graphics
# ------------------------------------------------------------

# Scatter plot
plot(df$hp, df$mpg,
     main = "Base R: MPG vs Horsepower",
     xlab = "Horsepower", ylab = "Miles per Gallon",
     col = df$cyl, pch = 19)
legend("topright", legend = levels(df$cyl), col = 1:3, pch = 19, title = "Cylinders")
dev.copy(png, "images/base_scatter.png", width = 600, height = 400); dev.off()

# Histogram
hist(df$mpg,
     main = "Base R: Distribution of MPG",
     xlab = "Miles per Gallon",
     col = "lightblue", border = "white")
dev.copy(png, "images/base_hist.png", width = 600, height = 400); dev.off()

# ------------------------------------------------------------
# Lattice Graphics
# ------------------------------------------------------------
if (!requireNamespace("lattice", quietly = TRUE)) install.packages("lattice")
library(lattice)

# Conditional scatter plot
lat_scatter <- xyplot(mpg ~ hp | gear, data = df,
                      groups = cyl, auto.key = list(columns = 3),
                      main = "Lattice: MPG vs HP by Gear",
                      xlab = "Horsepower", ylab = "Miles per Gallon")
print(lat_scatter)
png("images/lattice_scatter.png", width = 600, height = 400); print(lat_scatter); dev.off()

# Boxplot
lat_box <- bwplot(mpg ~ cyl, data = df,
                  main = "Lattice: MPG by Cylinders",
                  xlab = "Cylinders", ylab = "Miles per Gallon")
print(lat_box)
png("images/lattice_boxplot.png", width = 600, height = 400); print(lat_box); dev.off()

# ------------------------------------------------------------
# ggplot2 Graphics
# ------------------------------------------------------------
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(ggplot2)

# Scatter with linear trend
p1 <- ggplot(df, aes(x = hp, y = mpg, color = cyl)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "ggplot2: MPG vs HP with Trend", x = "Horsepower", y = "MPG") +
  theme_minimal()
print(p1)
ggsave("images/ggplot_scatter.png", p1, width = 6, height = 4, dpi = 150)

# Faceted histogram
p2 <- ggplot(df, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 3, color = "white", alpha = 0.7) +
  facet_wrap(~ gear) +
  labs(title = "ggplot2: MPG Distribution by Gear", x = "Miles per Gallon", y = "Count") +
  theme_light()
print(p2)
ggsave("images/ggplot_hist.png", p2, width = 6, height = 4, dpi = 150)

# ------------------------------------------------------------
Blog Link:https://tasfiqueimamlis4370.blogspot.com/2025/10/assignment-9-visualization-in-r-base.html
