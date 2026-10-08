<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `share_everywhere.permissions.yml` — one permission:

| Permission | Gates |
|---|---|
| `administer share everywhere` | Access to the settings form (route `share_everywhere.config_form`, `/admin/config/services/share_everywhere`) — enabling buttons, choosing content types/view modes, styling, etc. |

There is no per-view or front-end permission: whether buttons *appear* is controlled entirely by
the `share_everywhere.settings` config (enabled buttons, `content_types`, `view_modes`,
`restricted_pages`, `per_entity`/`enabled_entities`), not by a viewing permission. Placing the
**Share Everywhere Block** additionally respects normal core block visibility settings, and the
**Views field** respects the View's own access.
