# Codebook for `data-revision.csv`

One row = one bibliographic record. Screening and coding were done by a single reviewer. After `read.csv()` in R, spaces and punctuation in headers become `.` (e.g. `inclusion (y/n)` → `inclusion..y.n.`).

## Identification

| Column | Description |
|--------|-------------|
| Search date | Date of the database search that contributed the record |
| Database | `WoS` or `PubMed` |
| Order | Original export order within that search |
| Publication Type | Web of Science type (`J` journal, `C` conference, `S` serial, `B` book). Blank for PubMed rows |
| Authors, Article Title, Source Title, Publication Year, DOI, DOI Link | Bibliographic fields |
| UT (Unique WOS ID) | Web of Science unique identifier (blank for PubMed-only records) |
| Notes | Free-text screening notes |

## Screening

| Column | Description |
|--------|-------------|
| inclusion (y/n) | `y` included in the map (n = 1,563); `n` excluded (n = 591) |
| reason for exclusion | One of: `not about wildfire`; `not about resilience`; `book chapters, conference or poster abstracts`; `no access`; `a correction, a duplicate, special issue forward`; `published in 2025`; `not in english`; `Lancet countdown`; `letter`; `preprint`; `duplicate`; `dataset` |
| About resilence? (resilience used in the text) | Whether the paper uses the term resilience (`y`/`n`) |
| vulnerability reclassified | Internal recode flag |

## Methods (mark `x` if used)

`people survey`; `experiment`; `field survey`; `satellite survey/data/remote sensing`; `modeling`; `data science/large datasets`; `framework/synthesis/revies`; `other` (method other, not used in figures)

## Domains (mark `x` if the paper addresses that domain)

Paper labels in parentheses:

- `natural ecosystems` (Habitats)
- `biodiversity` (Species)
- `carbon` (Carbon)
- `air quality` (Air)
- `water security` (Water)
- `economies` (Livelihoods)
- `infrastructure` (Infrastructure)
- `communities` (Communities)
- `senseofplace` (Sense of place)
- `management` and domain `other` are coded in the sheet but not used in the published figures

`multiple` is a derived count of domains.

## Resilience components (mark `x` if addressed)

`resistance`; `recovery`; `adaptive capacity`; `vulnerability`

## Other coding fields

| Column | Description |
|--------|-------------|
| resilience notes | Quotations or paraphrases of how resilience is used |
| clear definition | Whether the paper defines resilience (`y`/`n`) |
| source | Cited definition source(s) |
| country | Study geography; comma-separated if more than one. `global` / `none` used when not mappable |
| combination | Concatenated domain labels |
| match | Internal check |
| multiple-methods | Count of methods marked |
| no-sub-resilience-topic | Internal flag |
