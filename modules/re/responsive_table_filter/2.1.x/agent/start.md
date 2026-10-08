<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Table Filter — agent index

Adds one text-format filter, **`filter_responsive_table`**, that wraps every `<table>` in a
scrollable wrapper (`<figure class="responsive-figure-table" tabindex="0" aria-label="Scrollable
table">` by default). A tiny CSS library gives that wrapper `overflow-x:auto`. Depends on core
**filter**. No configure route (configure per text format), no permissions, no Drush, no plugin
types.

- **Enable the filter on a text format, its two settings, and where the config lives** →
  [configure/filter.md](configure/filter.md)

Key facts: settings are `wrapper_element` (default `figure`) and `wrapper_classes` (default
`responsive-figure-table`), stored per format at
`filter.format.<format>` → `filters.filter_responsive_table.{status,settings}`. The CSS library
`responsive_table_filter/responsive-table` is attached on every page via
`hook_page_attachments()`. The filter is `TYPE_TRANSFORM_REVERSIBLE` and wraps tables with a
regex at render time; stored markup is unchanged.
