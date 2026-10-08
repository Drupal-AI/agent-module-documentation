# Configure XML Sitemap Engines

Form `XmlSitemapEnginesSettingsForm` at `/admin/config/search/xmlsitemap/engines`
(route `xmlsitemap_engines.settings`, permission `administer xmlsitemap`).
Config object: `xmlsitemap_engines.settings`.

Keys (`config/install/xmlsitemap_engines.settings.yml`):
- `engines` — selected search engines to notify (ids come from
  `hook_xmlsitemap_engine_info()`; see [../hooks/hooks.md](../hooks/hooks.md)).
- `custom_urls` — additional sitemap URLs to submit (newline/space separated).
- `minimum_lifetime` — minimum seconds between submissions (default `86400`, i.e. once/day)
  to avoid pinging engines too often.

Submission is triggered automatically after the sitemap is regenerated (on cron), subject to
`minimum_lifetime`.
