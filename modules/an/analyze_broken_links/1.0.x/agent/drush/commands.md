<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`src/Drush/Commands/BrokenLinksCommands.php` (`final`, extends `DrushCommands`). Requires
`drush/drush` (suggested, `^12 || ^13`). `create()` injects `.storage`, `.link_checker`,
`.link_extractor`, `entity_type.manager`, `config.factory`.

## `analyze:broken-links:check <entity>` (alias `analyze-bl-check`)

Check the links in one entity. Argument `entity` = `type/id` (e.g. `node/123`).
Options: `--format=table|json` (default table), `--scope=both|internal|external` (default both),
`--status=all|broken|redirect|healthy` (default all).

Flow: load the entity → `linkExtractor->extractLinks()` → filter by `matchesScope()` and the `--scope`
flag → `storage->saveEntityUrl()` each → `linkChecker->checkUrls()` → categorize each result
(`categorizeStatus()`: 0 or a `broken_status_codes` value = broken; 3xx = redirect; else healthy) →
apply `--status` filter → print a summary line + table (URL / Status / Type / Link Text / Time) or a
JSON object `{entity, summary{total,healthy,broken,redirects,healthy_percent}, links[...]}`.

```
drush analyze:broken-links:check node/123
drush analyze:broken-links:check node/123 --status=broken
drush analyze:broken-links:check node/123 --scope=external --format=json
```

## `analyze:broken-links:report` (alias `analyze-bl-report`)

Site-wide report from already-stored results. Options: `--status` (default: broken + redirects),
`--scope=both|internal|external`, `--content-type=node:article,node:page`, `--limit=50`,
`--format=table|json`.

Flow: `storage->getStatistics()` for the summary; if `total_urls === 0` it tells you to run
`drush analyze:batch --analyzers=analyze_broken_links_checker`. Otherwise builds filters and calls
`storage->getUrlsWithEntities($filters, $limit)`; prints a summary + a table (Entity / URL / Status /
Type / Link Text / Last Checked) or the equivalent JSON.

```
drush analyze:broken-links:report
drush analyze:broken-links:report --status=broken
drush analyze:broken-links:report --scope=external --limit=100
drush analyze:broken-links:report --format=json
```

## `analyze:broken-links:recheck` (alias `analyze-bl-recheck`)

Recheck stale URLs (older than `recheck_ttl`). Options: `--limit=100`,
`--concurrency=<n>` (default from settings). Calls `linkChecker->recheckStaleUrls($limit,$concurrency)`
and reports how many were rechecked. This is the manual equivalent of the cron recheck step.

```
drush analyze:broken-links:recheck --limit=200
drush analyze:broken-links:recheck --concurrency=10
```

Note: to *populate* results in the first place, run Analyze's batch
(`drush analyze:batch --analyzers=analyze_broken_links_checker`), the `:check` command per entity, or
let cron auto-scan enabled published content.
