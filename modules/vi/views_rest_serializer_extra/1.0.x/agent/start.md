<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Results Serializer Extra (views_rest_serializer_extra) — agent index

One Views **style plugin** for REST Export (`data`) displays. It subclasses core `rest`'s
`Serializer`, serializes the rows as usual, then wraps them in a metadata envelope
(`results` + `pager` + `filters` + `sorters` + `system`, and optional `facets`). Depends on
core `rest` and `serialization`. Core `^9 || ^10 || ^11`. No permissions, no config UI route,
no Drush, no config schema, no new plugin type — just this one style plugin.

Key facts:
- Selected as the **style** on a REST Export display (Format → "Serializer with pagination,
  facets, and extra metadata"), so nothing else about the view changes.
- **It changes the response shape.** Rows move under a `results` key inside an envelope — a
  **breaking change** for any consumer parsing the bare array. Version the endpoint or
  coordinate the switch.
- Every top-level key label is **renamable** in the style settings (`results` → `data`, etc.).
- **Facets** are included only if the contrib `facets_rest` module is installed *and* the
  display's "Show facets" box is ticked.
- A **total count implies a count query** — not free on a large or expensive view.
- Access control is unchanged: it defers to the REST Export display's own permission/auth and
  serializes rows through the standard serializer (field access respected as in core).

Docs:
- [plugins/serializer-style.md](plugins/serializer-style.md) — how to select it, every style
  option, the exact envelope shape, facets integration, and how to subclass it.
