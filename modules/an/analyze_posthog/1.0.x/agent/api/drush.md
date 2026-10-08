<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`Drupal\analyze_posthog\Drush\Commands\PostHogCommands` (extends `DrushCommands`, wired via its own
`create()` from the container). Requires Drush to be loaded — `drush/drush` `^12 || ^13` is a
*suggest*, not a hard dependency. Every command first checks `PostHogClient::isConfigured()` and
errors out with a hint if not. Output mirrors the web reports because it reuses `ReportBuilder`.

| Command | Aliases | Purpose |
|---|---|---|
| `analyze:posthog:status` | `analyze-ph-status` | Print host, project ID, key set/unset (shown as `Set (phx_...)`, never the value), date range, cache TTL, then `testConnection()`. |
| `analyze:posthog:query <url>` | `analyze-ph-query` | Entity-level report for a path (e.g. `/pricing`): KPI + dimension/conversion table. |
| `analyze:posthog:report` | `analyze-ph-report` | Sitewide report: KPI + dimension/conversion table, optional country filter. |
| `analyze:posthog:cache-clear` | `analyze-ph-cc` | `cacheTagsInvalidator->invalidateTags(['analyze_posthog'])`. |
| `analyze:posthog:goals` | `analyze-ph-goals` | Table of configured goals with live 30-day event counts. |

## `:query` and `:report` options

Both accept `--days` (7/14/28/90/180/365), `--dimension`
(`referrer|country|device|browser|conversion`; `:report` also `page`), `--status`
(`all|up|down|new|lost`), `--search` (substring on keys), `--limit` (rows, default 20).
`:report` also has `--country="United States"`. `--dimension=conversion` errors when no goals are
configured.

`:query` takes a `url` argument; `resolvePath()` strips a scheme/host from a full URL and ensures a
leading slash, so `/pricing`, `pricing`, and `https://site/pricing` all resolve to `/pricing`.

Examples:

```bash
drush analyze:posthog:status
drush analyze-ph-query /pricing --days=90 --dimension=country
drush analyze-ph-report --dimension=page --limit=50
drush analyze-ph-report --dimension=conversion --country="United States"
drush analyze-ph-goals
drush analyze-ph-cc
```
