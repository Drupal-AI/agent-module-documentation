<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Analytics Cookieless (google_analytics_cookieless) — agent index
**Injects a UA (Universal Analytics) tracking snippet without the GA cookie, with path-visibility and IP-anonymisation options.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10
- **Configure:** `/admin/config/system/google-analytics-cookieless` (route `google_analytics_cookieless.admin_settings_form`)
- **Attach:** `hook_page_attachments` in `google_analytics_cookieless.module` (guards on `^UA-\d+-\d+$`, path visibility, logged-in-user opt).
- **Permission mismatch:** route requires `administer google analytics` (from the classic GA module); this module's `permissions.yml` instead defines `administer google analytics cookieless`.
- **Security:** admin config route, permission-gated; no anonymous or mutating endpoints. Because the route's permission is the classic-GA one, if that module is not installed the permission is undefined and the form is user-1-only. Account id is regex-validated before output.

See [configure/settings.md](configure/settings.md).