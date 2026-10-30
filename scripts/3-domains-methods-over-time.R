# Stacked area charts of domains and methods over time.

df_long <- data_included %>%
  select(Publication.Year, all_of(topic_columns)) %>%
  pivot_longer(
    cols = -Publication.Year,
    names_to = "category",
    values_to = "presence"
  ) %>%
  mutate(presence = trimws(tolower(presence))) %>%
  drop_na(presence) %>%
  filter(presence == "x") %>%
  group_by(Publication.Year, category) %>%
  summarize(count = n(), .groups = "drop") %>%
  mutate(category = fct_reorder(category, count, .fun = "sum"))

domains_over_time_plot <-
  ggplot(df_long, aes(x = Publication.Year, y = count, fill = category)) +
  geom_area(position = "stack", color = "white", linewidth = 0.1) +
  scale_fill_manual(values = wildfire_colors, labels = topic_labels) +
  theme_classic() +
  labs(x = "Publication Year", y = "Count") +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = c(0.2, 0.6)
  ) +
  guides(fill = guide_legend(title = NULL)) +
  ggtitle("a.) Frequency of domains over time")

methods_df_long <- data_included %>%
  select(Publication.Year, all_of(method_columns)) %>%
  pivot_longer(
    cols = -Publication.Year,
    names_to = "category",
    values_to = "presence"
  ) %>%
  mutate(presence = trimws(tolower(presence))) %>%
  drop_na(presence) %>%
  filter(presence == "x") %>%
  group_by(Publication.Year, category) %>%
  summarize(count = n(), .groups = "drop") %>%
  mutate(category = fct_reorder(category, count, .fun = "sum"))

methods_over_time_plot <-
  ggplot(methods_df_long, aes(x = Publication.Year, y = count, fill = category)) +
  geom_area(position = "stack", color = "white", linewidth = 0.1) +
  scale_fill_manual(values = wildfire_colors, labels = method_labels) +
  theme_classic() +
  labs(x = "Publication Year", y = "Count") +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = c(0.2, 0.6)
  ) +
  guides(fill = guide_legend(title = NULL)) +
  ggtitle("a.) Frequency of methods over time")
