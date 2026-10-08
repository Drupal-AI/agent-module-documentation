<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Filter (`date_filter`) — agent index

Plug-and-play Views module. **No settings form, no `configure` route, no permissions, no
Drush, no new plugin IDs, no config entities of its own.** It only implements
`hook_views_plugins_filter_alter()` (in `date_filter.module`) and swaps the `class` of the two
existing core Views filter plugins:

| Views filter plugin id | normally | with `date_filter` |
|---|---|---|
| `date` (timestamp columns: `created`, `changed`, `login`, …) | `Drupal\views\Plugin\views\filter\Date` | `Drupal\date_filter\Plugin\views\filter\DateTimestamp` |
| `datetime` (Date/time field columns) | `Drupal\datetime\Plugin\views\filter\Date` | `Drupal\date_filter\Plugin\views\filter\DateTime` |

Both extend `Drupal\date_filter\Plugin\views\filter\DateBase` (a `NumericFilter`).

- **Set up / read a date filter in views config (the `type` option, exposed pickers, operators)** →
  [configure/views-date-filter.md](configure/views-date-filter.md)
- **How the class swap works, the last-hook-wins conflict, subclassing `DateBase`** →
  [extend/plugin-swap.md](extend/plugin-swap.md)
- **Query semantics: whole-day padding, `=` → `between`, timezone & storage formats** →
  [api/date-semantics.md](api/date-semantics.md)

Key facts:

- The one persistent trace of the module is a **top-level `type` key** on a Views filter:
  `views.view.<id>:display.<d>.display_options.filters.<f>.type` = `date` | `datetime`.
  Core instead uses **`value.type`** = `date` | `offset` — different key, different meaning.
- `type: datetime` adds an `<input type="time" step="1">` next to the date input on exposed
  filters; `type: date` renders only `<input type="date">`.
- On a date-only Date/time field the "Filter type" radios are disabled and forced to `date`.
- Config schema shipped: `config/schema/date_filter.views.schema.yml` declares
  `views.filter.datetime_proper` / `views.filter_value.datetime_proper` — **dead code**, the
  module never registers a `datetime_proper` plugin. The `type` key validates against core's
  own `views.filter.date` schema (which already has a `type: string` mapping).
