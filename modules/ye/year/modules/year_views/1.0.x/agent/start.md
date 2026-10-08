# Year Views — agent index

Submodule of **Year**. Adds one Views filter plugin that renders an exposed year filter as a dropdown
of years built from a configurable (optionally relative) range. Depends on `views` + `year`. No
permissions, no config route.

- **The `year_field` Views filter plugin, its extra-options range/sort settings** → [plugins/filter.md](plugins/filter.md)

Key facts:
- Filter id `year_field` (`YearField` extends `Drupal\views\...\filter\ManyToOne`).
- Options: `year_from` (default `-30 years`), `year_to` (default `+15 years`), `sort_order` (`asc`|`desc`) — bounds accept specific years or relative expressions.
- Dropdown options = `range(calculateYear(year_from), calculateYear(year_to))`.
