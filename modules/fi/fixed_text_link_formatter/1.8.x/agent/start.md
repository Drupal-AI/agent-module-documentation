<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fixed Text Link Formatter — agent index

Two field formatter plugins that render a Link or File field as a hyperlink with **fixed,
admin-set link text**. No settings form, no configure route (`configure: null`), no permissions,
no services, no Drush, no plugin types of its own. All state is per-field formatter settings in
`core.entity_view_display.*`.

| Formatter id | Label | Field type | Extends |
|---|---|---|---|
| `fixed_text_link` | "Link with fixed text" | `link` | core `LinkFormatter` |
| `fixed_text_file_url` | "Link with a fixed text" | `file` | `FileFormatterBase` |

- **Select the formatter on a field, its settings keys, where they're stored** →
  [configure/formatters.md](configure/formatters.md)

Key fact: settings live at `core.entity_view_display.<entity>.<bundle>.<view_mode>` →
`content.<field>.type: fixed_text_link` (or `fixed_text_file_url`) with
`settings.link_text` (required), `settings.link_class`, and — for `fixed_text_link` —
`settings.allow_override`; for `fixed_text_file_url` — `settings.open_in_new_window`.
