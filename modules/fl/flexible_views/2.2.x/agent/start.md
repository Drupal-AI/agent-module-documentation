# Flexible Views — agent index

Three Core Views plugins for user-controllable table columns and exposed filters. Configured
in the Views UI only — no settings page (`configure` null), no permissions, no Drush. Depends
on `views`. Provides config schema for each plugin.

- **The three plugins (Flexible Table style, Visible Column Selector filter, Manual selection
  exposed form), how to wire them together, settings, and the templates** →
  [configure/plugins.md](configure/plugins.md)

Key facts:
- Style `flexible_table` (`FlexibleTable`), filter `column_selector` (`ColumnSelector`, added
  via `hook_views_data_alter`), exposed form `manual_selection` (`ManualSelection`).
- Column choice/order travels as JSON in the `selected_columns_submit_order` query/session key;
  identifiers are matched to the view's known fields (no free-text output sink).
- Theme hooks `views_view_flexible_table` and `flexible_views_style_plugin_flexible_table`
  (templates + `flexible_views.theme.inc`); JS/CSS libraries `column_selector`, `manual_selection`.
