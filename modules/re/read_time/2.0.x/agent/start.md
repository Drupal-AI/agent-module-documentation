<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read time (read_time) — agent index

Displays an estimated "reading time" on nodes. Configured per content type (node type)
via third-party settings on the node-type form; shown as a `read_time` pseudo-field you
place at Manage Display. Read time = word count of chosen text fields ÷ words-per-minute,
cached in a `read_time` DB table and recomputed on node insert/update.

- Requires the core `node` module (uses `Drupal\node\Entity\NodeType`); no `dependencies:`
  are declared in the info file. Optional support for `paragraph` reference fields.
- **No settings page** (`configure` is null). Settings live on each node type at
  `Structure › Content types › <type> › Edit › Read time` (the `additional_settings`
  group), stored as third-party settings.
- Defines no permissions, no drush commands, no plugin types, and ships no config schema.

Solution docs:
- **Enable / configure read time on a content type, place the pseudo-field** →
  [configure/read-time.md](configure/read-time.md)
- **Service + storage internals (recompute, cache table, delete)** →
  [api/manager.md](api/manager.md)

Key facts (real machine names):
- Service: `read_time.manager` → `Drupal\read_time\ReadTimeManager`.
- Third-party setting namespace `read_time` on `node_type` entities; keys:
  `read_time_enable` (bool), `read_time_fields` (array of field names),
  `read_time_wpm` (int, default `225`), `read_time_format`
  (`hour_short`|`hour_long`|`min_short`|`min_long`, default `hour_short`),
  `read_time_display` (string template with `:read_time` token, default `Read time: :read_time`).
- Pseudo-field / display component key: `read_time` (extra field on `node`, per bundle).
- DB table: `read_time` (`nid`, `read_time` varchar 255; primary key `nid`).
- Hooks: `hook_form_node_type_form_alter`, `hook_entity_extra_field_info`,
  `hook_ENTITY_TYPE_view` (`read_time_node_view`), `hook_node_insert`, `hook_node_update`,
  `hook_ENTITY_TYPE_predelete`, `hook_schema`, `hook_uninstall`.
- Helper functions: `read_time_calculate($entity)`, `read_time_defaults()`.
