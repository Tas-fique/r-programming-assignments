is_square <- function(M) {
  d <- dim(M); !is.null(d) && d[1] == d[2]
}

safe_det <- function(M) {
  tryCatch({
    if (!is_square(M)) stop("det(): matrix is not square.")
    det(M)
  }, error = function(e) e)
}

safe_inv <- function(M) {
  tryCatch({
    if (!is_square(M)) stop("solve(): matrix is not square.")
    solve(M)
  }, error = function(e) e)
}

## ---- Create matrices ----------------------------------------------------
A <- matrix(1:100,  nrow = 10)   # 10x10
B <- matrix(1:1000, nrow = 10)   # 10x100 (non-square)

## ---- Inspect dimensions -------------------------------------------------
cat("dim(A) =", paste(dim(A), collapse=" x "), "\n")
cat("dim(B) =", paste(dim(B), collapse=" x "), "\n")

## ---- Determinant & inverse (A) ------------------------------------------
detA <- safe_det(A)
invA <- safe_inv(A)

cat("\n-- Results for A --\n")
if (inherits(detA, "error")) {
  cat("det(A) error:", conditionMessage(detA), "\n")
} else {
  cat("det(A) =", as.numeric(detA), "\n")
}

if (inherits(invA, "error")) {
  cat("solve(A) error:", conditionMessage(invA), "\n")
} else {
  cat("solve(A) computed successfully (showing first 3x3):\n")
  print(invA[1:3, 1:3])
}

## Optional diagnostics for A (singularity/conditioning)
if (!inherits(detA, "error")) {
  cat("kappa(A) (condition number, larger = worse):", kappa(A), "\n")
}
cat("rank(A) via QR:", qr(A)$rank, "\n")

## ---- Determinant & inverse (B) -----------------------------------------
detB <- safe_det(B)
invB <- safe_inv(B)

cat("\n-- Results for B --\n")
if (inherits(detB, "error")) {
  cat("det(B) error:", conditionMessage(detB), "\n")
} else {
  cat("det(B) =", as.numeric(detB), "\n")
}



if (inherits(invB, "error")) {
  cat("solve(B) error:", conditionMessage(invB), "\n")
} else {
  cat("solve(B) computed successfully (unexpected for non-square)\n")
}

Blog Link: https://tasfiqueimamlis4370.blogspot.com/2025/09/assignment-5-matrix-algebra-in-r.html
