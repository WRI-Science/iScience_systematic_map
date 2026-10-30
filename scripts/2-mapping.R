# Country-level maps of included papers.

country_counts <- data_included %>%
  separate_rows(country, sep = ",\\s*") %>%
  mutate(country = standardize_countries(country)) %>%
  count(country, sort = TRUE) %>%
  group_by(country) %>%
  summarize(count = sum(n), .groups = "drop")

message("Number of unique countries: ", nrow(country_counts))
print(country_counts %>% arrange(desc(count)) %>% head(10))

world <- ne_countries(scale = "medium", returnclass = "sf")
map_data <- world %>%
  left_join(country_counts, by = c("admin" = "country"))

missing_countries <- setdiff(country_counts$country, world$admin)
message(
  "Country names not matched to Natural Earth (expected: none, global): ",
  paste(missing_countries, collapse = ", ")
)

theme_map <- theme_classic() +
  theme(
    legend.position = c(0.1, 0.2),
    legend.justification = c(0.1, 0.2),
    legend.background = element_blank(),
    legend.key = element_blank()
  )

all_data <- ggplot(map_data) +
  geom_sf(aes(fill = count)) +
  scale_fill_gradientn(
    colors = c("#B22222", "#ffbc00", "#ffd700"),
    na.value = "black",
    name = NULL
  ) +
  theme_map +
  ggtitle("b.) All papers")

count_by_domain <- function(df, domain_col) {
  df %>%
    filter(.data[[domain_col]] == "x") %>%
    separate_rows(country, sep = ",\\s*") %>%
    mutate(country = standardize_countries(country)) %>%
    count(country, sort = TRUE) %>%
    group_by(country) %>%
    summarize(count = sum(n), .groups = "drop")
}

natural_map_data <- world %>%
  left_join(count_by_domain(data_included, "natural.ecosystems"), by = c("admin" = "country"))

natural <- ggplot(natural_map_data) +
  geom_sf(aes(fill = count)) +
  scale_fill_gradientn(
    colors = c("#006400", "#ffbc00", "#ffd700"),
    na.value = "black",
    name = NULL
  ) +
  theme_map +
  ggtitle("c.) Habitats")

social_map_data <- world %>%
  left_join(count_by_domain(data_included, "communities"), by = c("admin" = "country"))

social <- ggplot(social_map_data) +
  geom_sf(aes(fill = count)) +
  scale_fill_gradientn(
    colors = c("#763816", "#ffbc00", "#ffd700"),
    na.value = "black",
    name = NULL
  ) +
  theme_map +
  ggtitle("d.) Communities")
