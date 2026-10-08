<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `preview_link.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `generate preview links` | Creating/resetting a preview link for a piece of content (the **Preview Link** tab and generate form). | Give to editorial roles. |
| `administer preview link settings` | The settings form (`/admin/config/content/preview_link`) — which entity types are enabled, expiry, message behavior. | `restrict access: TRUE` (administrative). |

Viewing a previewed entity itself does **not** require a permission: a valid `preview_token`
in the URL grants `view` access via `hook_entity_access()`, which is the whole point (anyone,
including anonymous users, can open a preview link).

Grant with drush:

```bash
drush role:perm:add editor 'generate preview links'
drush role:perm:add administrator 'administer preview link settings'
```
