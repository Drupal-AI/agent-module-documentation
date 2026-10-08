<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Natural Sort — agent index

Adds a **"natural" Views sort** for string properties (mainly node titles): ignores leading
articles ("The"/"A"), strips configured words/symbols, and sorts embedded numbers numerically. It
keeps a precomputed index table `views_natural_sort` (updated on entity save) and, via
`hook_views_data_alter()`, upgrades eligible `standard` string sorts to id `natural`, adding
**Sort ascending/descending naturally** (`NASC`/`NDESC`) options.

- **Use it in a view (NASC/NDESC), the index table, settings form + config keys, reindex** →
  [configure/natural-sort.md](configure/natural-sort.md)
- **Transformation plugin type (`IndexRecordContentTransformation`) and the shipped plugins** →
  [plugins/transformations.md](plugins/transformations.md)
- **The `views_natural_sort.service` API: supported properties, indexing, rebuild** →
  [api/service.md](api/service.md)
- **Alter hooks to add sortable properties / change the pipeline** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Sort plugin id: `natural` (`@ViewsSort("natural")`), orders `NASC`/`NDESC` (leading `N` = natural).
- Index table `views_natural_sort` (cols `eid, entity_type, field, delta, content`); `content` is the
  transformed, truncated-to-255 string it sorts on.
- Settings: config `views_natural_sort.settings`, form route `views_natural_sort.settings`
  (`/admin/structure/views/settings/views_natural_sort`, permission `administer views`).
- Default transformations: `remove_beginning_words`, `remove_words`, `remove_symbols`, `numbers`
  (all enabled), `days_of_the_week` (disabled).
- No Drush; reindex is the settings form's "Rebuild Index" button or
  `views_natural_sort_queue_data_for_rebuild()` / the service.
