<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views moderation state weights — agent index

Exposes each Content Moderation state's **weight** to Views as a field + sort handler, so views
can order content by editorial workflow position instead of alphabetically. No config UI
(`configure: null`), no permissions, no Drush, no exported config. Requires `content_moderation`,
`views`, `workflows`.

- **The two Views handlers, the views data, and the internal weights table/sync** →
  [plugins/views-handlers.md](plugins/views-handlers.md)

Key facts:
- Views field handler id **`moderation_state_weight_field`**, sort handler id
  **`moderation_state_weight_sort`**, both titled "Moderation state weight", added to every
  *moderated* entity's data table + revision table by `hook_views_data()`.
- Backed by an internal DB table **`views_moderation_state_weights`** (PK `workflow` +
  `moderation_state`, column `weight`), populated on install and re-synced on `content_moderation`
  workflow insert/update/delete. It is `@internal` — rebuilt from workflow config, not authored.
- Handlers only appear on entity types that actually have a content_moderation workflow assigned.
