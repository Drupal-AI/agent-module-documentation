# Drush commands

Defined in `src/Drush/Commands/SimpleSitemapCommands.php` (requires `drush/drush >= 12.5.1`).

| Command | Aliases | Does |
|---|---|---|
| `simple-sitemap:generate` | `ssg`, `simple-sitemap-generate` | Regenerate all sitemaps, or continue an in-progress generation from the queue. |
| `simple-sitemap:rebuild-queue` | `ssr`, `simple-sitemap-rebuild-queue` | Truncate and re-populate the generation queue (does not generate). |

`rebuild-queue` accepts `--variants=default,news` to queue only specific sitemaps.

```
drush ssg                                  # regenerate everything
drush ssr --variants=default,news          # queue only these variants
drush ssr && drush ssg                      # full clean rebuild
```

Both delegate to the `simple_sitemap.generator` service (see [../api/generator.md](../api/generator.md)).
For unattended regeneration, enable cron generation in the Settings form instead.
