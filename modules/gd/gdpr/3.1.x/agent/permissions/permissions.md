<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (base `gdpr` module)

From `gdpr.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer gdpr settings` | Treated as GDPR admin: `UserController::accessCollectedData()` lets a holder view **any** user's `/user/{user}/gdpr` page. `restrict access: true`. |
| `view gdpr data summary` | Required to see the `/user/{user}/gdpr` "All your data" page at all; without it the page is forbidden. A non-admin holder can view **their own** page. Description: "Allows users to access their data without staff involvement." |

Notes:
- The Content links form (`/admin/config/gdpr/content-links`) and the admin section
  (`/admin/config/gdpr`) are gated by core `administer site configuration`, not by these
  permissions.
- The submodules define their own permissions (e.g. `gdpr_fields`: `view/edit gdpr fields`;
  `gdpr_consent`: `manage gdpr agreements`, `grant gdpr any/own consent`; `gdpr_tasks`:
  `create/view gdpr tasks`, `administer task entities`, etc.) — see each submodule's docs.
