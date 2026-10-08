<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The manipulate form, service and state (cron_last_run_manipulate)

## Install / enable

`drush en cron_last_run_manipulate -y`. Requires **Automated Cron** (`drupal:automated_cron`,
a core module) — the form shows a warning and blocks submission until it is enabled.

## Route, permission, menu

- Route `cron_last_run_manipulate.cron_last_run_manipulate`
  (`cron_last_run_manipulate.routing.yml`): path `/admin/manipulate/cron/last-run-time`,
  `_form` = `CronLastRunManipulateForm`, `_title` "Cron Last Run Manipulate",
  requirement `_permission: 'administer site configuration'` (a core permission — the module
  defines none of its own).
- Menu link `cron_last_run_manipulate.menu` under `system.admin_config_system`
  (*Configuration › System*), weight 10.

## Form — `src/Form/CronLastRunManipulateForm.php`

`CronLastRunManipulateForm extends FormBase`, id
`cron_last_run_manipulate_cron_last_run_manipulate`. DI via `create()`:
`module_handler`, `cron_last_run_manipulate.helper`, `state`, `date.formatter`.

Fields (`buildForm`):
- `time` — required `select`. Options come from `UtilityHelperService::getDefaultTimeOptions()`:
  intervals `60, 300, 600, …, 3600` seconds rendered as "<formatInterval> ago", plus
  `-1 => "Choose Custom time"`. Default = `getSelectedOption()`.
- `custom_time` — `number`, `#min` 1, `#max` = `getCronMaxIntervalTime()`. Shown/required only
  when `time == -1` (`#states`). Default = stored custom time when the last selection was `-1`.
- If `automated_cron` is not enabled, a `#markup` message tells the user to install it.

`validateForm()`:
- Sets an error on `time` if `automated_cron` is not enabled.
- Sets an error on `custom_time` if it exceeds `getCronMaxIntervalTime()`
  (`automated_cron.settings.interval`). Note the description also asks the value to be greater
  than the last cron run time and below the max cron interval.

`submitForm()`:
- `setSelectedOption($time)` persists the selected option.
- If `custom_time` is non-empty, `time` is replaced by it and the value is stored in
  `cron_last_run_manipulate.custom_time`.
- `manipulateLastCronRunTime($time)` rewrites `system.cron_last`.
- Status message reports the new "%time ago" via `dateFormatter->formatTimeDiffSince(...)`.

## Service — `src/Utility/UtilityHelperService.php`

Service id `cron_last_run_manipulate.helper`. Constructor args: `@state`, `@date.formatter`,
`@config.factory`, `@datetime.time`.

- `getDefaultTimeOptions()` — builds the select options described above.
- `getCronMaxIntervalTime()` — `configFactory->get('automated_cron.settings')->get('interval')`.
- `getLastCronRunTime()` — reads `system.cron_last` State.
- `manipulateLastCronRunTime($time)` — `state->set('system.cron_last', currentTime - $time)`.
  The effect: cron is treated as having last run `$time` seconds ago.
- `setSelectedOption($time)` / `getSelectedOption()` — read/write State key
  `cron_last_run_manipulate.time` (default `''`).

## State keys touched

- `system.cron_last` — the core last-cron-run timestamp (overwritten).
- `cron_last_run_manipulate.time` — last selected dropdown option.
- `cron_last_run_manipulate.custom_time` — last custom seconds value.

No config objects, no config schema, and no `config/install` files ship with the module; all
persistence is via the State (key-value) store.

## How to operate

1. Enable Automated Cron and this module.
2. Visit *Configuration › System › Cron Last Run Manipulate*
   (`/admin/manipulate/cron/last-run-time`).
3. Pick an interval (or *Choose Custom time* and enter seconds below the Automated Cron interval).
4. Submit. `system.cron_last` is moved back by that many seconds; when the elapsed time next
   exceeds `automated_cron.settings.interval`, Automated Cron runs on a page request.
