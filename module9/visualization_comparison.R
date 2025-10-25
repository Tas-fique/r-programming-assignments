# Module 9: Visualization in R – Base, Lattice, ggplot2
# Author: Tasfique Imam | Course: LIS 4370

# Load dataset
data("mtcars")      
df <- mtcars
df$cyl  <- factor(df$cyl)
df$gear <- factor(df$gear)

# ---- 1) Base R Graphics (display + save) --------------------------------
# Scatter
plot(df$hp, df$mpg,
     main = "Base R: MPG vs Horsepower",
     xlab = "Horsepower", ylab = "Miles per Gallon",
     col = df$cyl, pch = 19)
legend("topright", legend = levels(df$cyl), col = 1:3, pch = 19, title = "Cylinders")
# Save what you just saw:
dev.copy(png, filename = "images/base_scatter.png", width = 600, height = 400)
dev.off()

# Histogram
hist(df$mpg,
     main = "Base R: Distribution of MPG",
     xlab = "Miles per Gallon",
     col = "lightblue", border = "white")
dev.copy(png, filename = "images/base_hist.png", width = 600, height = 400)
dev.off()

# ---- 2) Lattice (display + save) ----------------------------------------
if (!requireNamespace("lattice", quietly = TRUE)) install.packages("lattice")
library(lattice)

# Conditional scatter
lat_scatter <- xyplot(mpg ~ hp | gear, data = df,
                      groups = cyl, auto.key = list(columns = 3),
                      main = "Lattice: MPG vs HP by Gear",
                      xlab = "Horsepower", ylab = "Miles per Gallon")
print(lat_scatter)  # display
png("images/lattice_scatter.png", width = 600, height = 400); print(lat_scatter); dev.off()

# Boxplot
lat_box <- bwplot(mpg ~ cyl, data = df,
                  main = "Lattice: MPG by Cylinders",
                  xlab = "Cylinders", ylab = "Miles per Gallon")
print(lat_box)      # display
png("images/lattice_boxplot.png", width = 600, height = 400); print(lat_box); dev.off()

# ---- 3) ggplot2 (display + save) ----------------------------------------
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(ggplot2)

# Scatter + trend
p1 <- ggplot(df, aes(hp, mpg, color = cyl)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "ggplot2: MPG vs HP with Linear Trend", x = "Horsepower", y = "MPG") +
  theme_minimal()
print(p1)  # display
ggsave("images/ggplot_scatter.png", p1, width = 6, height = 4, dpi = 150)

# Faceted histogram
p2 <- ggplot(df, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 3, color = "white", alpha = 0.7) +
  facet_wrap(~ gear) +
  labs(title = "ggplot2: MPG Distribution by Gear", x = "Miles per Gallon", y = "Count") +
  theme_light()
print(p2)  # display
ggsave("images/ggplot_hist.png", p2, width = 6, height = 4, dpi = 150)

# ---- 4) Verify -----------------------------------------------------------
cat("Saved files:\n"); print(list.files("images", pattern = "scatter|hist|box", full.names = TRUE))

Blog Link:
