# Resistance vs recovery coding by domain.

component_data <- data_included %>%
  mutate(
    resistance_recovery = case_when(
      resistance == "x" & recovery == "x" ~ "Both",
      resistance == "x" ~ "Resistance",
      recovery == "x" ~ "Recovery",
      TRUE ~ "Neither"
    )
  ) %>%
  filter(resistance_recovery != "Neither")

topic_resistance_recovery_count <- component_data %>%
  pivot_longer(
    cols = all_of(topic_columns),
    names_to = "topic",
    values_to = "used"
  ) %>%
  filter(used != "") %>%
  group_by(topic, resistance_recovery) %>%
  summarise(count = n(), .groups = "drop") %>%
  group_by(topic) %>%
  mutate(
    total_count = sum(count),
    percentage = count / total_count * 100
  ) %>%
  ungroup() %>%
  mutate(topic = fct_reorder(topic, total_count, .desc = TRUE))

resilience_component_plot <-
  ggplot(
    topic_resistance_recovery_count,
    aes(x = topic, y = percentage, fill = resistance_recovery)
  ) +
  geom_bar(stat = "identity") +
  geom_text(aes(y = 105, label = total_count), size = 3) +
  labs(x = NULL, y = "Percentage (%)", fill = NULL) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(
    values = c("Resistance" = "#B22222", "Recovery" = "#FF8C00", "Both" = "#006400")
  ) +
  scale_x_discrete(labels = topic_labels)
