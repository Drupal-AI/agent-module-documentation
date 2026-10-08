<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `cloudflare_purge.permissions.yml`. Every state-changing route enforces one of these; the forms
also carry Drupal's standard CSRF token protection.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer cloudflare purge` | yes | Credentials form (`/credentials`), Auto-Purge Settings (`/settings`), Clear History (`/history/clear`). Trusted admins only. |
| `cloudflare purge` | no | Manual purge forms: by URL, tag, prefix, hostname (`/purge-url`, `/purge-tag`, `/purge-prefix`, `/purge-hostname`), and Queued Tags. |
| `cloudflare purge everything` | yes | The destructive "Purge Everything" confirm form (`/purge-everything`). |
| `view cloudflare purge history` | no | Purge History page (`/history`). |

Route-access details:
- The section landing page `/admin/config/cloudflare-purge` (`cloudflare_purge.admin_config`) requires
  ANY one of the four permissions (`administer cloudflare purge+cloudflare purge+cloudflare purge
  everything+view cloudflare purge history`), so a purge-only operator can reach the menu without
  admin rights; each child route still enforces its own permission.
- `Queued Tags` (`/queued-tags`) is reachable by `administer cloudflare purge` OR `cloudflare purge`.
- `Plans & Limits` (`/limits`) is reachable by admin, purge, or view-history.

Delegation pattern: give editors `cloudflare purge` (manual URL/tag/prefix/hostname purges) while
keeping `administer cloudflare purge` and `cloudflare purge everything` for administrators.
