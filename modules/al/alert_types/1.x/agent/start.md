<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alert Types (alert_types) — agent index

**Define fieldable, prioritized alert bundles and display active alerts anywhere via an AJAX block + JSON endpoint.**

- **Version:** 1.x (dev-1.x checkout)
- **Core:** ^9.2 || ^10 || ^11
- **Routes:** `/alerts/json` (GET, `access content`) returns rendered markup of active published alerts; entity admin routes under `/admin/content/alerts` and `/admin/structure`.
- **Permissions:** `administer alert types`, `administer alert entities`, `add/edit/delete alert entities`, `view active alert entities`, `view inactive alert entities`, revision perms.
- **Entities:** `alert_type` (config bundle), `alert` (revisionable content); custom storage `AlertStorage`, access handler `AlertAccessControlHandler`.
- **Plugins:** `@AlertTypeBehavior` (Dismissable, Dismiss Timer) + JS plugin API.
- **Security:** `/alerts/json` is read-only; `loadActive()` uses `accessCheck(TRUE)` and `status=1`, so it exposes only published, access-permitted alerts (intended public banner display). Revision SQL uses bound placeholders.

See [plugins/behaviors.md](plugins/behaviors.md).
