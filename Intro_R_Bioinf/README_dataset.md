# Jeu de données d'exemple Introduction à R (Bioinfomatique)
# Enseingant : Yanis Zirem | E-mail : yanis.zirem@univ-lille.fr 
Ces deux fichiers sont des **données synthétiques** (générées, pas réelles) conçues pour être cohérentes avec les exemples de code du cours et de l'exercice pratique 

## Fichiers

### `metadonnees.csv`
Métadonnées des 12 échantillons.
| Colonne | Description |
|---|---|
| `id` | Identifiant de l'échantillon (S1 à S12) |
| `condition` | `contrôle` (S1–S6) ou `traité` (S7–S12) |
| `age` | Âge simulé du sujet |

### `expression_matrix.csv`
Matrice d'expression : 40 gènes (lignes) × 12 échantillons (colonnes), valeurs en échelle log2.
- Première colonne : `gene` (symbole du gène)
- Colonnes suivantes : une par échantillon (S1 à S12), à croiser avec `metadonnees.csv` via cette colonne


## Utilisation avec le code du support

```r
expr <- read.csv("expression_matrix.csv", row.names = 1)
donnees_meta <- read.csv("metadonnees.csv")
```

Note : dans les slides du support, `dim(expr)` est illustré avec un exemple fictif de 20 000 gènes — ce jeu de données réel ne compte que 40 gènes, volontairement réduit pour rester manipulable et lisible pendant la séance.

Pour reproduire un data frame long façon `donnees` (une ligne = un gène × un échantillon, utilisé dans les exemples dplyr/ggplot2 ) :

```r
library(tidyr)
library(dplyr)

donnees <- expr |>
  tibble::rownames_to_column("gene") |>
  pivot_longer(-gene, names_to = "id", values_to = "expression") |>
  left_join(donnees_meta, by = "id")
```
