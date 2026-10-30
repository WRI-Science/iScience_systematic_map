# Write publication figures to figures/.

graphical_abstract <- domains_over_time_plot + all_data
ggsave(
  "figures/graphical-abstract.png",
  graphical_abstract,
  width = 12,
  height = 8,
  dpi = 600
)

final_plot <- (domains_over_time_plot + all_data) / (natural + social)
ggsave("figures/figure-1.png", final_plot, width = 12, height = 8, dpi = 600)

ggsave("figures/method-bar.png", plot = method_bar, width = 5, height = 1, dpi = 300)
ggsave("figures/topic-bar.png", plot = topic_bar, width = 4, height = 5, dpi = 300)
ggsave("figures/heatmap.png", plot = heatmap, width = 5, height = 3, dpi = 300)

ggsave(
  "figures/topic-topic-heatmap.png",
  plot = topic_topic_heatmap,
  width = 6,
  height = 5,
  dpi = 300
)

png("figures/methods-chord.png", width = 735, height = 443)
draw_methods_chord()
dev.off()

ggsave(
  "figures/combined-multiples.png",
  plot = combined_multiples,
  width = 12,
  height = 5,
  dpi = 300
)

ggsave(
  "figures/resilience-component.png",
  plot = resilience_component_plot,
  width = 6,
  height = 5,
  dpi = 300
)
