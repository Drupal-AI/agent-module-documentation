<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Time — configuration & mechanism

Everything is in `cron_time.module` (procedural). No routes/services/plugins/permissions.

## Install / enable

- `composer require drupal/cron_time` then `drush en cron_time -y` (or enable at `/admin/modules`).
- No module dependencies beyond Drupal core.
- On install, `config/install/cron_time.settings.yml` seeds the config object
  `cron_time.settings` with `custom_cron_time: 60`.

## The config object

- **`cron_time.settings`** — one key:
  - `custom_cron_time` (integer, seconds). Schema `config/schema/cron_time.schema.yml`:
    ```yaml
    cron_time.settings:
      type: mapping
      label: 'Cron Time'
      mapping:
        custom_cron_time:
          type: integer
          label: Cron Time
    ```
- Export/import like any config. Drush read/write:
  `drush config:get cron_time.settings` / `drush config:set cron_time.settings custom_cron_time 90`.

## How the UI works (`cron_time_form_alter`)

The module has no admin page of its own. It **alters core's cron settings form**
(`$form_id == 'system_cron_settings'`, at `/admin/config/system/cron`, permission
`administer site configuration`):

1. Reads `custom_cron_time` from `cron_time.settings`.
2. Adds it as an extra option into `$form['cron']['interval']['#options']` keyed by that seconds
   value, with the label `Cron Time` — so it appears in the **Run cron every** select alongside
   core's presets.
3. Adds a `custom_cron_time` textfield (title "Cron Time", `#id` `edit-cron-time`,
   `#default_value` the current config value). `#states` make it **visible/required only** when
   the interval select's value equals the custom value.
4. Appends `custom_cron_time_callback` to `$form['#submit']`.

## Submit handler (`custom_cron_time_callback`)

```php
\Drupal::service('config.factory')
  ->getEditable('cron_time.settings')
  ->set('custom_cron_time', $form_state->getValue('custom_cron_time'))
  ->save();
\Drupal::messenger()->addMessage(t('Update cron time.'));
```

It saves whatever was typed into the Cron Time field back to `cron_time.settings`. Note the
interval the form itself stores (core's `system.cron` / Automated Cron `interval`) is separate:
to make automatic cron actually use the custom cadence, select the "Cron Time" option in the
**Run cron every** dropdown and set the seconds in the Cron Time field, then save.

## Operating notes

- Actual scheduling is performed by core's Automated Cron: cron runs on the first request after
  the selected interval has elapsed. This module only supplies the extra dropdown value.
- The textfield performs no numeric/range validation of its own; the config schema types the
  stored value as an integer. Enter a plain number of seconds.
- It does not run cron on demand, add a queue/scheduler, or turn cron off.
