<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Parity Row — agent index

Provides a Views **row plugin** `views_parity_row_entity:<entity_type>` (derivative of core's
Entity row, one per entity type with a view builder) that renders rows in a primary view mode but
switches to an **alternate view mode** either on a repeating cadence (every X rows, with optional
start/end) or per specific row (rows 1–20). All state lives in the view's display `row` options;
no admin page (`configure: null`), no permission, no Drush.

- **Configure it on a view (row options keys, cadence vs per-row, config schema/drush)** →
  [configure/row-options.md](configure/row-options.md)
- **The plugin internals: derivative, options, and the preRender cadence math** →
  [plugins/entity-row.md](plugins/entity-row.md)

Key facts:
- Row plugin id: `views_parity_row_entity:<entity_type>` (e.g. `views_parity_row_entity:node`),
  labelled "<Entity> (alternate)" in the Views "Format → Show" row selector.
- Cadence keys: `views_parity_row_enable` (bool) + `views_parity_row.{frequency,start,end,view_mode}`.
- Per-row keys: `views_parity_row_per_row_enable` (bool) + `views_parity_row_per_row.view_mode_<1..20>`.
- Config schema: `views.row.views_parity_row_entity:*` (in `config/schema/views_parity_row.views.schema.yml`).
- A row uses the alternate mode when `(current_item - start) % frequency === 0` within the start/end
  bounds; the pager offset is added so the cadence continues across pages.
