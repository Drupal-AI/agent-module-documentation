<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Taxonomy radios filter — agent index

A Views filter plugin that renders taxonomy-term exposed filters as radios/checkboxes instead of a
select, with a custom "All" label. No config page (`configure` null), no permissions, no Drush.
Depends on core `taxonomy` + `views`. (Version dir `1.0.x` is a dev/pre-release snapshot.)

- **Add/configure the radios/checkboxes filter and the `all_label` option** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Filter plugin `@ViewsFilter("taxonomy_index_tid_radios")` →
  `Drupal\views_taxonomy_radios_filter\Plugin\views\filter\TaxonomyIndexTid` (extends core
  `TaxonomyIndexTid`).
- `hook_field_views_data_alter()` auto-sets the filter id to `taxonomy_index_tid_radios` for every
  `entity_reference` field whose `target_type` is `taxonomy_term`.
- Filter "form element" (type) gains a **Radios/Checkboxes** option; exposed + multiple → checkboxes,
  else radios (`valueForm()`).
- Extra option `all_label` (schema `views.filter.taxonomy_index_tid_radios`) sets the "&lt;Any&gt;"
  label; applied via `hook_form_views_exposed_form_alter()`.
