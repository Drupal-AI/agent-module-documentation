<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Updater (entity_usage_updater) — agent index
**Bulk-repoint or remove entity references that Entity Usage tracks.**

- **Version:** 1.0.x (1.0.3 release)
- **Core:** ^10.2 || ^11 (PHP >= 7.4)
- **Depends:** entity_usage:entity_usage (8.x-2.x)
- **Routes:** `/admin/content/update-references` (update), `/admin/config/content/link-remover` (remove), `/admin/config/content/entity-usage-updater` (settings)
- **Permissions:** `update referenced entities` (restrict access: true) for both mutating forms; `administer site configuration` for settings
- **Plugin type:** `EntityUsageUpdater` (EntityReference, HtmlLink, Link, LinkIt)

**Security:** the two content-mutating forms are gated by the sensitive, `restrict access: true` permission `update referenced entities`; settings require `administer site configuration`. No anonymous or unauthenticated surface. Edits rewrite arbitrary content — treat the permission as admin-only and back up first.

See [configure/usage.md](configure/usage.md).
