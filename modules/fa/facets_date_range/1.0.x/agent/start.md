# Facets Date Range — agent index

Adds a Date Range Picker widget + processor to the Facets module so users filter search results by a
min/max date. Depends on `facets`. No admin page of its own (`configure` null); configured per facet on
the Facets edit form. No permissions.

- **The two facets plugins (widget + processor), their config, and how to set them up on a facet** →
  [plugins/date_range.md](plugins/date_range.md)

Key facts:
- Widget `date_range` (`WidgetPluginBase`), query type `range`, requires the `date_range` processor.
- Processor `date_range` runs at `pre_query` (60) and `build` (20); option `max_inclusive` (default off).
- JS library `facets_date_range/date-range` rewrites the facet URL from
  `drupalSettings.facets.daterange[<facet id>].url`.
- Config schema: `facet.widget.config.date_range` (min_label/max_label),
  `plugin.plugin_configuration.facets_processor.date_range` (max_inclusive).
