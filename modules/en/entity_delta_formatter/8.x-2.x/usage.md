<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Delta Formatter renders only a chosen subset of an entity_reference field's referenced entities, selected by delta.

---

Entity Delta Formatter adds one field formatter, **"Rendered entities by delta"** (plugin id `entity_reference_delta_formatter`), for `entity_reference` fields. It extends core's *Rendered entity* formatter, so referenced entities are still displayed through `entity_view()` with their view mode, view access and normal field sanitization intact. Its single extra setting, **Deltas**, restricts which items of a multi-value reference field are rendered: positions are 1-based, a negative number counts back from the end, an underscore marks an inclusive range, and commas combine selections (for example `1_3, -1` renders the first three items plus the last). It is a display-only feature in the Fields package with no permissions, routes, services, or dependencies beyond Drupal core.

---

- Show only the first referenced entity of a multi-value reference field.
- Show only the last referenced entity using `-1`.
- Render the second-to-last referenced item with `-2`.
- Display the first three referenced entities with the range `1_3`.
- Display every item except the first with `2_-1`.
- Combine a range and a tail item, e.g. `1_3, -1`.
- Feature the top-ranked referenced item at the top of a page.
- Render a "hero" referenced node separately from the rest of the list.
- Split one reference field across two display regions by using two view displays with different deltas.
- Show a curated highlight (single delta) on a teaser view mode.
- Show a fuller range on the full/default view mode.
- Limit a large reference list to a fixed number of items without a View.
- Render just one media/image reference selected by position.
- Display a single referenced taxonomy term chosen by delta.
- Pick specific paragraph deltas to render on an entity.
- Render only the most recent (last) referenced entity in an ordered field.
- Present the first item in one place and the remainder elsewhere via separate displays.
- Avoid building a full Views listing when you only need N fixed positions.
- Reorder emphasis by choosing non-contiguous deltas, e.g. `1, 3, 5`.
- Constrain output length for performance on long reference fields.
- Configure the selection per bundle and per view mode from Manage display.
- Use the same referenced-entity view-mode rendering as core, but scoped to chosen deltas.
- Export the delta selection in the view-display config for deployment.
- Keep referenced-entity access checks by relying on core's rendered-entity pipeline.
- Show a single spotlight reference in a block-placed field.
