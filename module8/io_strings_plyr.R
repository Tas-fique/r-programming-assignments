# Module 8: Input/Output, String Manipulation, and plyr
# Author: Tasfique Imam | Course: LIS 4370

# 1) Import (pick the file interactively, but parse as CSV)
student6 <- read.csv(file.choose(), stringsAsFactors = FALSE)

cat("First rows:\n"); print(head(student6))
cat("\nStructure:\n"); str(student6)

# Ensure expected columns
stopifnot(all(c("Name","Sex","Grade") %in% names(student6)))

# 2) Group mean Grade by Sex
if (!requireNamespace("plyr", quietly = TRUE)) install.packages("plyr")
library(plyr)

gender_mean <- ddply(student6, "Sex", summarise,
                     GradeAverage = mean(Grade, na.rm = TRUE))
print(gender_mean)
write.table(gender_mean, "gender_mean.txt", sep = "\t", row.names = FALSE)

# 3) Filter names containing 'i'/'I'
i_students <- subset(student6, grepl("i", Name, ignore.case = TRUE))

# Write just names
write.csv(data.frame(Name = i_students$Name),
          "i_students.csv", row.names = FALSE, quote = FALSE)

# Write full filtered rows
write.csv(i_students, "i_students_full.csv", row.names = FALSE)

# 4) Verify
outs <- c("gender_mean.txt", "i_students.csv", "i_students_full.csv")
print(setNames(file.exists(outs), outs))

Blog Link: https://tasfiqueimamlis4370.blogspot.com/2025/10/assignment-8-inputoutput-string.html
