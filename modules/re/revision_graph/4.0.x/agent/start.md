<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Graph (revision_graph) — agent index

Adds a **Revision Graph** tab to every node, drawing its revision history as an interactive
graph — one lane per language, a glyph per (revision, language) pair, edges following recorded
or inferred provenance. Version **4.0.0**. Core `^11 || ^12`. No module dependencies
(`content_moderation` is an optional soft dependency, injected only if present).

**New in 4.0 vs 3.1** (new major): dropped Drupal 10; `package` Custom → Content; graph data now
served by a **JSON items endpoint** the client pages through on scroll; a real **settings form +
`administer revision graph` permission** for per-branch colours; a new **`revision_graph_parent`
base field** recording provenance (needs `drush updb` after upgrade); the whole client is a
standalone TypeScript renderer with its own XSS sanitizer.

**Access:** the tab and its JSON endpoint both require the core `view all revisions` operation on
the node (`_entity_access: 'node.view all revisions'`) — no permission of its own gates viewing.
Confirm that on sites where revision history itself is sensitive; a graph makes it much easier to
read.

## Capabilities

- **[Configure lane colours](configure/colors.md)** — settings form, `administer revision graph`
  permission, config keys, and how to set them via drush.
- **[Items endpoint & payload](api/items-endpoint.md)** — routes, the JSON commit/node payload
  shape, paging, and the `revision_graph_parent` provenance base field.

No plugin types, no hooks for others to implement, no Drush commands, no submodules.
