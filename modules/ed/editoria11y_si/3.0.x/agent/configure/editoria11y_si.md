<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Editoria11y si (SiteImprove)

## Step 1 — create the SiteImprove Key
Add a Key at `/admin/config/system/keys` using key type **`editoria11y_si_key`** ("Editoria11y SiteImprove"). It is a multivalue authentication key with fields:
- `username` (required) — SiteImprove API user email
- `api_key` (required)
- `site` (required) — SiteImprove site id
- `group` (optional) — SiteImprove group id to scope results

The module also ships a matching Key **input** plugin `editoria11y_si`. See SiteImprove's docs at `https://my2.siteimprove.com/Integrations/Api/ManageApiKeys`.

## Step 2 — settings form
Route `editoria11y_si.settings` → `/admin/config/content/editoria11y/si` (menu nested under Editoria11y settings). Access: permission **`administer site configuration`**. Config object: `editoria11y_si.settings`. Keys:

| Config key | Form field | Notes |
|---|---|---|
| `siteimprove_api` | Key select (filtered to `editoria11y_si_key`) | required |
| `domain` | textfield | site scheme+host; stripped from SiteImprove URLs so they match internal paths. Defaults to current host. |
| `editoria11y_si_broken_links_import_enabled` | select Enabled/Disabled | gates the broken-links import |
| `editoria11y_si_misspellings_import_enabled` | select | gates the misspellings import (default disabled per update 9004) |
| `editoria11y_si_reading_score_import_enabled` | select | gates the reading-score import |
| `editoria11y_si_reading_score_error_grade_level` | number | default `8`; pages below this grade level get flagged on the page `h1` |

The form has three "Update … manually" submit buttons (`::startImportOfBrokenLinks`, `::startImportOfMisspellings`, `::startImportOfReadingScores`). Each temporarily enables only its own check, runs `editoria11y_si_queue_cronjob()` synchronously, then restores prior config. Each shows the last import time from Drupal `state` (`editoria11y_si_<type>.import.last_update`).

There is **no `config/schema/`** in the module and no `configure:` line in info.yml, so `data.json.configure` is `null` even though a settings route exists.

## Step 3 — schedule the import
Run periodically (e.g. via cron/drush):
```
drush ev "editoria11y_si_queue_cronjob();"
```
This calls the importer for all three data types, then drains the `editoria11y_si_import_processor` queue. The queue worker also has a `cron` annotation (60s), so items also process on normal Drupal cron.

## Step 4 — export config
Installing the module increments `editoria11y.settings`'s `custom_tests` counter by 1 (so Editoria11y loads the custom JS tests). Export config after install.

## Reports
Three admin Views (installed from `config/install`), each gated by permission `view editoria11y checker`:
- `/admin/reports/editoria11y/si-broken-links`
- `/admin/reports/editoria11y/si-misspellings`
- `/admin/reports/editoria11y/si-reading-score`

## Clearing data
`drush entity:delete editoria11y_si` removes all stored issue entities.

## Dependency gotcha
`Editoria11ySiImportCronEventProcessor` injects `purge.processors`, `purge.invalidation.factory`, `purge.purgers` (Purge module) but `purge` is not declared in info.yml/composer.json. Install `drupal/purge` if the queue worker fails to instantiate.
