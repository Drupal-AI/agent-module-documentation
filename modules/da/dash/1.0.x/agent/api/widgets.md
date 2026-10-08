<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON widget endpoints

`GET /admin/dashboard/data/{widget}` (permission `access modern dashboard`) →
`DashboardDataController::widget()` `match()`-dispatches to a method that returns a
`CacheableJsonResponse`. `DashboardData` (service id `dash.dashboard_data`) is a thin facade over
six data services. Unknown `{widget}` → 404. All counts come from `accessCheck(TRUE)` entity
queries or aggregate SQL — payloads carry **counts and flags only, no record content**.

## Widget map

| `{widget}` | Method / service | Cache tags · max-age |
|---|---|---|
| `content` | `ContentDataService::content` | `node_list` · 60s |
| `content_details` | `ContentDataService::contentDetails` | `node_list`, `node_type_list` · 120s |
| `additional_content` | `ContentDataService::additionalContent` | `taxonomy_term_list`, `block_content_list`, `file_list`, `config:core.extension` (+`media_list` if Media on) · 120s |
| `users` | `UsersDataService::users` | `config:core.extension` · 30s |
| `users_roles` | `UsersDataService::usersRoles` | `user_list`, `config:user.role_list` · 120s |
| `status` | `StatusDataService::status` | `config:core.extension` · 60s |
| `modules` | `ModulesDataService::modules` | `config:core.extension` · 300s |
| `modules_details` | `ModulesDataService::modulesDetails` | `config:core.extension` · 300s |
| `health` | `HealthDataService::health` | `config:core.extension`, `config:system.performance` · 300s |
| `health_details` | `HealthDataService::healthDetails` | same · 300s |
| `entities` | `EntitiesDataService::entitiesOverview` | `entity_types`, `config:core.extension`, `<type>_list` per row · 300s |

All add cache context `user.permissions`.

## Content (`ContentDataService`)

- `content` → `{ total, published, unpublished }` from an aggregate `GROUP BY status` on
  `node_field_data` (returns zeros if the table is absent).
- `content_details` → `{ totals, types[], audits }`. `types` is per-content-type
  `{ type, label, total, published, unpublished }` (labels from `node_type` storage; counts from a
  `GROUP BY type,status` query), sorted by total desc. `audits`: `unpublishedOlderThanDays` (>30d,
  unpublished, `default_langcode=1`), `withoutImages` (nodes with no value in any `node__<image
  field>` table — `NULL` if the site has no node image field storage), `missingMetaTags`
  (`NULL` unless Metatag enabled), `withoutTranslation` (`NULL`/`available:false` unless
  multilingual), `recentlyEditedUnpublished` (unpublished, changed within 7d).
- `additional_content` → `{ tags, blocks, media, files }` via `accessCheck(TRUE)` entity counts:
  `taxonomy_term` filtered `vid=tags`, `block_content`, `media` (**`NULL` if Media not enabled**),
  `file`.

## Users (`UsersDataService`)

- `users` → `{ total, online, windowSeconds:900 }`. `total` = active users (`status=1`);
  `online` = active users whose `access >= now-900s`.
- `users_roles` → `{ roles[], totalActive, audits }`. `roles` = `{ id, label, count }` per
  `user_role` (active users per role via `user__roles ⋈ users_field_data`, sorted by count desc);
  a user with N roles is counted in each. `audits`: `inactive90Days` (active, `0 < access <
  now-90d`), `multipleRoles` (active users with >1 role), `createdThisWeek` (created since Monday
  00:00 local), `withoutLastLogin` (active, `login=0`).

## Status (`StatusDataService`)

- `status` → `{ summary, system }`.
- `summary` = `{ checked, warnings, errors }` counted from `SystemManager::listRequirements()`
  (severity via `RequirementSeverity` enum with legacy `REQUIREMENT_*` fallbacks). Cached at
  `dash:status:summary` for 300s.
- `system` = `{ drupalVersion, webServer, phpVersion, phpMemoryLimit, databaseType,
  databaseVersion, cronLastRun }`. Cached at `dash:status:system` for 3600s **except**
  `cronLastRun`, which is always read fresh from state (`system.cron_last`). `webServer` is the
  first token of `SERVER_SOFTWARE`.

## Modules (`ModulesDataService`)

- `modules` → `{ available, enabled }` (counts from `ModuleExtensionList::getList()` and
  `ModuleHandler::getModuleList()`).
- `modules_details` → `{ summary, audits }`. `audits`:
  - `contribUpdatesAvailable` — projects at `UPDATE_NOT_CURRENT` (**only if the `update` module is
    enabled**; it lazily `include_once`s core's `update.fetch.inc`/`update.compare.inc` and calls
    `update_get_available(TRUE)` + `update_calculate_project_data()`), each `{ id, label,
    version }`.
  - `devModulesEnabled` — enabled modules from `ModuleCatalog::devModules()` (devel, webprofiler,
    stage_file_proxy, reroute_email, config_devel, config_inspector, views_ui, dblog).
  - `composerButDisabled` — `drupal/*` requires in the project-root `composer.json`
    (`DRUPAL_ROOT/../composer.json`, read-only via `file_get_contents`) that are available but not
    enabled; `available:false` if no composer.json.

## Health (`HealthDataService`)

- `health` → `{ seo, performance, accessibility, security }`, each a
  `scoreFromHealthChecks()` result `{ score(0–100), ok, total }`.
- `health_details` → `{ categories: { <cat>: { summary, checks[] } } }` where each check is
  `{ label, passed(bool), details, href }`.
- Checks are pure module-presence / config / filesystem probes (no external calls):
  - **SEO:** metatag, pathauto, sitemap (`simple_sitemap`|`xmlsitemap`), `robots.txt` not blocking
    `*` (regex parse of `DRUPAL_ROOT/robots.txt`), `llms.txt` present, schema_metatag.
  - **Performance:** page `cache.page.max_age>0`, Devel disabled, big_pipe, CSS+JS
    `preprocess`, cron ran within 6h (`system.cron_last`), queue backlog ≤500 (`queue` table),
    24h error+critical log rate ≤5 (`watchdog`, if dblog), redis|memcache, advagg.
  - **Accessibility:** editoria11y, ckeditor_a11ychecker, image-media alt-text coverage
    (`media__field_media_image` join, if Media), accessible admin theme (claro|gin).
  - **Security:** seckit, honeypot, captcha|recaptcha, password_policy, private files path set
    (`system.file:path.private`), no risky contrib enabled
    (`ModuleCatalog::riskyContribModules()` = devel, stage_file_proxy, reroute_email,
    config_devel), automated_cron.

## Entities (`EntitiesDataService`)

- `entities` → `{ entities: [{ id, label, kind, count, manageUrl }] }` over every entity-type
  definition. `kind` = `config`|`content`; `count` via `accessCheck(TRUE)` query (types whose
  query throws are skipped); `manageUrl` = the type's `collection` route URL when it has one.
  Sorted content-first then by label.
