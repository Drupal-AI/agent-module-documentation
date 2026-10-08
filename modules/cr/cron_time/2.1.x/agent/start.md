<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Time (cron_time) — agent index

Adds **one admin-defined interval option** to core's cron settings form so automatic cron can run
on a custom number of seconds. Version **2.1.1**. Core `^8.8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. **No dependencies**, no entities, no routes, no permissions, no services, no Drush.

- **How the form alter works, the config object, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- A procedural module — everything lives in `cron_time.module`. No `src/`, no plugins, no
  `*.routing.yml`, no `*.services.yml`, no `*.permissions.yml`, no `*.install`.
- `cron_time_help()` — standard `hook_help()` for `help.page.cron_time`.
- `cron_time_form_alter()` — on `$form_id == 'system_cron_settings'` it:
  - reads `custom_cron_time` from config object **`cron_time.settings`**;
  - adds that value as a new option (label `Cron Time`) into
    `$form['cron']['interval']['#options']` — i.e. the **Run cron every** select;
  - adds a `custom_cron_time` textfield (id `edit-cron-time`) shown/required via `#states` only
    when the interval select equals the custom value;
  - appends `custom_cron_time_callback` to `$form['#submit']`.
- `custom_cron_time_callback()` — saves the textfield value back to `cron_time.settings`
  (`config.factory` → `getEditable()->set('custom_cron_time', …)->save()`) and shows a message.

## Config

- Object **`cron_time.settings`**, single integer key **`custom_cron_time`** (seconds).
- Schema: `config/schema/cron_time.schema.yml` (`type: integer`). Install default `60`
  (`config/install/cron_time.settings.yml`).
- No `configure` route of its own; edited on core's cron settings form at
  **`/admin/config/system/cron`** (permission `administer site configuration`).

## Notes

- It only widens the interval dropdown; the actual scheduling is core's Automated Cron. The module
  does **not** run cron, add a scheduler, or disable cron.
- The textfield has no numeric validation; core's config schema types the value as integer.
