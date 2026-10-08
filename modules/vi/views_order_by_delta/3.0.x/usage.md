<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Order By Delta adds a Views sort handler that orders results by the **delta** of a multi-value **entity reference** field — the position an editor put each referenced item in — so a listing built through that reference respects the chosen order instead of falling back to the referenced entity's title or date.

---

When an editor drags several referenced items into a deliberate order on an entity's edit form, that order is stored as the reference field's `delta` column. A view that joins to the referenced entities (through a relationship built on that field) can display them, but its sort options are the *referenced entity's* properties — title, created date, ID — none of which is the editorial order. Views does expose a native "field:delta" sort, but through a relationship it produces duplicated rows that `distinct`/`pure distinct` cannot collapse. This module works around that: on `hook_views_data()` it scans every entity type that has a Views-data handler, and for each **`entity_reference`** field storage whose dedicated field table has a `delta` column it registers a sort named "Order by delta (using {field})" on the entity's **base table**. Its sort plugin (`order_by_delta`, a `SortPluginBase`) only adds the `ORDER BY delta` when the field's table is already joined into the query (via the relationship), so removing the relationship removes the sort cleanly rather than forcing an unwanted join. The only dependency is core `views`; there is no configuration, no permissions, and no UI beyond the Views editor. Note the scope is `entity_reference` fields specifically — plain multi-value text and `entity_reference_revisions` (Paragraphs) fields are not registered. The release is **3.0.0-alpha2**, core range `^8.9 || ^9 || ^10 || ^11`.

---

- Sort a view by the order an editor chose in a reference field.
- Respect drag-and-drop order stored as a reference field's delta.
- List entities referenced from another entity in their stored sequence.
- Build a slideshow whose slides follow the reference field order.
- Show a taxonomy term's referenced nodes in the term-page order.
- Avoid duplicated rows from Views' native delta sort through a relationship.
- Avoid a global weight field on the referenced entity type.
- Avoid Entityqueue/Nodequeue for a single reference field's ordering.
- Order a curated "featured content" list by editorial position.
- Keep a related-links block in the author-chosen order.
- Preserve manual curation in a Views block or page display.
- Order a manually arranged team or staff listing.
- Show a related-products list in the merchandiser's order.
- Keep listing order consistent with the reference widget on the edit form.
- Order items referenced from a Config Pages entity by delta.
- Combine the delta sort with other Views sort criteria.
- Sort ascending or descending on the reference delta.
- Respect reference ordering in an exported Views feed or REST display.
- Drive a gallery's image order from an entity-reference field's arrangement.
- Order a curated menu-like list without a weight column.
- Reuse one reference field to both relate and order entities in a view.
- Keep a "see also" block in the editor's intended sequence.
