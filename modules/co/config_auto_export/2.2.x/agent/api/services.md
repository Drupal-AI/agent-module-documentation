<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, event flow and API

## Services (`config_auto_export.services.yml`)

| Service id | Class | Notes |
|---|---|---|
| `config_auto_export.service` | `Drupal\config_auto_export\Service` | The main service: pause/resume, `triggerExport`, `checkDueDate`, plus `reloadConfig`/`createConfig` helpers. |
| `config_auto_export.config_subscriber` | `Drupal\config_auto_export\ConfigSubscriber` | Tags: `event_subscriber`, `needs_destruction`. Watches config saves/deletes and schedules the webhook. |
| `config_auto_export.storage` | `Drupal\Core\Config\FileStorage` (factory `FileStorageFactory::getSync`) | `FileStorage` rooted at the configured `directory`; where exported config is written. |

## `Service` public API

Get it with `\Drupal::service('config_auto_export.service')`.

- `triggerExport(bool $force = FALSE): bool` — the export/webhook trigger. Returns `FALSE` (no-op)
  when paused (unless `$force`), when `enabled` is off, when `webhook` is empty, or when
  `webhook_autorun_enabled` is off (unless `$force`). Otherwise builds `form_params` from
  `webhook_params` (with placeholder substitution) + `headers`, and `POST`s via
  `ClientFactory::fromOptions(['base_uri' => $webhook])`. On success deletes the due timestamp and
  returns `TRUE`. Guzzle/JSON errors are logged `critical` and return `FALSE`.
- `checkDueDate(): void` — called by `hook_cron`. If the due timestamp exists and is `<= now`, calls
  `triggerExport()`.
- `pause()` / `resume()` / `isPaused(): bool` — toggle State `config_auto_export.paused`. A paused
  module still *writes* config to disk on save; only the automatic webhook is suppressed
  (`ConfigSubscriber::destruct()` then schedules a due-now timestamp instead of firing).
- `reloadConfig(string $module, string $section, array $configIds): void` — rewrites named configs
  from a module's `config/<section>/<id>.yml` (section allow-list: `install`, `optional`,
  `overwrite`), preserving the existing `uuid`. Logs an `alert` and skips on a missing module,
  disallowed section, or missing file. Not wired to any route or Drush command.
- `createConfig(string $configId, array $data): void` — imports a single config item through a
  `ConfigImporter` (validate + stepwise sync). Defined for external callers; not invoked inside the
  module.

State keys (constants on `Service`): `config_auto_export.due_next.timestamp`
(`STATE_KEY_DUE_TIMESTAMP`), `config_auto_export.paused` (`STATE_KEY_PAUSED`).

## Subscriber event flow (`ConfigSubscriber`)

Subscribed events (`getSubscribedEvents`, ConfigSubscriber.php:327):

| Event | Method | Priority |
|---|---|---|
| `ConfigEvents::SAVE` | `onConfigSave` | 0 |
| `ConfigEvents::DELETE` | `onConfigSave` | 0 |
| `ConfigEvents::IMPORT_VALIDATE` | `onConfigImportValidate` (sets `active = FALSE`) | 1024 |
| `LanguageConfigOverrideEvents::SAVE_OVERRIDE` | `onConfigTranslationSave` (only if `language` present) | 0 |

`onConfigSave` writes the changed config into `config_auto_export.storage` (or a
`config_split.<id>` collection), honouring `config_ignore` and `config_split` — see
[../configure/settings.md](../configure/settings.md). `destruct()` (from `needs_destruction`) then
decides how the webhook fires:

- `delay > 0` → store `now + delay` as the due timestamp (respecting `delay_from_first`); cron fires
  it later.
- `delay == 0` → call `triggerExport()` immediately; if that returns `FALSE` (e.g. paused) store a
  due-now timestamp so a later cron/trigger still runs it.

## `FileStorageFactory` (static helpers)

- `getDirectory(): string` — the configured `directory` (fallback `temporary://cae`).
- `getSync(): FileStorage` — service factory for `config_auto_export.storage`.
- `removeSync(): void` — recursively deletes the directory (used by `hook_uninstall` and when the
  `directory` setting changes).

## Hooks

- `hook_cron` (`config_auto_export.module`) → `Service::checkDueDate()`.
- `hook_uninstall` (`config_auto_export.install`) → `FileStorageFactory::removeSync()`.
- `config_auto_export_update_8001` → sets `webhook_autorun_enabled = 1`.

No custom hooks or events are exposed for other modules to implement.
