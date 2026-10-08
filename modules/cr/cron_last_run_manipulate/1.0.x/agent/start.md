<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Last Run Manipulate (cron_last_run_manipulate) — agent index

A developer/debug module that exposes one admin form to **overwrite the recorded last cron run
time** (`system.cron_last` State). Setting it back in time makes Drupal act as if cron last ran
that long ago, so — with the required **Automated Cron** module — automatic cron fires on the next
request once the interval elapses. Package `Development`. Core `^10 || ^11`, PHP 8.1.
License GPL-2.0-or-later. Version 1.0.0-alpha2 (dir `1.0.x`).

- **The form, the service, the routes/state keys, and how to operate it** →
  [config/form.md](config/form.md)

## What it actually is (from source)

- One form: `CronLastRunManipulateForm` (id `cron_last_run_manipulate_cron_last_run_manipulate`),
  `src/Form/CronLastRunManipulateForm.php`, a plain `FormBase`.
- One service: `cron_last_run_manipulate.helper` →
  `Drupal\cron_last_run_manipulate\Utility\UtilityHelperService`
  (args: `@state`, `@date.formatter`, `@config.factory`, `@datetime.time`).
- One route: `cron_last_run_manipulate.cron_last_run_manipulate` →
  path `/admin/manipulate/cron/last-run-time`, `_permission: 'administer site configuration'`.
- One menu link under *Configuration › System* (`cron_last_run_manipulate.links.menu.yml`).
- `hook_help()` in `.module`. Empty `.install`.
- **No** own permissions, **no** config schema/objects, **no** plugins, **no** Drush, **no**
  entities. Depends on `drupal:automated_cron`.

## Mechanism

- The form offers a select (`60…3600` seconds, 5-min steps) plus a `-1 = Choose Custom time`
  option that reveals a `custom_time` number field. On submit,
  `UtilityHelperService::manipulateLastCronRunTime($time)` sets
  `system.cron_last = time->getCurrentTime() - $time`.
- `getCronMaxIntervalTime()` reads `automated_cron.settings.interval`; the form validates the
  custom value against it and requires Automated Cron to be enabled.
- State keys written: `system.cron_last`, `cron_last_run_manipulate.time` (last selected option),
  `cron_last_run_manipulate.custom_time` (last custom seconds).
