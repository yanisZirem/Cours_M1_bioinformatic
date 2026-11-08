# =====================================================================
# TD1 : Tests statistiques sous R : comparer des groupes
# M1 Bioinformatique
# Enseignant: Yanis Zirem (yanis.zirem@univ-lille.fr) 
#Date : 09/11/2026
#Objectifs : 
#À la fin de la séance, les étudiants savent choisir et exécuter sous R un test de comparaison de groupes 
#(2 groupes, indépendants ou appariés)

# Consignes : complétez le script à l'emplacement des "A FAIRE", exécutez-le
# ligne par ligne (Ctrl + Entrée) et répondez aux QUESTIONS en commentaire.
# Données : Placez les fichiers CSV dans votre dossier de travail :
# setwd("chemin/vers/le/dossier")
# =====================================================================

# ---------------------------------------------------------------------
# EXERCICE 1 : types de variables et exploration (15 min)
# ---------------------------------------------------------------------
patients <- read.csv("patients.csv", stringsAsFactors = FALSE)
str(patients)
head(patients)

# QUESTION 1.1 : pour chaque variable, indiquez qualitative (nominale/ordinale)
# ou quantitative (discrète/continue).
#   age :
#   sexe :
#   tabac :
#   stade :
#   taille_mm :
#   mutation_TP53 :
#   reponse :
#   expr_GENE1 :

# A FAIRE 1.2 : convertissez en facteur sexe, tabac, mutation_TP53, traitement, reponse.
# Le stade est ordinal : utilisez factor(..., levels = c("I","II","III","IV"), ordered = TRUE)
# Indice : patients$sexe <- factor(patients$sexe)

# Vérifiez avec str(patients)



# A FAIRE 1.3 : résumez les données.
# summary(patients)  -> repérez les valeurs manquantes (NA)
# Calculez la moyenne et l'écart-type de l'âge (attention à na.rm = TRUE)

# Moyenne et écart-type de expr_GENE1 par traitement
# Indice : tapply(variable, groupe, mean)


# A FAIRE 1.4 : un graphique adapté à chaque type
# barplot(table(...)) pour le stade ; boxplot(y ~ groupe, data = ...) pour GENE1 ; hist() pour taille_mm


# QUESTION 1.4 : la distribution de taille_mm est-elle symétrique ? Que cela suggère-t-il ?
# Réponse :

# ---------------------------------------------------------------------
# EXERCICE 2 : normalité et égalité des variances
# ---------------------------------------------------------------------
# A FAIRE 2.1 : Shapiro-Wilk pour expr_GENE1, expr_GENE2, expr_GENE3 dans chaque groupe de traitement.
# Indice : by(patients$expr_GENE1, patients$traitement, shapiro.test)


# A FAIRE 2.2 : QQ-plots (qqnorm + qqline) pour les 3 gènes et les 2 groupes.
# Indice : par(mfrow = c(2, 3)) pour afficher 6 graphiques les gènes et les avec les différents traitements


# A FAIRE 2.3 : test d'égalité des variances pour GENE1 et GENE3.
# Indice : var.test(expr_GENE1 ~ traitement, data = patients)

# QUESTION 2 : complétez le tableau (normalité oui/non ; variances égales oui/non ; test choisi)
#   GENE1 :
#   GENE2 :
#   GENE3 :

# ---------------------------------------------------------------------
# EXERCICE 3 : deux groupes indépendants
# ---------------------------------------------------------------------
# A FAIRE 3.1 : comparez les 3 gènes entre traitement A et B avec le test choisi à l'exercice 2.
# Fonctions : t.test(y ~ groupe, data = ..., var.equal = ...) ou wilcox.test(y ~ groupe, data = ...)


# A FAIRE 3.2 : pour GENE2, lancez aussi un t-test et comparez les p-values.
# Pour GENE3, comparez t.test avec var.equal = TRUE et var.equal = FALSE (degrés de liberté, p-value).


# QUESTION 3.1 : pour GENE1, quelle est la différence de moyennes estimée, son intervalle de confiance
# à 95 % et la p-value ? Concluez en une phrase.
# Réponse :

# QUESTION 3.2 : pourquoi rapporte-t-on des médianes (et non des moyennes) pour GENE2 ?
# Réponse :



# ---------------------------------------------------------------------
# EXERCICE 4 : données appariées 
# ---------------------------------------------------------------------
app <- read.csv("expression_apparie.csv")
str(app)

# A FAIRE 4.1 : GENE_A avant / après traitement.
#  - calculez les différences (après - avant) ; testez leur normalité (shapiro.test + qqnorm)
#  - choisissez et lancez le test : t.test(apres, avant, paired = TRUE) ou wilcox.test(..., paired = TRUE)


# A FAIRE 4.2 : même démarche pour IL6_avant / IL6_apres.


# A FAIRE 4.3 : refaites le t-test de GENE_A SANS paired = TRUE.
# QUESTION 4 : que devient la p-value ? Pourquoi est-ce une erreur d'ignorer l'appariement ?
# Réponse :
