for (f in sort(list.files("R", pattern = "^exercice.*\\.R$", full.names = TRUE))) {
  cat("\n", f, "\n", sep = "")
  source(f, encoding = "UTF-8")
  cat("\n\n\n")
}
