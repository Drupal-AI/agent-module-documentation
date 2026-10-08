<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare permission

From `cloudflare.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer cloudflare` | The settings wizard (`cloudflare.admin_settings_form`, `/admin/config/services/cloudflare`) and the cloudflarepurger settings form (`/admin/config/services/cloudflare/purger`). | `restrict access: TRUE` — it exposes/changes Cloudflare API credentials, so grant only to trusted administrators. |

This single permission also protects the submodule's purger settings form (both routes require
`administer cloudflare`). There are no per-content permissions.
