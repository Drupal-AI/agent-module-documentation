<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO Urls (seo_urls) — agent index

**Maps a clean SEO URL to an existing canonical/parameterized URL (stored as `seo_url` entities) and exposes it via a `seo-url` token.**

- **Version:** 1.0.x
- **Core:** `^10 || ^11` · **PHP:** 8.1
- **Depends:** link, metatag
- **Configure:** `seo_url.settings` → `/admin/structure/seo_url` (perm `administer seo_url entities`, restricted).
- **Routes:** `/admin/seo_url/add` (`_entity_create_access` + custom access), `/admin/content/seo_url` (view any/own), `/admin/content/seo_url/delete` (delete-multiple access). Full CRUD permission set (any/own view/add/update/delete).
- **Services:** `seo_urls.path_processor` (inbound prio 200 / outbound prio 400); `seo_urls.manager` (`SeoUrlManager`); route subscriber. Token `[entity:seo-url]`.

**Security:** all routes permission-gated. URL resolution is driven only by admin/editor-created `seo_url` entities (`status=TRUE`, `internal:` link fields) — no request-controlled redirect target, so no open-redirect/path-injection. Outbound processor collapses leading `//` to prevent protocol-relative external URLs (`SeoUrlPathProcessor.php:100-102`); inbound returns a path only. See [configure/setup.md](configure/setup.md). No security findings.
