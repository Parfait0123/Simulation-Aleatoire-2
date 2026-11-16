library(showtext)

regular <- file.path( "Google_Sans/static/GoogleSans-Regular.ttf")
bold    <- file.path( "Google_Sans/static/GoogleSans-Bold.ttf")

if (file.exists(regular) && file.exists(bold)) {
  font_add("gsans", regular = regular, bold = bold)
  famille <- "gsans"
} else {
  message("Google Sans introuvable : police par defaut utilisee.")
  famille <- "sans"
}
showtext_auto()

setHook("before.plot.new", function() {
  par(family = famille, cex = 1.9, mgp = c(2.4, 0.56, 0), mar = c(4.2, 4.5, 2.2, 1))
})
