# Module 7: Exploring R’s Object Oriented Systems (S3 & S4)
# Author: Tasfique Imam | Course: LIS 4370

## ---- Load Dataset --------------------------------------------------------
data("mtcars")              # built-in dataset
cat("First rows of mtcars:\n")
print(head(mtcars))
cat("\nStructure of mtcars:\n")
str(mtcars)

## ---- Test Generic Functions ----------------------------------------------
cat("\nSummary of mtcars:\n")
print(summary(mtcars))

cat("\nPlot of mpg vs hp:\n")
plot(mtcars$hp, mtcars$mpg, main="Horsepower vs MPG",
     xlab="Horsepower", ylab="Miles Per Gallon")

## ---- S3 Example ----------------------------------------------------------
s3_obj <- list(name = "Myself", age = 29, GPA = 3.5)
class(s3_obj) <- "student_s3"

# Define a simple print method for the S3 class
print.student_s3 <- function(x) {
  cat("S3 Student Object:\n")
  cat("Name:", x$name, "\nAge:", x$age, "\nGPA:", x$GPA, "\n")
}

cat("\nS3 object print:\n")
print(s3_obj)

## ---- S4 Example ----------------------------------------------------------
setClass("student_s4",
         slots = c(name = "character", age = "numeric", GPA = "numeric"))

s4_obj <- new("student_s4", name = "Myself", age = 29, GPA = 3.5)

# Define a show() method for the S4 class
setMethod("show", "student_s4", function(object) {
  cat("S4 Student Object:\n")
  cat("Name:", object@name, "\nAge:", object@age, "\nGPA:", object@GPA, "\n")
})

cat("\nS4 object print:\n")
print(s4_obj)

## ---- Discussion Helper Notes ---------------------------------------------
# To tell whether an object is S3 or S4:
#   - isS4(obj) returns TRUE for S4 objects
#   - methods(class=class(obj)) lists methods for S3
# To inspect underlying type: typeof(), class(), str()
# Generics: functions like summary(), plot() dispatch to methods

Blog Link: https://tasfiqueimamlis4370.blogspot.com/2025/10/assignment-7-exploring-rs.html
