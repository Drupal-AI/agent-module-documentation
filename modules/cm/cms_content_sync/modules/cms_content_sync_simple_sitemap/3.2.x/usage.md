<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A glue submodule that carries an entity's Simple Sitemap settings (inclusion, priority, changefreq) with it during Content Sync push/pull, so per-entity sitemap configuration is preserved across syndicated sites.

---

Simple Sitemap stores per-entity sitemap settings (whether an entity is indexed, its priority and change frequency) outside of ordinary fields, so Content Sync would not carry them by default. This submodule adds a single event subscriber, `SimpleSitemapSyncExtend`, that listens to three Content Sync events: `BeforeEntityTypeExport` (declaring a `simple_sitemap` object property on supported entity types/bundles), `BeforeEntityPush` (reading the entity's Simple Sitemap settings — preferring in-form values when the entity form was just submitted, otherwise the database — and attaching them to the payload) and `AfterEntityPull` (applying the received settings to the local entity). The added payload property is named `simple_sitemap` (`SimpleSitemapSyncExtend::PROPERTY_NAME`). It supports both Simple Sitemap v3 and v4 APIs, requires both `cms_content_sync` and the contrib `simple_sitemap` module, and has no configuration, permissions, Drush commands or plugins of its own. Programmatically-added sitemap settings are not supported out of the box.

---

- Keep a node's "include in sitemap" setting identical between staging and production.
- Carry per-entity sitemap priority values across syndicated sites.
- Preserve change-frequency (changefreq) settings when pushing content to subscriber sites.
- Avoid re-configuring Simple Sitemap settings on every site after content is synced.
- Ensure newly pulled content is (or isn't) indexed exactly as the source site intended.
- Syndicate SEO-relevant sitemap metadata alongside the content it describes.
- Extend the Content Sync payload for an entity type with a `simple_sitemap` property.
- Support both Simple Sitemap 3.x and 4.x during sync.
- Maintain consistent SEO indexing rules across a multi-site content hub.
- Prevent sitemap-setting drift between sites sharing a content pool.
- Keep landing pages' sitemap priority in sync when they move between environments.
- Reduce manual SEO setup when launching a new site from syndicated content.
- Apply the source site's sitemap inclusion decision automatically on pull.
- Serve as a reference for extending Content Sync via its push/pull events.
- Guarantee that excluded (noindex) content stays excluded after syndication.
- Add sitemap fidelity to any Content Sync Flow that includes sitemap-managed content.
- Support editorial teams that manage SEO settings centrally and syndicate outward.
