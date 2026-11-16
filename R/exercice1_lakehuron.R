source("R/style_graphique.R")
dir.create("figures", showWarnings = FALSE)

# Question 1
data(LakeHuron)
Obs = c(LakeHuron)
cat("n =", length(Obs), "\n")
print(head(Obs))
print(tail(Obs))

# Questions 2 et 3
pdf("figures/fig_ecdf.pdf", width = 14.0, height = 8.5)
ecdf_obs = ecdf(Obs)
plot(ecdf_obs, main = "Fonction de répartition empirique et loi normale ajustée",
     xlab = "x (niveau du lac, en pieds)", ylab = "F(x)",
     col = "blue", lwd = 3, verticals = TRUE, do.points = FALSE)
grid()
Y = sort(Obs)
Y_norm = pnorm(Y, mean = mean(Obs), sd = sd(Obs))
lines(Y, Y_norm, col = "red", lwd = 3)
legend("topleft", legend = c("F empirique", "N(m, s²)"),
       col = c("blue", "red"), lty = 1, lwd = 2, bty = "n")
invisible(dev.off())
cat("m =", mean(Obs), " s =", sd(Obs), "\n")

# Question 4
N = 1000
ptx = seq(from = 1/N, to = 1, by = 1/N)
Qn = quantile(Obs, ptx)
pdf("figures/fig_quant.pdf", width = 14.0, height = 8.5)
plot(ptx, Qn, main = "Fonction quantile empirique",
     xlab = "Ordre p", ylab = "Quantile Qn(p)", col = "blue", pch = 20)
invisible(dev.off())
cat("min =", min(Obs), " max =", max(Obs), " mediane =", median(Obs), "\n")

pdf("figures/fig_quant2.pdf", width = 14.0, height = 8.5)
qqnorm(Obs, xlab = "Quantiles théoriques", ylab = "Quantiles empiriques",
       main = "QQ-plot normal", col = "blue", pch = 20)
qqline(Obs, col = "red", lwd = 2)
invisible(dev.off())

# Question 5
N = 1000
pdf("figures/fig_hist.pdf", width = 14.0, height = 8.5)
hist(Obs, prob = TRUE, main = "Histogramme de Obs et densité normale ajustée",
     xlab = "Niveau du lac (en pieds)", ylab = "Densité",
     col = "lightblue", border = "white")
ptx = seq(min(Obs), max(Obs), length = N)
lines(ptx, dnorm(ptx, mean = mean(Obs), sd = sd(Obs)), col = "red", lwd = 2)
invisible(dev.off())

# Question 6
dens = density(Obs)
cat("noyau : gaussien (par defaut)\n")
cat("fenetre h =", dens$bw, "\n")

kernels = eval(formals(density.default)$kernel)
pdf("figures/fig_kernel.pdf", width = 14.0, height = 8.5)
plot(dens, main = "Estimateurs à noyau de la densité",
     xlab = "Niveau (en pieds)", ylab = "Densité", lwd = 2, ylim = c(0, 0.42))
axis(1, at = seq(575, 583, by = 2))
for (i in 2:length(kernels)) {
  lines(density(Obs, kernel = kernels[i]), col = i, lwd = 2)
}
legend(x = 580.6, y = 0.44, legend = kernels, col = seq(kernels), lty = 1, lwd = 3,
       bty = "n", seg.len = 1, y.intersp = 1, x.intersp = 0.4)
invisible(dev.off())
