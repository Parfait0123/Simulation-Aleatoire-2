source("R/style_graphique.R")
dir.create("figures", showWarnings = FALSE)
library(boot)

x = c(42, 55, 61, 48, 73, 67, 89, 52, 96, 71, 58, 110, 64, 77, 45,
      132, 83, 69, 57, 101, 74, 185, 92, 63)

# Question 1
moyenne = mean(x)
mediane = median(x)
ecart = sd(x)
quartiles = quantile(x, probs = c(0.25, 0.5, 0.75))
percentile90 = quantile(x, probs = 0.9)
cat("moyenne =", moyenne, " mediane =", mediane, " ecart-type =", ecart, "\n")
print(quartiles)
print(percentile90)

# Question 2
pdf("figures/fig_precip1.pdf", width = 14.0, height = 8.5)
hist(x, prob = TRUE, main = "Histogramme", xlab = "Précipitation maximale (mm)",
     ylab = "Densité", col = "lightblue", border = "white")
invisible(dev.off())

pdf("figures/fig_precip2.pdf", width = 14.0, height = 8.5)
boxplot(x, main = "Boîte à moustaches", xlab = "Précipitation maximale (mm)",
        col = "lightblue", horizontal = T)
invisible(dev.off())

q = quantile(x, c(0.25, 0.75))
iqr = q[2] - q[1]
cat("IQR =", iqr, " barriere de Tukey =", q[2] + 1.5 * iqr, "\n")
print(x[x > q[2] + 1.5 * iqr])

# Question 3
boot_stats <- function(data, indices) {
  xb <- data[indices]
  c(mean(xb), median(xb), quantile(xb, 0.9, names = FALSE))
}

set.seed(123)
Bs <- c(200, 1000, 5000, 10000)
sorties <- lapply(Bs, function(B) boot(data = x, statistic = boot_stats, R = B))
names(sorties) <- Bs
print(sorties)
print(t(sapply(sorties, function(res) colMeans(res$t))))

# Question 4
biais <- t(sapply(sorties, function(res) colMeans(res$t) - res$t0))
colnames(biais) <- c("moyenne", "mediane", "p90")
print(biais)

# Question 5
ic <- t(sapply(sorties, function(r) boot.ci(r, conf = 0.95, type = "perc", index = 2)$percent[4:5]))
colnames(ic) <- c("borne_inf", "borne_sup")
print(ic)
