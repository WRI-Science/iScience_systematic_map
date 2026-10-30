# Domain-by-method co-occurrence heatmap and marginal bar charts.

topics_data <- data_included[topic_columns] == "x"
methods_data <- data_included[method_columns] == "x"

co_occurrence <- matrix(
  0,
  nrow = length(topic_columns),
  ncol = length(method_columns),
  dimnames = list(topic_columns, method_columns)
)

for (i in seq_len(nrow(data_included))) {
  paper_topics <- topic_columns[unlist(data_included[i, topic_columns] == "x")]
  paper_methods <- method_columns[unlist(data_included[i, method_columns] == "x")]
  for (topic in paper_topics) {
    for (method in paper_methods) {
      co_occurrence[topic, method] <- co_occurrence[topic, method] + 1
    }
  }
}

topic_method_df <- as.data.frame(as.table(co_occurrence))
colnames(topic_method_df) <- c("Topic", "Method", "Co_occurrence")

topic_counts_df <- data.frame(
  topic = names(colSums(topics_data)),
  count = as.numeric(colSums(topics_data))
) %>%
  arrange(desc(count))

method_counts_df <- data.frame(
  method = names(colSums(methods_data)),
  count = as.numeric(colSums(methods_data))
) %>%
  arrange(desc(count))

topic_method_df$Method <- factor(topic_method_df$Method, levels = method_counts_df$method)
topic_method_df$Topic <- factor(topic_method_df$Topic, levels = topic_counts_df$topic)

topic_bar <- ggplot(topic_counts_df, aes(x = reorder(topic, -count), y = count)) +
  geom_bar(stat = "identity", fill = "#B22222") +
  coord_flip() +
  theme_classic() +
  theme(
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.line = element_blank(),
    plot.margin = margin(0, 10, 0, 0)
  )

method_bar <- ggplot(method_counts_df, aes(x = reorder(method, -count), y = count)) +
  geom_bar(stat = "identity", fill = "#B22222") +
  theme_classic() +
  theme(
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.line = element_blank(),
    plot.margin = margin(0, 0, 10, 0)
  )

topic_method_df <- topic_method_df %>%
  group_by(Topic) %>%
  mutate(Label = as.character(Co_occurrence)) %>%
  ungroup()

heatmap <- ggplot(topic_method_df, aes(x = Method, y = Topic, fill = Co_occurrence)) +
  geom_tile() +
  geom_text(
    aes(
      label = Label,
      color = ifelse(
        Topic == "natural.ecosystems" & Method == "field.survey",
        "black",
        "white"
      )
    ),
    size = 2,
    fontface = "bold"
  ) +
  scale_fill_gradientn(
    colors = c("black", "#b22222", "#ff8c00", "#FFD700"),
    values = scales::rescale(c(0, 0.1, 0.3, 0.6, 1))
  ) +
  scale_color_identity() +
  labs(x = "Method", y = "Domain") +
  theme_classic() +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    axis.title = element_blank()
  ) +
  scale_x_discrete(labels = method_labels) +
  scale_y_discrete(labels = topic_labels)
