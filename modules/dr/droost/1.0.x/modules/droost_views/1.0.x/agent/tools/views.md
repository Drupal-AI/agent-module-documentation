<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Views — tools & the handlers → compose → execute loop

Four MCP tools in `src/Plugin/Tool/`, backed by `HandlerResolver` (`droost_views.handler_resolver`)
and `FilterShape`. Intended workflow: **handlers → compose → execute**.

## `droost_views_handlers` (`ViewsHandlers.php`, read-only)

Resolves every field of an entity bundle to its Views handler coordinates: storage table/column,
filter and sort plugin ids, and the filter operators `droost_views_compose` supports for it (equals,
contains, in, min, max, between, …). Call this first to learn which fields are filterable/sortable and
how.

## `droost_views_get` (`ViewsGet.php`, read-only)

Reads a view as an abstract model: per display (with default-display option inheritance resolved) the
row rendering (entity + view mode), style, pager, path, filters (field, op, value, exposed), sorts,
and — for block displays — the Canvas component id the block is placeable as. Omit `view` to list all
views (id, label).

## `droost_views_compose` (`ViewsCompose.php`, gated write)

The declarative composer. Turns an intent-level listing spec into validated view config: rows render
entities in a view mode (pair with `droost_display_compose` for SDC teasers), with a page display
(path) and/or a Canvas-placeable block display, grid/list style, sorts, and filters — exposed filters
get full expose config generated. Extends `DestructiveToolBase`; `execute()` opens with
`requireCliTransport() ?? gate('allow_config_write')`, so it is **disabled by default**, requires
`allow_config_write` (or master `allow_destructive`), and is **CLI-only**.

## `droost_views_execute` (`ViewsExecute.php`, read-only)

Executes a view display with optional exposed-filter input and returns the real results: total row
count plus the first rows as `{id, label}`. The verify half of compose — a composed view can be
config-valid yet query wrong (e.g. a bad exposed default silently hiding rows); this shows what
visitors will actually see.
