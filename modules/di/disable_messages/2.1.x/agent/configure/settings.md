<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_messages — configure

All settings live in one config object: **`disable_messages.settings`**. UI is the settings
form at `/admin/config/development/disable-messages` (route `disable_messages.settings_form`,
permission `administer disable messages`, menu parent `system.admin_config_development`).

## Config keys (`disable_messages.settings`)

| Key | Type | Meaning |
|---|---|---|
| `disable_messages_enable` | bool/string | Master switch. Falsy = no filtering at all (all messages shown). |
| `disable_messages_ignore_patterns` | string | The raw textarea: messages to hide, one regex per line (what the admin types). |
| `disable_messages_ignore_regex` | sequence | **Compiled** patterns actually used at runtime: each line becomes `/^PATTERN$/` (+`i`). Written by the form on save — see [api/filtering.md](../api/filtering.md). |
| `disable_messages_ignore_case` | bool/string | Adds the `i` flag when compiling patterns (so `article` matches `Article`). |
| `disable_messages_strip_html_tags` | bool/string | `strip_tags()` the message before matching. |
| `disable_messages_filter_by_page` | int | Page filtering mode: `0` all pages, `1` all except listed, `2` only listed. |
| `disable_messages_page_filter_paths` | string | Drupal paths (one per line, `*` wildcard, `<front>`) used by mode 1/2. |
| `disable_messages_exclude_users` | string | Comma-separated user IDs exempt from all filtering (e.g. `0,1`). |
| `disable_messages_enable_permissions` | bool/string | If on, hide whole message *types* from roles lacking `view status/warning/error messages`. |
| `disable_messages_enable_debug` | bool/string | Emit a debug dump (filtered messages + why) in a div at page bottom. |
| `disable_messages_debug_visible_div` | bool/string | Show that debug div visibly instead of `display:none`. |
| `disable_messages_ignore_exclude` | bool/string | Debug aid: ignore the "Exclude from message filtering" permission so admins get filtered too. |

Install defaults set `disable_messages_enable`, `disable_messages_strip_html_tags`, and
`disable_messages_ignore_case` on; patterns empty; filtering on all pages; permission
checking off.

## Read / write with drush

```bash
drush config:get disable_messages.settings
# functional filtering requires BOTH keys — see api/filtering.md for compiling patterns
drush config:set disable_messages.settings disable_messages_enable 1 -y
```

## Permissions (`disable_messages.permissions.yml`)

- `administer disable messages` — access the settings form.
- `view status messages`, `view warning messages`, `view error messages` — when
  `disable_messages_enable_permissions` is on, a role without a given one has that message
  *type* removed. (Install grants all three to every existing role.)
- `exclude from message filtering` — users with it bypass all filtering (admins get this by
  default); the `disable_messages_ignore_exclude` debug flag overrides it.
