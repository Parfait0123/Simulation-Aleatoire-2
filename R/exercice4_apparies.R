juste_apres_traite <- c(12000, 13000, 21500, 17000, 15000, 22000, 11000, 21000)
apres_24h          <- c(11000, 20000, 31000, 28000, 26000, 30000, 16000, 29000)

# Question 1
D <- apres_24h - juste_apres_traite
print(D)

# Question 2
result = t.test(apres_24h, juste_apres_traite, paired = TRUE, alternative = "greater")
print(result)
IC = t.test(apres_24h, juste_apres_traite, paired = TRUE)$conf.int
print(IC)

# Question 3
plus  <- sum(D > 0)
moins <- sum(D < 0)
n     <- plus + moins
print(binom.test(plus, n = n, p = 0.5, alternative = "greater"))

# Question 4
print(wilcox.test(apres_24h, juste_apres_traite, paired = TRUE,
                  alternative = "greater", exact = FALSE))
