# Load the scored corpus and split included / excluded papers.

data <- read.csv("data/data-revision.csv", stringsAsFactors = FALSE)

message("Records in scored corpus: ", nrow(data))
print(table(data$Database, useNA = "ifany"))

exclude <- subset(data, inclusion..y.n. == "n")
data_included <- subset(data, inclusion..y.n. == "y")

message("Excluded: ", nrow(exclude))
message("Included: ", nrow(data_included))
print(table(exclude$reason.for.exclusion, useNA = "ifany"))

# Domain and method columns used in the figures (named, not positional).
topic_columns <- c(
  "natural.ecosystems", "biodiversity", "carbon", "air.quality",
  "water.security", "economies", "infrastructure", "communities", "senseofplace"
)

method_columns <- c(
  "people.survey", "experiment", "field.survey",
  "satellite.survey.data.remote.sensing", "modeling",
  "data.science.large.datasets", "framework.synthesis.revies"
)

topic_labels <- c(
  "natural.ecosystems" = "Habitats",
  "biodiversity" = "Species",
  "carbon" = "Carbon",
  "air.quality" = "Air",
  "water.security" = "Water",
  "economies" = "Livelihoods",
  "infrastructure" = "Infrastructure",
  "communities" = "Communities",
  "senseofplace" = "Sense of place"
)

method_labels <- c(
  "people.survey" = "Survey (people)",
  "experiment" = "Experiment",
  "field.survey" = "Field survey",
  "satellite.survey.data.remote.sensing" = "Remote sensing",
  "modeling" = "Modeling",
  "data.science.large.datasets" = "Data science",
  "framework.synthesis.revies" = "Synthesis/Reviews"
)

wildfire_colors <- rev(c(
  "#006400", "#3B4E0B", "#763816", "#B22222", "#CB4516",
  "#E5680B", "#FF8C00", "#FFA400", "#FFD700"
))

standardize_countries <- function(x) {
  x <- stringr::str_to_title(trimws(x))
  dplyr::recode(
    x,
    "United States" = "United States of America",
    "United State" = "United States of America",
    "United Stattes" = "United States of America",
    "Czech Republic" = "Czechia",
    "Serbia" = "Republic of Serbia",
    "Tanzania" = "United Republic of Tanzania",
    "Bosnia And Herzegovina" = "Bosnia and Herzegovina",
    "Bosnia" = "Bosnia and Herzegovina",
    "Columbia" = "Colombia",
    "Congo Democratic Republic" = "Democratic Republic of the Congo",
    "Côte D'ivoire" = "Ivory Coast",
    "Eswatini" = "eSwatini",
    "French Guiana" = "France",
    "The Netherlands" = "Netherlands",
    "The United Kingdom" = "United Kingdom",
    "Timor-Leste" = "East Timor",
    "Vatican City" = "Vatican",
    "Zimbabwe." = "Zimbabwe",
    "Scotland" = "United Kingdom",
    "Siberia" = "Russia",
    "Sumatra" = "Indonesia",
    "Canary Islands" = "Spain",
    "Northern Norway" = "Norway",
    "Venezuela." = "Venezuela",
    "Macedonia" = "North Macedonia",
    "Palestinian Territories" = "Palestine",
    "Republic Of Ireland" = "Ireland",
    "Saint Kitts And Nevis" = "Saint Kitts and Nevis",
    "Saint Vincent And The Grenadines" = "Saint Vincent and the Grenadines",
    "Slovak Republic" = "Slovakia",
    "Trinidad And Tobago" = "Trinidad and Tobago",
    "Bahamas" = "The Bahamas"
  )
}
