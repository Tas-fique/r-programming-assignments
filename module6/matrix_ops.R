# Module 6: Matrix Operations and Construction
# Author: Tasfique Imam | Course: LIS 4370

## ---- Task 1: Matrix Addition & Subtraction ------------------------------
A <- matrix(c(2, 0, 1, 3), ncol = 2)   # fills by column: [2,1; 0,3]
B <- matrix(c(5, 2, 4, -1), ncol = 2)  # [5,4; 2,-1]

cat("A =\n"); print(A)
cat("B =\n"); print(B)

A_plus_B  <- A + B
A_minus_B <- A - B

cat("\nA + B =\n"); print(A_plus_B)
cat("\nA - B =\n"); print(A_minus_B)

## ---- Task 2: Diagonal Matrix -------------------------------------------
D <- diag(c(4, 1, 2, 3))
cat("\nD (4x4 diagonal with 4,1,2,3) =\n"); print(D)

## ---- Task 3: Custom 5x5 Block-Structured Matrix ------------------------
# Target:
# [1,] 3 1 1 1 1
# [2,] 2 3 0 0 0
# [3,] 2 0 3 0 0
# [4,] 2 0 0 3 0
# [5,] 2 0 0 0 3

# Build it programmatically:
top_row   <- matrix(c(3, 1, 1, 1, 1), nrow = 1)
left_col  <- matrix(c(2, 2, 2, 2), nrow = 4)        # first column (rows 2..5)
lower_blk <- diag(3, nrow = 4, ncol = 4)            # 4x4 diagonal of 3's
lower_blk[lower_blk == 0] <- 0                      # explicit for clarity

# Combine: row 1 on top of rows 2..5
# rows 2..5 are [2, 0,0,0] + diag(3) in the 4x4 block
bottom <- cbind(left_col, lower_blk)
M <- rbind(top_row, bottom)

cat("\nCustom 5x5 matrix M =\n"); print(M)

## ---- (Optional) Sanity checks ------------------------------------------
stopifnot(all(dim(A) == c(2,2)),
          all(dim(B) == c(2,2)),
          all(dim(D) == c(4,4)),
          all(dim(M) == c(5,5)))


Blog Link:https://tasfiqueimamlis4370.blogspot.com/2025/10/assignment-6-matrix-operations-and.html
