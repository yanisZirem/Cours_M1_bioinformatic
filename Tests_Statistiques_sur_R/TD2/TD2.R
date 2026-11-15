# =====================================================================
# TD2 - Tests statistiques sous R : plusieurs groupes, variables catégorielles,
# corrélation, tests multiples
# M1 Bioinformatique
# Enseignant: Yanis Zirem (yanis.zirem@univ-lille.fr) 
#Date : 16/11/2026
#
# Consignes : complétez aux emplacements "A FAIRE", exécutez ligne par ligne
# et répondez aux QUESTIONS en commentaire.
# setwd("chemin/vers/le/dossier")
# =====================================================================
patients <- read.csv("patients.csv", stringsAsFactors = TRUE)
patients$stade <- factor(patients$stade, levels = c("I", "II", "III", "IV"), ordered = TRUE)
patients$tabac <- factor(patients$tabac, levels = c("non", "ancien", "actif"))

# ---------------------------------------------------------------------
# EXERCICE 1 : ANOVA à un facteur (20 min)
# Fichier : expression_soustypes.csv (gene_X mesuré dans 3 sous-types tumoraux)
# ---------------------------------------------------------------------
st <- read.csv("expression_soustypes.csv", stringsAsFactors = TRUE)
str(st)

# A FAIRE 1.1 : effectifs par sous-type, moyenne et écart-type par sous-type, boxplot.


# A FAIRE 1.2 : vérifiez les conditions de l'ANOVA.
#  - normalité : by(st$gene_X, st$sous_type, shapiro.test)
#  - variances égales : bartlett.test(gene_X ~ sous_type, data = st)


# A FAIRE 1.3 : ajustez le modèle : mod <- aov(gene_X ~ sous_type, data = st)
# puis summary(mod). Si l'ANOVA est significative : TukeyHSD(mod).


# QUESTION 1.1 : quelle est H0 de l'ANOVA ? Que vous apprend une ANOVA significative ?
# Réponse :
# QUESTION 1.2 : quelles paires de sous-types diffèrent ? Dans quel sens ?
# Réponse :
# QUESTION 1.3 : pourquoi ne pas faire 3 t-tests ? (risque alpha global pour 3 comparaisons à 5 % ?)
# Réponse :

# ---------------------------------------------------------------------
# EXERCICE 2 : Kruskal-Wallis (15 min)
# Variable IL6 dans les mêmes 3 sous-types
# ---------------------------------------------------------------------
# A FAIRE 2.1 : boxplot de IL6, Shapiro par groupe. Quel test choisir ?


# A FAIRE 2.2 : kruskal.test(IL6 ~ sous_type, data = st), puis les médianes par groupe.


# A FAIRE 2.3 : comparaisons deux à deux avec correction :
# pairwise.wilcox.test(st$IL6, st$sous_type, p.adjust.method = "BH")
# (l'avertissement "ties" est normal : des valeurs identiques existent)


# QUESTION 2 : quelles paires diffèrent ? Que donnerait l'ANOVA sur IL6 ? (summary(aov(...)))
# Réponse :

# ---------------------------------------------------------------------
# EXERCICE 3 : variables catégorielles, chi2 et Fisher (25 min)
# ---------------------------------------------------------------------
# A FAIRE 3.1 : tableau croisé traitement x reponse et pourcentages de réponse par traitement.
# Indice : tab <- table(patients$traitement, patients$reponse) ; prop.table(tab, margin = 1)


# A FAIRE 3.2 : chisq.test(tab), puis regardez les effectifs théoriques : chisq.test(tab)$expected
# Les conditions sont-elles remplies (tous >= 5) ?


# A FAIRE 3.3 : même démarche pour tabac x reponse (tableau 3 x 2).


# A FAIRE 3.4 : petits effectifs. Variant rare et résistance au traitement, 18 patients :
tab3 <- matrix(c(1, 9, 6, 2), nrow = 2, byrow = TRUE,
               dimnames = list(variant = c("present", "absent"),
                               resistance = c("oui", "non")))
tab3
# Calculez les effectifs théoriques. Quel test utiliser ? Lancez-le (fisher.test) et interprétez l'odds ratio.


# QUESTION 3.1 : traitement et réponse sont-ils associés ? Quelle est la différence de taux de réponse ?
# Réponse :
# QUESTION 3.2 : pourquoi le chi2 n'est-il pas fiable pour tab3 ?
# Réponse :

# ---------------------------------------------------------------------
# EXERCICE 4 : corrélation (20 min)
# ---------------------------------------------------------------------
# A FAIRE 4.1 : nuage de points age ~ expr_GENE1 (plot), puis cor.test (Pearson). Interprétez r et p.


# A FAIRE 4.2 : taille_mm ~ expr_GENE2. Tracez en échelle brute puis en log-log.
# Lancez cor.test en Spearman : method = "spearman", exact = FALSE. Comparez avec Pearson.


# A FAIRE 4.3 : stade (ordinal) et taille_mm : Spearman après as.numeric(patients$stade).


# A FAIRE 4.4 : quartet d'Anscombe (jeu fourni avec R)
data(anscombe)
# Calculez cor(x_i, y_i) pour i = 1 à 4 puis tracez les 4 nuages (par(mfrow = c(2, 2))).


# QUESTION 4 : que montre le quartet d'Anscombe sur l'usage du coefficient de corrélation ?
# Réponse :

# ---------------------------------------------------------------------
# EXERCICE 5 : tests multiples (25 min)
# Fichier : expression_genes.csv (300 gènes ; 10 tumeurs T1-T10, 10 tissus normaux N1-N10)
# ---------------------------------------------------------------------
g <- read.csv("expression_genes.csv")
expr <- as.matrix(g[, -1]); rownames(expr) <- g$gene
tum <- grep("^T", colnames(expr)); nor <- grep("^N", colnames(expr))

# A FAIRE 5.1 : un t-test par gène (tumeur vs normal) et récupérez les 300 p-values.
# Indice : pv <- apply(expr, 1, function(x) t.test(x[tum], x[nor])$p.value)
# Combien de gènes ont p < 0.05 ?


# Information (simulation) : les gènes G001 à G030 sont réellement dérégulés, les 270 autres ne le sont pas.
vrai <- rep(FALSE, nrow(expr)); vrai[1:30] <- TRUE
# A FAIRE 5.2 : table(significatif = pv < 0.05, vrai = vrai)
# Combien de faux positifs ? Combien en attendiez-vous (0.05 x 270) ?


# A FAIRE 5.3 : corrigez avec p.adjust(pv, method = "bonferroni") puis method = "BH".
# Comptez les gènes significatifs (p ajustée < 0.05) et les faux positifs / vrais positifs pour chaque méthode.


# QUESTION 5 : quelle correction choisiriez-vous pour une exploration d'un génome entier ? Pourquoi ?
# Réponse :

# ---------------------------------------------------------------------
# BILAN : choisissez le test pour chaque situation (justifiez en 1 ligne)
# ---------------------------------------------------------------------
# 1. Expression (continue, normale) dans 3 sous-types :
# 2. Taux de cytokine (très asymétrique) dans 4 groupes :
# 3. Mutation (oui/non) et réponse (oui/non), 200 patients :
# 4. Mutation rare (oui/non) et réponse, 12 patients :
# 5. Âge et expression d'un gène (continues, relation linéaire) :
# 6. Stade (ordinal) et taille de tumeur :
# 7. Expression de 20 000 gènes, tumeur vs normal :
