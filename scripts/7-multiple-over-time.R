# Counts of papers using 1, 2, or more than 2 methods or domains over time.

count_multiples <- function(df, cols) {
  flagged <- df[cols]
  flagged[] <- lapply(flagged, function(x) trimws(x) != "")
  df %>%
    mutate(n_marked = rowSums(flagged)) %>%
    group_by(Publication.Year) %>%
    summarise(
      `1` = sum(n_marked == 1),
      `2` = sum(n_marked == 2),
      `>2` = sum(n_marked > 2),
      .groups = "drop"
    ) %>%
    pivot_longer(
      cols = c("1", "2", ">2"),
      names_to = "class",
      values_to = "count"
    ) %>%
    mutate(class = factor(class, levels = c("1", "2", ">2")))
}

methods_count_long <- count_multiples(data_included, method_columns)
topics_count_long <- count_multiples(data_included, topic_columns)

multiple_palette <- c("#FFD700", "#CB4516", "#006400")

multiple_methods <- ggplot(
  methods_count_long,
  aes(x = Publication.Year, y = count, fill = class, group = class)
) +
  geom_area(linewidth = 0.1, position = "stack", color = "white") +
  labs(x = "Publication Year", y = "Number of Papers", fill = NULL) +
  theme_classic() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = c(0.2, 0.6)
  ) +
  scale_fill_manual(values = multiple_palette) +
  ggtitle("b.) Multiple methods")

multiple_topics <- ggplot(
  topics_count_long,
  aes(x = Publication.Year, y = count, fill = class, group = class)
) +
  geom_area(linewidth = 0.1, position = "stack", color = "white") +
  labs(x = "Publication Year", y = "Number of Papers", fill = NULL) +
  theme_classic() +
  theme(legend.position = c(0.2, 0.6)) +
  scale_fill_manual(values = multiple_palette) +
  ggtitle("a.) Multiple topics")

combined_multiples <- ggarrange(multiple_topics, multiple_methods)
