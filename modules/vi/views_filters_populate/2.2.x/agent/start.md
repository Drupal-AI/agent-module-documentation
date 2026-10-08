<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Views Filters Populate — agent index

Ships one Views filter plugin, `views_filters_populate` (class `Populate`), that lets one
filter's submitted value populate the `value` of one or more **other, non-exposed** filters
in the same display. No settings form, no configure route (`configure: null`), no permissions,
no Drush, no plugin type of its own — it implements the core Views `filter` plugin type.

- **What the plugin does, its constraints, how it's stored in a view, the exposed-empty
  removal behavior, and a config-schema quirk to be aware of** →
  [plugins/populate-filter.md](plugins/populate-filter.md)

Key facts:
- Plugin id `views_filters_populate`; real stored option is `filters` (array of target filter
  machine names) — **not** the `fields` key implied by the shipped (orphaned) schema file.
- Target filters must be non-exposed `StringFilter` or `NumericFilter` handlers; the populate
  filter itself is usually the exposed one.
- Config path: `views.view.<id>` →
  `display.<display_id>.display_options.filters.<handler_id>` where
  `plugin_id: views_filters_populate` and `filters: [<target_id>, ...]`.
