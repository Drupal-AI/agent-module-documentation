<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Views (droost_views) — agent index

Submodule of **Droost**: Views tooling for AI agents, over MCP. Version 1.0.0-rc1 (dir `1.0.x`). Core
`^10.3 || ^11 || ^12`, PHP `^8.3`. Depends on `droost` and `views`. Local development only.

## MCP tools (`src/Plugin/Tool/`)

Read-only (extend `DroostToolBase`):
- **`droost_views_handlers`** — resolves each field of a bundle to its Views handler coordinates
  (storage table/column, filter/sort plugin ids, supported filter ops). Use before composing.
- **`droost_views_get`** — reads a view as an abstract model per display (default-display inheritance
  resolved: rows + view mode, style, pager, path, filters, sorts; block displays' Canvas component
  id). Omit `view` to list all views.
- **`droost_views_execute`** — executes a display with optional exposed-filter input; returns total
  row count + first rows `{id, label}`. The verify half of compose.

Write (extends `DestructiveToolBase`):
- **`droost_views_compose`** — composes a complete listing view of one bundle from an intent spec
  (view-mode rows, page/block displays, grid/list style, sorts, exposed filters with expose config).
  **Gated** by `allow_config_write` (or master `allow_destructive`), **CLI-only**
  (`requireCliTransport() ?? gate('allow_config_write')`).

## Services / helpers

- `droost_views.handler_resolver` (`HandlerResolver`) + `FilterShape` — the field-to-handler and
  filter-operator mapping shared by the tools.

## Solution doc

- The four tools, the handlers → compose → execute loop and gating → [tools/views.md](tools/views.md)
