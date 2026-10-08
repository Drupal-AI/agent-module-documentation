<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Exposed Filters — agent index

Provides one **Views filter** plugin, `eref_node_titles`, that exposes an entity-reference
relationship as a dropdown of referenced node **titles**. No admin UI (`configure: null`), no
permissions, no Drush. Depends on core Views.

- **Add & configure the filter in a View (relationship requirement, options, config shape)** →
  [configure/views-filter.md](configure/views-filter.md)

Key facts:
- Filter id **`eref_node_titles`** (class `EREFNodeTitles extends ManyToOne`), registered on the
  `node_field_data` table by `hook_views_data_alter()`.
- Requires a standard **node entity-reference relationship** ("Content referenced from …") in the
  View; the filter is **always exposed** and marks itself broken with no valid relationship.
- Extra options: `sort_by` (nid/title), `sort_order`, `sort_bundle_order` (ASC/DESC),
  `get_unpublished` (Unpublished/Published/All), `get_filter_no_results`.
- Node references only — not taxonomy terms or users; view-backed reference fields unsupported.
