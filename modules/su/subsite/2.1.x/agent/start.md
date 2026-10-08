<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sub Site (subsite) — agent index
**Book-outline-based microsites with per-subsite theme, branding, social links and navigation blocks.**

- **Version:** 2.1.x — core `^10 || ^11`
- **Depends on:** book, social_media_links
- **Routes:** `subsite.admin` `/admin/structure/subsite` (perm `administer subsite settings`); `subsite.settings` `/admin/structure/subsite/settings` (perm `administer site configuration`)
- **Permissions:** administer subsite configuration, maintain subsite, add content to books, access printer-friendly version
- **Services:** `subsite.manager`, `subsite.book.manager`, `plugin.manager.subsite`, `theme.negotiator.subsite`, `cache_context.route.subsite`
- **Plugins:** Subsite plugin type (theme, branding, book, social media); blocks for social/footer/nav
- **Security:** admin/editor tool; all routes permission-gated; no anonymous or mutating public endpoints.

See [configure/subsites.md](configure/subsites.md).
