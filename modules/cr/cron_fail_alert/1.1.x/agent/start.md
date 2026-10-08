<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Fail Alert (cron_fail_alert) — agent index

Emails an administrator when Drupal cron has not run within a configurable tolerance. A single
event subscriber checks (throttled) on each HTTP response and sends an alert if
`now - system.cron_last` exceeds the tolerance. Core-only: `core_version_requirement: ^10.3 || ^11`,
package none, license GPL-2.0-or-later, version 1.1.1. No dependencies, no submodules, no entities,
no plugins, no Drush.

- **Config object, settings form, tokens, routes/permission, the subscriber mechanism** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service: `cron_fail_alert.event_subscriber` = `CronFailAlertSubscriber`
  (`src/EventSubscriber/CronFailAlertSubscriber.php`), tagged `event_subscriber`, listening on
  `KernelEvents::RESPONSE` (`onKernelResponse`). Constructor args: `config.factory`,
  `language_manager`, `logger.factory`, `plugin.manager.mail`, `state`, `request_stack`.
- One OO `hook_mail()`: `CronFailAlertHooks::mail()` (`src/Hook/CronFailAlertHooks.php`, `#[Hook('mail')]`),
  reached via the `#[LegacyHook]` shim `cron_fail_alert_mail()` in `cron_fail_alert.module`.
- One config form: `SettingsForm` (`ConfigFormBase`, `src/Form/SettingsForm.php`), form id
  `cron_fail_alert_settings`, editing config `cron_fail_alert.settings`.
- Config object `cron_fail_alert.settings` — keys `frequency` (int), `tolerance` (int),
  `to` (email), `subject` (string), `message` (text), `langcode`. Schema in
  `config/schema/cron_fail_alert.schema.yml`; install defaults in `config/install/`.
- Route `cron_fail_alert.settings_form` → `/admin/config/system/cron-fail-alert`
  (`cron_fail_alert.routing.yml`), permission `administer cron-fail-alert configuration`
  (`cron_fail_alert.permissions.yml`). Menu link under `system.cron_settings`; local tasks in
  `cron_fail_alert.links.task.yml`. `configure: cron_fail_alert.settings_form` in the info file.
- Post-update `cron_fail_alert_post_update_add_langcode()` backfills `langcode` into the config.

## Mechanism (from source)

- `onKernelResponse()`: reads state `cron_fail_alert.last_check_timestamp` (default 0); if
  `(time() - last) / 60 < frequency`, returns. Otherwise calls `checkCronStatus()` then writes the
  timestamp back (so the check is throttled to at most once per `frequency` minutes, cron-independent).
- `checkCronStatus()`: `minutesAgo = (time() - state('system.cron_last')) / 60`. If
  `minutesAgo < tolerance` → return FALSE. Else build recipient = config `to` (fallback
  `system.site:mail`), subject = `"@subject on Site: @site_name"`, body via `FormattableMarkup` on the
  configured `message` with `@minutes = floor(minutesAgo)` and `:site = request->getSchemeAndHttpHost()`,
  then `sendCronFailAlertEmail()` → `mailManager->mail('cron_fail_alert','cron_fail_alert_mail', …)`.
  Send result logged to the `cron_fail_alert` logger channel (notice on success, error on failure).
- `SettingsForm::validateForm()`: rejects an invalid `to` (via `email.validator`) and requires
  `tolerance > frequency`. Form fields use `#config_target`; `frequency` range 1–1440, `tolerance`
  range 1–10080.

See [config/settings.md](config/settings.md) for keys, defaults, tokens and a config export example.
