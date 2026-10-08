# Views Entity Reference Filter (verf)

Adds a label-based Views filter for entity reference fields. Enabling the module makes a
"(VERF selector)" filter appear next to every entity reference field in the Views UI; it
uses the `verf` filter plugin (extends core `InOperator`) to list referenceable entities
by label instead of by numeric ID. No admin config form, routes, permissions, or Drush.

- [Use the filter in a View + its options](configure/verf.md) — where the "(VERF selector)" filter comes from, `verf_target_bundles`, "Ignore access control", access/translation behavior, config schema.
- [Alter the option list](hooks/verf.md) — `hook_verf_entites_options_alter()` and how `hook_views_data_alter()` generates the handlers.
