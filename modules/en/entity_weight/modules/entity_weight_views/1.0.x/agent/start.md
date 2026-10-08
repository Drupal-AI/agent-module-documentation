<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Weight Views (entity_weight_views) — agent index

Submodule of **entity_weight**. Gives a chosen Views display its own independent drag-and-drop order,
stored in a custom table and injected into the view query at highest priority. Package `Custom`.
Core `^10.1 || ^11`. License GPL-2.0-or-later. Version 1.0.2.
Depends on `entity_weight`, core `views`, core `contextual`. No new permission — reuses the parent's
`assign entity weight`.

## Solution docs
- **Per-view reorder form, custom table, query injection, multilingual model** →
  [reorder/view-order.md](reorder/view-order.md)
- Parent module → [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md)

## What it provides (from source)
- **Config object** `entity_weight_views.settings` (`config/schema`): `enabled_views` (sequence of
  `view_id:display_id`), `customized` (sequence of `view_id:display_id:langcode`). Defaults `[]`.
- **Route** `entity_weight_views.order` — `/admin/structure/entity-weight/view-order/{view_id}/{display_id}`,
  form `ViewOrderForm`, perm `assign entity weight`.
- **Database table** `entity_weight_views_order` (`entity_weight_views.install`, `hook_schema`):
  columns `view_id`, `display_id`, `entity_id`, `weight`, `langcode`; PK
  (view_id, display_id, entity_id, langcode). Update hooks 10001-10003 create the table, drop a legacy
  `entity_type` column, and promote per-language rows to a single shared `und` order.
- **Hooks** (`entity_weight_views.module`): `hook_views_query_alter` (injects the order via COALESCE),
  `hook_views_post_render` (adds the contextual link + cache context/tag),
  `hook_form_entity_weight_settings_form_alter` (+ submit) to pick which displays are enabled.
- **Views area plugin** `entity_weight_reorder_link` (`ReorderLink`, `entity_weight_views.views.inc`
  `hook_views_data`) — optional visible "Reorder items" button (permission-checked).
- **Contextual link** `entity_weight_views.reorder` (`*.links.contextual.yml`).
- **Library** `entity_weight_views/cutoff` (`css/cutoff.css`, `js/cutoff.js`) — keeps the
  visible/below-limit status column in sync while dragging.

## Mechanism in one line
Selected displays get a reorder form that writes per-(view, display, entity, language) weights into
`entity_weight_views_order`; `hook_views_query_alter` prepends
`ORDER BY COALESCE(langWeight, sharedWeight, 0)` so that order wins over the view's own sorts.
