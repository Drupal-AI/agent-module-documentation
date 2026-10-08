<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy term depth — agent index

Adds a `depth_level` **integer base field** to every taxonomy term (root = 1, child = 2, …),
kept current automatically on term insert/update, and exposed to Views. Depends on core
`taxonomy`. No admin settings page (`configure: null`), no permissions of its own (forms use
`administer taxonomy`). Provides a legacy Drush command. Defines no plugin type.

- **The `depth_level` field, how depth is computed/stored, and the procedural read API**
  → [api/depth-functions.md](api/depth-functions.md)
- **Recalculating depths (Update-term-depths form/operation, queue service, install batch),
  Views integration, and uninstall (`drush tdpu`)**
  → [configure/update-and-views.md](configure/update-and-views.md)

Key facts: value stored in the `taxonomy_term_field_data.depth_level` column and readable via
the `depth_level` field on a loaded `Term`. Auto-updated by
`taxonomy_term_depth_entity_insert/update`. Recompute a single term with
`taxonomy_term_depth_get_by_tid($tid, TRUE)` (force), or a whole vocabulary via the
`taxonomy_term_depth.queue_service` (`->setVid($vid)->queueBatch()`) or the *Update term depths*
task at `/admin/structure/taxonomy/manage/{vocabulary}/taxonomy_term_depth_update`.
