# Configure sitemaps, bundles and variants

The status/overview screen at `/admin/config/search/simplesitemap`:
![Simple XML Sitemap status](../../../../../../../screenshots/simple_sitemap/4.2.x/status.png)

The settings screen (`/settings`):
![Simple XML Sitemap settings](../../../../../../../screenshots/simple_sitemap/4.2.x/settings.png)

Config UI at `/admin/config/search/simplesitemap` (route `entity.simple_sitemap.collection`).
Permission: `administer sitemap settings`.

## Screens
- **Sitemaps** (`entity.simple_sitemap.collection`) — the sitemap entities ("variants"), each
  of a **sitemap type**. Edit/delete a variant; the default is `default`.
- **Sitemap types** (`entity.simple_sitemap_type.collection`) — config entities pairing a
  sitemap generator with a set of URL generators (default: `default_hreflang`).
- **Entities** (`EntitiesForm`) — enable/disable entity types for indexing.
- **Bundle settings** (`EntityBundlesForm`) — per bundle: `index` on/off, `priority`,
  `changefreq`, per which sitemap variant.
- **Custom links** (`CustomLinksForm`) — add arbitrary paths to a sitemap.
- **Settings** (`SettingsForm`) — cron regeneration, max links per chunk, base URL, remove
  duplicates, XML defaults.

## Config entities (exportable)
- `simple_sitemap.settings` — global settings (chunk size, cron `cron_generate`, base URL…).
- `simple_sitemap.sitemap.<id>` — a sitemap variant (`type`, weight).
- `simple_sitemap.type.<id>` — a sitemap type (`sitemap_generator`, `url_generators`).
- Per-bundle inclusion is stored in key-value, set via the UI or the
  [generator API](../api/generator.md), not as standalone config files.

## Regeneration
Sitemaps are (re)built from a queue: on cron (if enabled in Settings) or on demand via
[drush](../drush/commands.md) / the **Settings** form's "Regenerate" button.
