data(rivers)
cat("n =", length(rivers), " valeurs distinctes =", length(unique(rivers)), "\n")
cat("moyenne =", mean(rivers), " mediane =", median(rivers), "\n")

# Question 2
result = shapiro.test(rivers)
print(result$statistic)
print(result$p.value)

# Question 3
result = ks.test(rivers, "pnorm", mean = mean(rivers), sd = sd(rivers))
print(result)
