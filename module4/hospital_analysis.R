# Module 4: Hospital Patient Data Analysis
# Author: Tasfique Imam
# Course: LIS 4317 (R Programming)

# -------------------------
# Data Setup
# -------------------------
Frequency     <- c(0.6, 0.3, 0.4, 0.4, 0.2, 0.6, 0.3, 0.4, 0.9, 0.2)
BloodPressure <- c(103, 87, 32, 42, 59, 109, 78, 205, 135, 176)
FirstAssess   <- c(1, 1, 1, 1, 0, 0, 0, 0, NA, 1)    # bad=1, good=0
SecondAssess  <- c(0, 0, 1, 1, 0, 0, 1, 1, 1, 1)    # low=0, high=1
FinalDecision <- c(0, 1, 0, 1, 0, 1, 0, 1, 1, 1)    # low=0, high=1

df_hosp <- data.frame(
  Frequency, BloodPressure, FirstAssess,
  SecondAssess, FinalDecision, stringsAsFactors = FALSE
)

# -------------------------
# Inspect and Clean Data
# -------------------------
summary(df_hosp)           # quick overview
df_hosp <- na.omit(df_hosp) # remove rows with NA (1 row dropped)

# -------------------------
# Boxplots
# -------------------------
# Save into images/ folder (make sure it exists inside your repo root)
dir.create("images", showWarnings = FALSE)

png("images/boxplot_first.png")
boxplot(BloodPressure ~ FirstAssess, data = df_hosp,
        names = c("Good","Bad"),
        ylab = "Blood Pressure", main = "BP by First MD Assessment")
dev.off()

png("images/boxplot_second.png")
boxplot(BloodPressure ~ SecondAssess, data = df_hosp,
        names = c("Low","High"),
        ylab = "Blood Pressure", main = "BP by Second MD Assessment")
dev.off()

png("images/boxplot_final.png")
boxplot(BloodPressure ~ FinalDecision, data = df_hosp,
        names = c("Low","High"),
        ylab = "Blood Pressure", main = "BP by Final Decision")
dev.off()

# -------------------------
# Histograms
# -------------------------
png("images/hist_frequency.png")
hist(df_hosp$Frequency,
     breaks = seq(0, 1, by = 0.1),
     xlab = "Visit Frequency", main = "Histogram of Visit Frequency")
dev.off()

png("images/hist_bp.png")
hist(df_hosp$BloodPressure,
     breaks = 8,
     xlab = "Blood Pressure", main = "Histogram of Blood Pressure")
dev.off()
