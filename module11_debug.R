# Module 11: Debugging and Defensive Programming in R
# Author: Tasfique Imam | Course: LIS 4370

# ----------------------------------------------------
# 1) Original buggy function
# ----------------------------------------------------

tukey_multiple_buggy <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in 1:ncol(x)) {
    # BUG: && is scalar logical AND, not element-wise
    outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
  }
  outlier.vec <- vector("logical", length = nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  return(outlier.vec)
}

# ----------------------------------------------------
# 2) Helper: Tukey outlier rule for one numeric vector
#    (typical implementation)
# ----------------------------------------------------

tukey.outlier <- function(v) {
  if (!is.numeric(v)) {
    stop("tukey.outlier() expects a numeric vector.")
  }
  q <- stats::quantile(v, probs = c(0.25, 0.75), na.rm = TRUE)
  iqr <- q[2] - q[1]
  lower <- q[1] - 1.5 * iqr
  upper <- q[2] + 1.5 * iqr
  v < lower | v > upper
}

# ----------------------------------------------------
# 3) Reproduce the error
# ----------------------------------------------------

set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)  # 10 x 5 matrix

# Try the buggy function and capture the error message
buggy_error <- try(tukey_multiple_buggy(test_mat), silent = TRUE)
buggy_error  # This will print the error you got from &&

# ----------------------------------------------------
# 4) Corrected function (element-wise & + defensive checks)
# ----------------------------------------------------

corrected_tukey <- function(x) {
  # Defensive checks
  if (!is.matrix(x)) {
    stop("corrected_tukey(): 'x' must be a matrix.")
  }
  if (!is.numeric(x)) {
    stop("corrected_tukey(): 'x' must be a numeric matrix.")
  }
  if (nrow(x) == 0 || ncol(x) == 0) {
    stop("corrected_tukey(): 'x' must have at least one row and one column.")
  }

  # Initialize all TRUE (assume all are outliers until proven otherwise)
  outliers <- array(TRUE, dim = dim(x))

  # Loop over columns, mark which entries are outliers in each column
  for (j in seq_len(ncol(x))) {
    # FIXED: & is element-wise logical AND
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }

  # For each row, check if it's an outlier in ALL columns
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }

  outlier.vec
}

# ----------------------------------------------------
# 5) Validate the fix
# ----------------------------------------------------

result <- corrected_tukey(test_mat)
result
length(result)        # should be 10 (one per row)
any(is.na(result))    # should be FALSE

Blogger Link: https://tasfiqueimamlis4370.blogspot.com/2025/11/assignment-11-debugging-and-defensive.html
