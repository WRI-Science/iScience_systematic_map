# Raw database exports

These files document the PRISMA identification step. Analysis scripts do not read them; they read `../data-revision.csv`.

| File | Database | Date | Rows |
|------|----------|------|-----:|
| `wos_march_2024.csv` | Web of Science | 25 March 2024 | 1,755 |
| `wos_january_2025.csv` | Web of Science | 2 January 2025 | 2,051 |
| `wos_new_january_2025.csv` | Web of Science | 2 January 2025, not in the March export by DOI | 289 |
| `pubmed_july22_2025.csv` | PubMed | 22 July 2025 | 466 |
| `pubmed_unique_added.csv` | PubMed | 22 July 2025, not already in Web of Science | 110 |

Scored Web of Science total: 1,755 + 289 = 2,044.  
PubMed records already in Web of Science: 466 − 110 = 356.
