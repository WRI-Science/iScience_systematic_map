# Chord diagram of co-occurring methods (papers with more than one method).

methods_flag <- data_included[method_columns]
methods_flag[] <- lapply(methods_flag, function(x) trimws(x) != "")

papers_with_multiple_methods <- methods_flag[rowSums(methods_flag) > 1, ]

if (nrow(papers_with_multiple_methods) == 0) {
  stop("No papers with more than one method.")
}

co_occurrence_matrix <- matrix(
  0,
  nrow = length(method_columns),
  ncol = length(method_columns),
  dimnames = list(method_columns, method_columns)
)

for (i in seq_len(length(method_columns) - 1)) {
  for (j in (i + 1):length(method_columns)) {
    n <- sum(papers_with_multiple_methods[, i] & papers_with_multiple_methods[, j])
    co_occurrence_matrix[i, j] <- n
    co_occurrence_matrix[j, i] <- n
  }
}

co_occurrence_matrix[lower.tri(co_occurrence_matrix)] <- 0

upper_triangle_indices <- which(upper.tri(co_occurrence_matrix), arr.ind = TRUE)
co_occurrence_df_methods <- data.frame(
  from = unname(method_labels[rownames(co_occurrence_matrix)[upper_triangle_indices[, 1]]]),
  to = unname(method_labels[colnames(co_occurrence_matrix)[upper_triangle_indices[, 2]]]),
  value = co_occurrence_matrix[upper_triangle_indices]
)

methods_order <- unname(method_labels[method_columns])
methods_colors <- setNames(
  c("#006400", "#3B4E0B", "#763816", "#B22222", "#CB4516", "#E5680B", "#FF8C00"),
  methods_order
)

draw_methods_chord <- function() {
  chordDiagram(
    co_occurrence_df_methods,
    grid.col = methods_colors,
    order = methods_order,
    transparency = 0.5,
    annotationTrack = c("name", "grid"),
    preAllocate = 1
  )
}
