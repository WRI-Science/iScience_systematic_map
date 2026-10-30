# Reproduce all figures from the repository root
# (folder that contains data/ and scripts/).
#
#   source("scripts/00-run-all.R")
#
# or, from a terminal:
#
#   Rscript scripts/00-run-all.R

find_repo_root <- function() {
  candidates <- c(getwd())
  if (!is.null(sys.frame(1)$ofile)) {
    candidates <- c(dirname(dirname(normalizePath(sys.frame(1)$ofile))), candidates)
  }
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) == 1) {
    candidates <- c(dirname(dirname(normalizePath(sub("^--file=", "", file_arg)))), candidates)
  }
  for (root in unique(candidates)) {
    if (file.exists(file.path(root, "data", "data-revision.csv"))) {
      return(normalizePath(root))
    }
  }
  stop(
    "Could not find data/data-revision.csv. ",
    "Open the repository .Rproj or setwd() to the folder that contains data/ and scripts/."
  )
}

repo_root <- find_repo_root()
setwd(repo_root)
message("Repository root: ", repo_root)

packages <- c(
  "dplyr", "tidyr", "ggplot2", "stringr", "ggpubr", "patchwork",
  "forcats", "rnaturalearth", "rnaturalearthdata", "sf",
  "circlize", "RColorBrewer", "scales"
)

missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing) > 0) {
  stop(
    "Missing R packages: ", paste(missing, collapse = ", "),
    "\nInstall with:\n  install.packages(c(",
    paste(sprintf('\"%s\"', missing), collapse = ", "),
    "))"
  )
}

invisible(lapply(packages, library, character.only = TRUE))

dir.create("figures", showWarnings = FALSE)

scripts <- file.path(
  "scripts",
  c(
    "1-read-and-format-data.R",
    "2-mapping.R",
    "3-domains-methods-over-time.R",
    "4-heat-and-bars.R",
    "5-chords-topic.R",
    "6-chords-methods.R",
    "7-multiple-over-time.R",
    "8-resilience-component.R",
    "9-figures.R"
  )
)

for (script in scripts) {
  message("Running ", script)
  source(script, local = FALSE)
}

message("All scripts executed. Figures written to figures/.")
print(sessionInfo())
