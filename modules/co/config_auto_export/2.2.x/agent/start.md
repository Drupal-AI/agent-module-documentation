<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Auto Export (config_auto_export) — agent index

Detects configuration changes and **exports them automatically** to a configurable directory, then
optionally fires an outbound **webhook** so a CI pipeline can react (commit the files, open a merge
request, notify a channel). The mechanism is an event subscriber (`config_auto_export.config_subscriber`)
on `ConfigEvents::SAVE`/`DELETE` that writes each changed config into a `FileStorage` rooted at the
configured `directory` (default `temporary://cae`), skipping anything matched by `config_ignore` and
routing split configs into `config_split.<id>` collections. A `needs_destruction` `destruct()` then
either POSTs the webhook immediately (`delay = 0`) or stores a due timestamp that `hook_cron` fires
later. The webhook is a `ClientFactory` POST to `base_uri = <webhook>` with YAML-defined params
(placeholder-substituted) and headers.

Two entry points beyond the automatic path: the **settings form**
(`/admin/config/development/config_auto_export`, `administer site configuration`) and a **manual
trigger** confirm-form (`/admin/config/development/config_auto_export/trigger`,
`trigger config_auto_export` — `restrict access: true`) that forces the webhook. Five `cae:*` Drush
commands cover trigger/status/pause/resume/re-import.

- Depends on: nothing (no `dependencies:` in info.yml). Soft integrations, only when present:
  `config_split` (route configs to split folders) and `config_ignore` (skip ignored configs);
  `language` (export config-override translations).
- Core: `^10.3 || ^11`. PHP `>=8.1`. Package: `Configuration`. Version **2.2.2**.
- Settings page / `configure`: `config_auto_export.settings`. Permissions: `trigger config_auto_export`.
- Provides Drush commands (5). **No** config schema, **no** plugin types, no submodules, no libraries.

## What you'd do → where

- **Configure the export directory, webhook URL, params/headers, delay** →
  [configure/settings.md](configure/settings.md)
- **Understand what gets written on save/delete, config_split / config_ignore handling** →
  [configure/settings.md](configure/settings.md)
- **Call `triggerExport()`/pause/resume from code, the services, the subscriber event flow, State keys** →
  [api/services.md](api/services.md)
- **Run/pause/re-import from the CLI** → [drush/commands.md](drush/commands.md)

## Key facts (real machine names)

- Routes: `config_auto_export.settings` (`/admin/config/development/config_auto_export`,
  `administer site configuration`); `config_auto_export.trigger`
  (`/admin/config/development/config_auto_export/trigger`, `trigger config_auto_export`).
- Forms: `Form\Settings` (`config_auto_export_settings`, `ConfigFormBase`);
  `Form\Trigger` (`config_auto_export_trigger`, `ConfirmFormBase` → `triggerExport(TRUE)`).
- Services: `config_auto_export.service` (`Service`), `config_auto_export.config_subscriber`
  (`ConfigSubscriber`, `event_subscriber` + `needs_destruction`), `config_auto_export.storage`
  (`FileStorage` via `FileStorageFactory::getSync`).
- Permission: `trigger config_auto_export` (`restrict access: true`).
- Config object `config_auto_export.settings` keys: `enabled`, `directory`, `webhook`,
  `webhook_params`, `webhook_headers`, `webhook_autorun_enabled`, `delay`, `delay_from_first`.
- State keys: `config_auto_export.due_next.timestamp`, `config_auto_export.paused`.
- Drush: `cae:trigger`, `cae:status`, `cae:pause`, `cae:resume`, `cae:re-import`.
- Hooks: `hook_cron` → `Service::checkDueDate()`; `hook_uninstall` → `FileStorageFactory::removeSync()`;
  `config_auto_export_update_8001` (default `webhook_autorun_enabled = 1`).
- Subscribed events: `ConfigEvents::SAVE`/`DELETE` (`onConfigSave`), `ConfigEvents::IMPORT_VALIDATE`
  (`onConfigImportValidate`), `LanguageConfigOverrideEvents::SAVE_OVERRIDE` (`onConfigTranslationSave`).

**Operational note (not a security control):** exported configuration is not designed to be secret,
but real sites carry internal paths, endpoints and email addresses in it — keep the export
`directory` out of any web-accessible location, and keep true secrets in a Key entity or environment
variable rather than in config.
