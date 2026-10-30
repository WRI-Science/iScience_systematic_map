# Geographic and thematic gaps in wildfire resilience research

Repository: https://github.com/WRI-Science/iScience_systematic_map

Code and data for Fong & Halpern, a systematic map of peer-reviewed literature on **wildfire resilience**.

The scored corpus is 2,154 records (1,563 included). Running the scripts regenerates the paper figures from `data/data-revision.csv`.

## Reproduce the figures

1. Install [R](https://www.r-project.org/) (≥ 4.4) and the packages below.
2. Open `wildfire-resilience-review.Rproj`, or `setwd()` to this folder.
3. Run:

```r
source("scripts/00-run-all.R")
```

or from a terminal in this folder:

```bash
Rscript scripts/00-run-all.R
```

Outputs are written to `figures/`.

### R packages

```r
install.packages(c(
  "dplyr", "tidyr", "ggplot2", "stringr", "ggpubr", "patchwork",
  "forcats", "rnaturalearth", "rnaturalearthdata", "sf",
  "circlize", "RColorBrewer", "scales"
))
```

Developed in R 4.4.1 with dplyr 1.1.4, ggplot2 4.0.0, sf 1.0-21, rnaturalearth 1.1.0, and circlize 0.4.16.

## Data

| File | What it is |
|------|------------|
| `data/data-revision.csv` | Scored corpus (n = 2,154). This is the file the scripts read. |
| `data/codebook.md` | Column definitions and inclusion codes |
| `data/raw/wos_march_2024.csv` | Web of Science export, 25 March 2024 (n = 1,755) |
| `data/raw/wos_january_2025.csv` | Web of Science export, 2 January 2025 (n = 2,051) |
| `data/raw/wos_new_january_2025.csv` | January records not in the March export by DOI (n = 289) |
| `data/raw/pubmed_july22_2025.csv` | PubMed export, 22 July 2025 (n = 466) |
| `data/raw/pubmed_unique_added.csv` | PubMed records added after deduplication against Web of Science (n = 110) |

Search term in both databases: `wildfire resilience`.

## PRISMA counts

| Step | n |
|------|--:|
| Identified (Web of Science 2,044 + PubMed 466) | 2,510 |
| Duplicates removed (PubMed already in Web of Science) | 356 |
| Records screened | 2,154 |
| Non–peer-reviewed | 89 |
| Duplicates, corrections, letters, special-issue forwards | 17 |
| Sought for retrieval | 2,048 |
| Not retrieved (no access) | 52 |
| Assessed for eligibility | 1,996 |
| Not about wildfire | 270 |
| Not about resilience | 144 |
| Published in 2025 | 9 |
| Not in English | 5 |
| Lancet Countdown reports | 5 |
| **Included** | **1,563** |

Web of Science 2,044 = March 2024 (1,755) + unique January 2025 update (289).

## Scripts

Run in order via `scripts/00-run-all.R`:

1. `1-read-and-format-data.R` — load corpus, split included/excluded
2. `2-mapping.R` — country maps (all papers, habitats, communities)
3. `3-domains-methods-over-time.R` — stacked area charts
4. `4-heat-and-bars.R` — domain × method heatmap
5. `5-chords-topic.R` — domain co-occurrence heatmap
6. `6-chords-methods.R` — method co-occurrence chord diagram
7. `7-multiple-over-time.R` — papers with 1 / 2 / >2 domains or methods
8. `8-resilience-component.R` — resistance vs recovery by domain
9. `9-figures.R` — write PNGs to `figures/`

## License

Code is MIT (see `LICENSE`). The scored dataset is [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

## Citation

Fong, C. R., & Halpern, B. S. Geographic and thematic gaps in wildfire resilience research.
