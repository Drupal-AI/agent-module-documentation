<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Robots DTAP (robots_dtap) — agent index

**Injects noindex,nofollow on every page unless the host is a configured production domain.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Configure:** `/admin/config/system/robots_dtap/settings` (perm `access administration pages`)

**Surface:** one settings form (`SettingsForm`) storing `production_domain` (newline list); `hook_page_attachments()` adds the robots meta tag when `getHttpHost()` is not in the list. No permissions.yml, services.

**Security:** low surface. Admin form gated by `access administration pages` (a broad but admin-level permission). Purely additive meta tag; does not write robots.txt or expose data.
