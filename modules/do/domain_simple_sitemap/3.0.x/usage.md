<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Access Simple Sitemap ties Simple XML Sitemap to Domain Access, giving each Domain its own sitemap variant so multi-domain sites produce a correct per-domain `sitemap.xml`.

---

The module bridges `simple_sitemap` and `domain_access`. For every Domain it creates a
matching **Simple Sitemap Type** and **sitemap variant** (both with the domain's id), wired to
the `domain_entity` URL generator and tagged with the domain via a third-party setting
`domain_simple_sitemap.sitemap_domain`. This happens automatically on `hook_domain_insert`
(and is removed on `hook_domain_delete`) through the `DomainSitemapManager` service, and can be
run in bulk for existing domains via the **"Generate domain's sitemap variants"** button on the
settings form. It also swaps the `simple_sitemap` entity class (`hook_entity_type_build`) and
adds a "Select domain for this sitemap" field to the Simple Sitemap Type edit form. Its own
config object `domain_simple_sitemap.settings` has two booleans: `domain_simple_sitemap_filter`
(use node **source** instead of node **access** as the listing filter) and
`domain_simple_sitemap_replace_homepage` (rewrite a domain's front-page URL in the sitemap to
the domain base URL — needs `domain_config` or `domain_site_settings`). The settings page is at
`/admin/config/domain/domain_simple_sitemap/config` and requires the `administer domains`
permission. Once variants exist, editors enable indexing per content type against the domain
variant and regenerate sitemaps through Simple Sitemap as usual.

---

- Give each Domain in a Domain Access site its own XML sitemap variant automatically.
- Serve a correct per-domain `sitemap.xml` on a multi-domain / affiliate site.
- Bulk-create sitemap variants for all existing domains via the settings-form button.
- Auto-create a sitemap variant whenever a new domain is added (no manual step).
- Auto-remove a domain's sitemap variant when the domain is deleted.
- Filter each domain's sitemap by node **access** (default) for Domain Access visibility.
- Switch to filtering by node **source** instead (`domain_simple_sitemap_filter`).
- Replace a domain's front-page path in the sitemap with its clean base URL.
- Associate an existing Simple Sitemap Type with a specific domain via the edit form.
- Use the `domain_entity` URL generator so sitemap links use the right domain host.
- Keep SEO clean across many affiliate domains without hand-maintaining sitemaps.
- Regenerate all domain sitemaps through Simple Sitemap's "Rebuild queue & generate".
- Control which content types are indexed per domain variant in the Simple XML Sitemap settings.
- Store the domain⇄sitemap link as a third-party setting on the sitemap type.
- Integrate with `domain_config` for per-domain front-page URL handling.
- Integrate with `domain_site_settings` as an alternative front-page source.
- Manage the domain-sitemap filter mode from a single config page.
- Provide the `DomainSitemapManager` service to add/delete variants programmatically.
- Ensure each domain's sitemap is a distinct Simple Sitemap variant, not a shared one.
- Support search engines crawling each affiliate domain with its own URL set.
- Migrate a single-sitemap site to per-domain sitemaps after enabling Domain Access.
