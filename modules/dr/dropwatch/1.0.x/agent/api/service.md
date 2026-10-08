<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DropWatchService — data collection & payload

`src/Service/DropWatchService.php`, service id **`dropwatch.service`**. Dependencies (constructor):
`@dropwatch.client`, `@config.factory`, `@system.manager`, `@extension.list.module`,
`@module_handler`, `@database`. Uses `LoggerChannelTrait`, `StringTranslationTrait`.

## Entry point — `sendApiRequest(): void`

Calls `buildApiPayload()` then `dropWatchApiClient->sendUpdate($payload)` inside try/catch; on
`\Exception` it logs the message to the `dropwatch` logger channel. Invoked by `dropwatch_cron()`
(every cron run) and by the manual-sync form.

## `buildApiPayload(): array` — what data leaves the site

Reads config `dropwatch.settings`. Always includes `site_url` (`$config->get('site_url')`). Each
other section is gated by its own boolean config flag (the settings-form checkboxes):

- **`core`** (if `core`): Drupal core `version` from `getSystemInfo()`; when core has an update, adds
  `recommended_version`, `recommended_version_url`, `releases` from `getUpdateInfo()`.
- **`php`** (if `php`): `version`, `apcu_available`, `apcu_enabled`, `memory_limit`, `opcache`.
- **`web_server`** (if `web_server`): server `version`.
- **`database`** (if `database`): `db_system`, `db_version`, `db_updates` (pending DB updates).
- **`modules`** (if `contrib_modules`): per contrib project (only where machine name == project name)
  `name`, `machine_name`, `core_version_requirement`, `version`, `lifecycle`; plus
  `recommended_version` / `recommended_version_url` / `releases` when an update exists.
- **`php_logs`** (if `php_logs`): output of `getPhpLogs()` (see below).

Note: the `contrib_themes` config flag is saved by the form but is **not** read here (no theme data
is added to the payload in this version).

## Helper methods

- `getSystemInfo()` → `systemManager->listRequirements()` (core's Status Report data).
- `getContribModuleInfo()` → iterates `moduleHandler->getModuleList()`, keeps extensions whose
  `getExtensionInfo()` has a non-empty `project`; `ksort` by machine name.
- `getUpdateInfo()` → `update_get_available(TRUE)` + `update_calculate_project_data()`; skips
  `CURRENT` projects and those with no `recommended`; maps each to recommended version/url + releases
  via `ProjectRelease::createFromArray(...)`. (Depends on core `update` module.)
- `getPhpLogs()` → selects `type,message,variables,severity` from the **`watchdog`** table where
  `type = 'php'` (parameterized query builder), unserializes `variables`, and returns `type`,
  formatted `message`, `backtrace`, `severity` per row. `getMessageDetails()` builds the message with
  `Xss::filterAdmin()` + `$this->t()` and wraps any `@backtrace_string` in a `<pre>`
  `FormattableMarkup`. These values are placed in the outbound JSON, not rendered in the admin UI.
- `checkIfDblogIsEnabled(): bool` → true when the `dblog` module is in the module list; the settings
  form uses this to decide whether to show the PHP-logs checkbox.
