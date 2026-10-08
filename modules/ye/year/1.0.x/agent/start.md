# Year — agent index

A field type that stores only a year (unsigned int) with a configurable min/max range, plus two
widgets, a formatter, and a Feeds target. No permissions, no config route (`configure` null).
Depends on core `field`. Submodule `year_views` adds an exposed Views dropdown filter.

- **Field type, widgets, formatter, settings (min/max, relative dates), Feeds target** → [plugins/field.md](plugins/field.md)

Submodule (own docs):
- `year_views` → [../../modules/year_views/1.0.x/agent/start.md](../../modules/year_views/1.0.x/agent/start.md)

Key facts:
- Field type id `year`; default widget `year_default`, default formatter `year_default`.
- Field settings: `min` (int, default 1900) and `max` (string — a year OR a relative expr like `now`/`+5 years`, resolved via `strtotime`).
- Widgets: `year_default` (textfield), `year_select` (select list, `sort_order` asc|desc).
- Storage: one unsigned `int` column; two Range validation constraints (min, max).
