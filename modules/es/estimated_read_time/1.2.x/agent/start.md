<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Estimated Read Time — agent index

Adds an **`estimated_read_time` field type** (columns `auto`, `minutes`, `seconds`) that
auto-computes an entity's reading time on save, with a widget for manual override and a
formatter that prints e.g. "5 min read". No admin/config route — configure it via the field,
its widget, and its formatter on an entity bundle. Requires the `mtownsend/read-time`
Composer library.

- **Add the field, set words-per-minute / view mode, configure widget & formatter** →
  [configure/field.md](configure/field.md)
- **How the estimate is computed (presave hook, estimator service, auto vs manual)** →
  [api/estimator.md](api/estimator.md)

Key facts:
- Field type `estimated_read_time`; default widget `estimated_read_time_default`; default
  formatter `estimated_read_time_text`.
- Field settings: `view_mode` (rendered to measure text), `words_per_minute` (default **230**).
- Formatter setting: `tokenized_string` (default `@minutes min read`; `@minutes`/`@seconds`).
- Widget settings: `sidebar` (bool). Widget also stores `auto` per item; `auto = 0` (manual)
  disables recomputation on save.
- Recompute happens in `hook_entity_presave` via
  `estimated_read_time.entity_read_time_estimator` (renders in the **default front-end
  theme**).
