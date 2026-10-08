<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ReadRemaining permissions

One permission, defined in `readremaining.permissions.yml`:

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Administer ReadRemaining | `administer readremaining` | The settings form at `/admin/config/system/readremaining` (route `readremaining.read_remaining_settings_form`). | `restrict access: TRUE` — treat as a trusted-admin permission. |

The gauge display itself has no permission gate: once a content type is enabled in config,
the library loads for any visitor viewing a node of that type.

Grant via Drush: `drush role:perm:add <role> 'administer readremaining'`.
