<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Access Simple Sitemap — agent index

Bridges **Simple XML Sitemap** and **Domain Access**: each Domain gets its own sitemap
variant. Depends on `simple_sitemap` and `domain_access`. Config UI
`/admin/config/domain/domain_simple_sitemap/config` (route `domain_simple_sitemap.settings`,
permission `administer domains`). No plugins, no own permissions, no Drush.

- **Settings config object (two toggles) + the "Generate variants" button** →
  [configure/settings.md](configure/settings.md)
- **`DomainSitemapManager` service, the per-domain sitemap type/variant model, hooks** →
  [api/manager-and-hooks.md](api/manager-and-hooks.md)

Key facts:
- Config object **`domain_simple_sitemap.settings`**: `domain_simple_sitemap_filter` (bool) and
  `domain_simple_sitemap_replace_homepage` (bool), both default `0`.
- Per domain it creates a `simple_sitemap_type` and a `simple_sitemap` variant keyed by the
  **domain id**, using the `domain_entity` URL generator, with third-party setting
  `domain_simple_sitemap.sitemap_domain = <domain id>`.
- Variant lifecycle is automatic (`hook_domain_insert`/`hook_domain_delete`) or bulk via the
  settings-form button; the work is done by the `domain_simple_sitemap.manager` service.
