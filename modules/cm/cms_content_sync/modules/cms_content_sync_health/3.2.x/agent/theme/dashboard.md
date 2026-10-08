# Sync Health dashboard (routes, controllers, theme)

Two controller-rendered pages, both gated by `access sync health`
(see [../permissions/permissions.md](../permissions/permissions.md)).

## Routes & controllers

| Route | Path | Controller |
|---|---|---|
| `entity.cms_content_sync.sync_health` | `/admin/content/sync-health` | `Controller\SyncHealth::overview()` |
| `entity.cms_content_sync.sync_health.version_mismatches` | `/admin/content/sync-health/pushing/version-mismatches` | `Controller\VersionMismatches::aggregate()` |

Local tasks (`cms_content_sync_health.links.task.yml`) add a **Sync Health** tab under
`admin/content` with sub-tabs **Overview** and **Entity Status** (the latter points at the
bundled View, see [../views/entity-status.md](../views/entity-status.md)).

### `SyncHealth::overview()`

Builds the `cms_content_sync_sync_health_overview` render array by gathering:

- **Sync Core status + logs** — for each registered core (`SyncCoreFactory::getAllSyncCores()`),
  `getReportingService()->getStatus()` plus error/warning logs. Logs are filtered to this site's
  connection ids (`filterSyncCoreLogMessages()`), and local watchdog messages pass through
  `Helper::obfuscateCredentials()` before display. Warns if the site is not yet registered.
- **Module version** — compares the installed `cms_content_sync` version to the newest on
  drupal.org via core's `UpdateFetcher` (only when the `update` module is enabled) and messages if
  an update is available.
- **Failure counts** — `countStatusEntitiesWithFlag()` over the `cms_content_sync_entity_status`
  table for `EntityStatus::FLAG_PUSH_FAILED` / `FLAG_PUSH_FAILED_SOFT` / `FLAG_PULL_FAILED` /
  `FLAG_PULL_FAILED_SOFT` (non-syndication rows excluded).
- **Local version differences** — `getLocalVersionDifferences()` lists syndication Flows whose
  stored entity-type version differs from the current one.
- **Local log** — recent `cms_content_sync` watchdog error/warning entries (when `dblog` is enabled).

### `VersionMismatches::aggregate()`

Iterates every entity type/bundle handled by a syndication Flow and queues a Batch API operation
(`VersionMismatches::batch`) that compares this site's entity-type definition to connected sites.
`batchFinished()` renders the differences (or "No differences found") and redirects back to the
overview. Run this when the overview reports version drift.

## Theme hooks (overridable templates)

`cms_content_sync_health.module` `hook_theme()` registers three hooks:

| Hook | Template | Variables |
|---|---|---|
| `cms_content_sync_sync_health_overview` | `cms_content_sync_sync_health_overview.html.twig` | `sync_cores`, `module_version`, `newest_version`, `push_failures_hard/soft`, `pull_failures_hard/soft`, `version_differences`, `site_log_disabled`, `error_log`, `warning_log` |
| `cms_content_sync_sync_health_push` | `cms_content_sync_sync_health_push.html.twig` | `push_failures_hard`, `push_failures_soft`, `pending` |
| `cms_content_sync_sync_health_pull` | `cms_content_sync_sync_health_pull.html.twig` | `pull_failures_hard`, `pull_failures_soft` |

Override any of these templates in your theme to restyle the dashboard.
