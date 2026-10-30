# Domain co-occurrence heatmap (papers coded to more than one domain).

topic_data <- data_included[topic_columns] == "x"
papers_with_multiple_topics <- topic_data[rowSums(topic_data) > 1, ]

co_occurrence_matrix <- matrix(
  0,
  nrow = length(topic_columns),
  ncol = length(topic_columns),
  dimnames = list(topic_columns, topic_columns)
)

for (i in seq_len(length(topic_columns) - 1)) {
  for (j in (i + 1):length(topic_columns)) {
    n <- sum(papers_with_multiple_topics[, i] & papers_with_multiple_topics[, j])
    co_occurrence_matrix[i, j] <- n
    co_occurrence_matrix[j, i] <- n
  }
}

topic_order <- names(sort(colSums(topic_data), decreasing = TRUE))

topic_topic_df <- as.data.frame(as.table(co_occurrence_matrix)) %>%
  rename(Topic1 = Var1, Topic2 = Var2, Co_occurrence = Freq) %>%
  mutate(
    Topic1 = factor(Topic1, levels = topic_order),
    Topic2 = factor(Topic2, levels = topic_order),
    row_idx = as.integer(Topic1),
    col_idx = as.integer(Topic2),
    Co_occurrence = ifelse(row_idx <= col_idx, NA, Co_occurrence),
    Label = as.character(Co_occurrence),
    text_color = ifelse(!is.na(Co_occurrence) & Co_occurrence < 15, "white", "black")
  )

topic_topic_heatmap <- ggplot(topic_topic_df, aes(x = Topic2, y = Topic1, fill = Co_occurrence)) +
  geom_tile(color = "white") +
  geom_text(
    data = subset(topic_topic_df, !is.na(Co_occurrence)),
    aes(label = Label, color = text_color),
    size = 3.5,
    fontface = "bold"
  ) +
  scale_fill_gradientn(
    colors = c("black", "#b22222", "#ff8c00", "#FFD700"),
    values = scales::rescale(c(0, 0.1, 0.3, 0.6, 1)),
    na.value = "grey95"
  ) +
  scale_color_identity() +
  scale_x_discrete(labels = topic_labels) +
  scale_y_discrete(labels = topic_labels) +
  theme_classic() +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    axis.title = element_blank(),
    legend.title = element_blank()
  )
