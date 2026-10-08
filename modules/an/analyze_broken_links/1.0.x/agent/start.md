<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze Broken Links (analyze_broken_links) — agent index

An **Analyze** add-on that extracts links from an entity's rendered content and verifies each
link's HTTP status server-side (HEAD, then GET fallback), reporting dead/redirected links per
page and site-wide. Package `Analyze`. **Depends on `analyze:analyze` (>=1.2.0)**; suggests
`drush/drush`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.3.

- **Settings form, config object + schema, defaults, routes & permissions** →
  [config/settings.md](config/settings.md)
- **The Analyze plugin (gauge, full report, cron, hooks)** → [plugins/checker.md](plugins/checker.md)
- **Services: link extraction, HTTP checking, storage/schema** → [api/services.md](api/services.md)
- **Drush commands (check / report / recheck)** → [drush/commands.md](drush/commands.md)

## What it actually is

- **One Analyze plugin**: `BrokenLinksChecker` (id **`analyze_broken_links_checker`**, label
  *"Broken Links"*), `src/Plugin/Analyze/BrokenLinksChecker.php`, extends
  `Drupal\analyze\AnalyzePluginBase` and implements `BatchableAnalyzerInterface`. It renders the
  gauge summary + full report table on the Analyze tab and is driven by Analyze's batch/UI. Its
  `access()` requires the **`access broken links reports`** permission (the module's only permission).
- **Three services** (`analyze_broken_links.services.yml`):
  - `analyze_broken_links.link_extractor` → `Service\LinkExtractorService` — renders the entity and
    DOM-parses URLs from `a/img/link/script/iframe/source/video/audio`.
  - `analyze_broken_links.link_checker` → `Service\LinkCheckerService` — Guzzle `Pool`/`request`
    HTTP checks (**TLS verify on**, bounded timeout, redirects capped at 10).
  - `analyze_broken_links.storage` → `Service\BrokenLinksStorageService` — reads/writes the two
    module tables, caching, statistics, and the site-wide report query.
- **Config**: object **`analyze_broken_links.settings`** (schema in `config/schema/`, install
  defaults in `config/install/`); settings form `Form\BrokenLinksSettingsForm` at
  **`/admin/config/analyze/broken-links`** (route `analyze_broken_links.settings`, permission
  **`administer analyze`**). Ships a Views report `broken_links_report`
  (`config/install/views.view.broken_links_report.yml`, route `view.broken_links_report.page_1`,
  access **`access site reports`**).
- **Drush**: `Drush\Commands\BrokenLinksCommands` — `analyze:broken-links:check|report|recheck`.
- **Hooks** (`.module`/`.install`): `hook_cron` (recheck stale + auto-scan new entities),
  `hook_entity_update`/`hook_entity_delete` (invalidate cached results),
  `hook_requirements` (status-report warning), `hook_views_pre_view`,
  `hook_schema` (2 tables: `analyze_broken_links_urls`, `analyze_broken_links_entity_urls`).

## Data model (from `.install`)

- **`analyze_broken_links_urls`** — one row per unique URL (keyed by `url_hash` = SHA256(url)):
  `status_code`, `redirect_url`, `response_time_ms`, `error_message`, `last_checked`,
  `check_count`, `is_internal`. Shared across entities so each URL is checked once.
- **`analyze_broken_links_entity_urls`** — maps `entity_type`/`entity_id`/`langcode` → `url_id`
  with `link_text`, `field_name` (the HTML tag), and a `content_hash` used to detect stale caches.

## Provides / does NOT provide

- Provides: 1 permission, 1 config object + schema, 3 services, 1 Analyze plugin instance, 3 Drush
  commands, 2 DB tables, 1 default View.
- Does **not** define any new plugin *type*, entity type, field type/formatter/widget, or library.
