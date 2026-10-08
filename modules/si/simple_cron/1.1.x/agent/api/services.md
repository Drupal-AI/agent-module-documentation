# Services & entity API

## Services (`simple_cron.services.yml`)

### `simple_cron.cron_job_manager` → `CronJobManager` (`CronJobManagerInterface`)

Derives and queries the job list. Args: `@entity_type.manager`, `@plugin.manager.simple_cron`.

| Method | Returns | Notes |
|---|---|---|
| `updateList(): void` | – | Rebuilds `simple_cron_job` entities from all `@SimpleCron` plugins × their `getTypeDefinitions()`; creates missing ones (crontab `*/15 * * * *`, enabled), deletes jobs no longer backed by a plugin/type. Call after toggling override settings or adding a plugin. |
| `getEnabledJob(string $id): ?CronJobInterface` | one job | Enabled job by id, or NULL. Used by the single-URL run. |
| `getEnabledDefaultRunJobs(): array` | jobs | Enabled, non-`single` jobs sorted by weight (`CronJob::sort`). Used by the default cron run. |

### `plugin.manager.simple_cron` → `SimpleCronPluginManager` (`SimpleCronPluginManagerInterface`)

`getPlugins(): SimpleCronPluginInterface[]` (all instances, weight-sorted) and
`getPlugin(string $id, array $configuration = []): ?SimpleCronPluginInterface` (one instance or NULL
on failure). See [plugins/simple_cron.md](../plugins/simple_cron.md).

### Core `cron` override

`Drupal\simple_cron\SimpleCronServiceProvider::alter()` re-points the core `cron` service to
`Drupal\simple_cron\SimpleCron` (extends `Drupal\Core\Cron`) and injects the cron job manager, request
stack and config factory via setter calls. So any code calling `\Drupal::service('cron')->run()` (core
cron, the `/cron/<key>` route, the per-job Run action) drives Simple Cron. A generated proxy exists at
`src/ProxyClass/SimpleCron.php`.

## `CronJob` entity API (`Drupal\simple_cron\Entity\CronJobInterface`)

Config entity `simple_cron_job`. Load via
`\Drupal::entityTypeManager()->getStorage('simple_cron_job')`.

| Method | Purpose |
|---|---|
| `run(int $request_time, bool $force = FALSE): bool` | Runs the job: checks `shouldRun()`, acquires lock `simple_cron:<id>`, calls the plugin's `process()`, times it, records `last_run`, resets `next_run`, releases the lock. Catches exceptions/throwables and logs them (returns FALSE). |
| `shouldRun(int $request_time, bool $force): bool` | `$force || (enabled && next_run <= request_time)`. |
| `getPlugin(): ?SimpleCronPluginInterface` | The backing plugin, with this entity set on it. |
| `getCrontab()/getType()/getProvider()/getProviderName()/isSingle()/getWeight()` | Field accessors. |
| `getLastRunTime(): ?DrupalDateTime` / `getNextRunTime(): DrupalDateTime` | Run timestamps (from State; next is derived from the crontab if unset). |
| `resetNextRunTime(?int $time = NULL): int` | Recompute next run from the crontab (via `CronExpression`). |
| `getSingleRunUrl(): Url` | Absolute `/cron/<system.cron_key>?job=<id>`. |
| `isLocked(): bool` / `unlock(): CronJobInterface` | Lock state / delete the `semaphore` row. |
| `label()` | Plugin-derived label (type-aware). |

Logging honors `system.cron` `logging`: when off, the entity uses a `NullLogger`.

## Hooks the module implements

- `hook_help` (`help.page.simple_cron` → README).
- `hook_modules_installed`, `hook_modules_uninstalled`, `hook_rebuild` — each calls
  `CronJobManager::updateList()` to keep the job list in sync.
- `hook_entity_operation_alter` — drops the `translate` operation on a `CronJob` when access is denied.
- `hook_requirements` — install-time block if `ultimate_cron` is present or
  `dragonmantank/cron-expression` is missing; runtime warning for jobs behind schedule (>10 min).

## Hooks you can implement

- `hook_simple_cron_info(array &$definitions)` — alter the discovered `@SimpleCron` plugin definitions.
