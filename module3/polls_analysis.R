# Module 3: Poll Data Analysis

# Define data
Name      <- c("Jeb","Donald","Ted","Marco","Carly","Hillary","Bernie")
ABC_poll  <- c(  4,      62,     51,    21,      2,        14,       15)
CBS_poll  <- c( 12,      75,     43,    19,      1,        21,       19)

# Create data frame
df_polls <- data.frame(Name, ABC_poll, CBS_poll, stringsAsFactors = FALSE)

# Inspect
str(df_polls)
head(df_polls)

# Summary statistics
mean(df_polls$ABC_poll)
median(df_polls$CBS_poll)
range(df_polls$ABC_poll)
range(df_polls$CBS_poll)

# Add difference column (fixed typo)
df_polls$Diff <- df_polls$CBS_poll - df_polls$ABC_poll
df_polls

# Largest discrepancy
df_polls[which.max(abs(df_polls$Diff)), ]

# Plot (ggplot2)
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")

library(ggplot2)
library(tidyr)

# Reshape to long format
df_long <- pivot_longer(df_polls, cols = c(ABC_poll, CBS_poll),
                        names_to = "Source", values_to = "Value")

# Bar chart comparing ABC vs CBS
p <- ggplot(df_long, aes(x = Name, y = Value, fill = Source)) +
  geom_col(position = "dodge") +
  labs(title = "ABC vs CBS Poll Results (2016 Example)",
       x = "Candidate", y = "Poll Value") +
  theme_minimal()

# Save image
dir.create("images", showWarnings = FALSE)
ggsave("images/polls_comparison.png", p, width = 8, height = 5, dpi = 150)


Blog Link: https://tasfiqueimamlis4370.blogspot.com/2025/09/assignment-3-assignment-3-analyzing.html
