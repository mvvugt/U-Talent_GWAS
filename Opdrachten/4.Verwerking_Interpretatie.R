# Lees de functies in
source("../Software/functions.R")

# Lees de GWAS-resultaten in


# Maak de QQ-plot 
pdf(file = "name.pdf")
QQ(data)
dev.off()

# Maak de Manhattan-plot
pdf(file = "naam.pdf")
manhattan(data)
dev.off()


# Baseline tabel
install.packages("tableone")
library(tableone)

# Lees de data in


# Inspecteer de data
head(data)

# De kolommen Geslacht, Fenotype, Hypertensie, Hypercholesterolemie en
# Diabetes zijn geen cijfers en we willen dat R ze als
# factors beschouwd. De eerste is voorgedaan, doe hetzelfde voor alle andere 
# kolommen die genoemd zijn
data$Geslacht <- as.factor(data$Geslacht)

# Bedenk per kolom of/waarom dit interessant is voor jullie tabel en creeer een vector (cols)
# met de kolom namen die je in de tabel wilt hebben (http://www.r-tutorial.nl/)
# Fenotype willen we er niet in!

# Maak een nieuwe vector (fac.col) met alle namen van de kolommen die je als factor hebt aangeduid

# Hier wordt de tabel aangemaakt
tab <- CreateTableOne(vars = cols, data = data, factorVars = fac.col,
                      strata = "Fenotype", addOverall = TRUE)
ex1 <- print(tab, showAllLevels = FALSE, missing = TRUE, 
             formatOptions = list(big.mark = ","), quote = FALSE,
             noSpaces = TRUE, printToggle = FALSE)

# Sla de tabel op en open hem daarna in Excel om hem mooi te maken
write.csv(ex1, file = "")
