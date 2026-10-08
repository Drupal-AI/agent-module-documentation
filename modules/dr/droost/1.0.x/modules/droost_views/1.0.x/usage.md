<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Views gives AI agents MCP tools to discover field-to-handler mappings, read views abstractly, compose a listing view from an intent spec, and execute a view to verify its results.

---

Droost Views adds four MCP tools for working with Drupal Views. `droost_views_handlers` resolves every field of an entity bundle to its Views handler coordinates — storage table/column, filter and sort plugin ids, and the filter operators the composer supports (equals, contains, in, min, max, between, …) — so an agent knows what is filterable/sortable before composing. `droost_views_get` reads an existing view as an abstract model (per display, with default-display option inheritance resolved: row rendering + view mode, style, pager, path, filters, sorts, and for block displays the Canvas component id it is placeable as; omit the view to list all views). `droost_views_compose` is a gated declarative composer that turns an intent-level listing spec (entity bundle, view-mode rows, a page display path and/or a Canvas-placeable block display, grid/list style, sorts, and exposed filters with full expose config generated) into validated view config. `droost_views_execute` runs a view display with optional exposed-filter input and returns the real results (total row count + the first rows), the verify half of compose — a composed view can be config-valid yet query wrong. Helpers `HandlerResolver` and `FilterShape` back the mapping. Only the composer changes state (gated by `allow_config_write`, CLI-only). It depends on the Droost base module and Views, and is for local/trusted development only.

---

- Resolve each field of a bundle to its Views filter/sort handler plugin ids.
- Learn which fields are filterable/sortable and which operators each supports.
- Read an existing view as an abstract model (rows, style, pager, path, filters, sorts).
- Resolve default-display option inheritance when reading a view.
- List all views with id and label.
- See which Canvas component id a block display is placeable as.
- Compose a complete listing view of one bundle from an intent-level spec.
- Add a page display (path) and/or a Canvas-placeable block display in one compose call.
- Choose grid or list style and configure sorts.
- Generate full expose config for exposed filters automatically.
- Execute a view display and get the real total row count + first rows.
- Verify a composed view actually returns rows (catch a bad exposed default).
- Pair with `droost_display_compose` for SDC teaser rows.
- Keep view composition gated behind `allow_config_write` and CLI-only.
