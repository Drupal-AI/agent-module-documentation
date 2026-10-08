# Sitemap — settings & blocks

Form: `Drupal\sitemap\Form\SitemapSettingsForm` at `/admin/config/search/sitemap`
(route `sitemap.settings`, permission `administer sitemap`).
Config object `sitemap.settings` (defaults):
```yaml
page_title: 'Sitemap'
path: 'sitemap'          # the sitemap page URL; a RouteSubscriber registers it
message:
  format: 'plain_text'
  value: ''             # optional intro text above the sitemap
plugins: []             # enabled Sitemap plugins + their per-plugin settings
include_css: true       # load sitemap.theme CSS library
```
Enabled `plugins` store each section's id, weight, and settings (e.g. per-vocabulary
RSS/depth options, per-menu options). Schema: `config/schema/sitemap.schema.yml`.
Changing enabled plugins/path clears the plugin cache (`_sitemap_clear_plugin_cache()`).

## Blocks
- **Sitemap** — `Drupal\sitemap\Plugin\Block\SitemapBlock` — renders the sitemap overview
  in a region.
- **Sitemap Syndicate** — `SitemapSyndicateBlock` — renders the site's RSS feed icon/link.

## Page
Controller `SitemapController::buildSitemap()` renders the page at the configured path;
title from `getTitle()`. JS: `sitemap.admin` library (admin form); CSS: `sitemap.theme`.
