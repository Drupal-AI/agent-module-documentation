# Configure XML Sitemap

![XML Sitemap settings](../../../../../../../screenshots/xmlsitemap/2.0.x/settings.png)

Landing page lists the site's sitemaps (config entity `xmlsitemap`, `_entity_list` at
`/admin/config/search/xmlsitemap`, route `xmlsitemap.admin_search`). Permission:
`administer xmlsitemap`.

## Forms
- **Settings** — `XmlSitemapSettingsForm` (`/admin/config/search/xmlsitemap/settings`):
  global options in config `xmlsitemap.settings` — minimum links per chunk, max links,
  chunk file size, gzip on/off, cron batch limit, base URL, whether to prefetch aliases,
  clean/`disable_cron_regeneration`, logging verbosity.
- **Entity/bundle inclusion** — `XmlSitemapEntitiesSettingsForm` and
  `XmlSitemapLinkBundleSettingsForm`: per entity type + bundle, enable inclusion and set the
  default **priority** (0.0–1.0) and **change frequency**. Stored as
  `xmlsitemap.settings.<entity>.<bundle>` config.
- **Sitemap add/edit** — `XmlSitemapForm`: create a sitemap keyed by a **context** (e.g.
  language) — config entity `xmlsitemap.xmlsitemap.<id>`.
- **Rebuild** — `XmlSitemapRebuildForm` (`/admin/config/search/xmlsitemap/rebuild`):
  re-collect all links and regenerate. Run after changing inclusion.
- **Delete** — `XmlSitemapDeleteForm`.

## Generation
Happens on cron (indexing then generation), or on demand via the rebuild form / Drush
(see [../drush/commands.md](../drush/commands.md)). Per-item overrides of priority/frequency
require the `override xmlsitemap link settings` permission.
