# XML Sitemap Drush commands

Defined in `src/Commands/XmlSitemapCommands.php` (registered via `drush.services.yml`).

| Command | Alias | Purpose |
|---|---|---|
| `xmlsitemap:regenerate` | `xmlsitemap-regenerate` | Regenerate the sitemap XML files from the existing link table. |
| `xmlsitemap:rebuild` | `xmlsitemap-rebuild` | Rebuild the link table (re-collect all links), then regenerate. |
| `xmlsitemap:index` | `xmlsitemap-index` | Process outstanding links waiting to be indexed (the cron step). |

Use `rebuild` after changing which entity types/bundles are included; `regenerate` for a
routine refresh; `index` to flush the pending-index queue without a full rebuild.
