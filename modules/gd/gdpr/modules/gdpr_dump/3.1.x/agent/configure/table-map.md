<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring which columns are anonymized (`gdpr_dump.table_map`)

## Settings form

`Drupal\gdpr_dump\Form\SettingsForm` at `/admin/config/gdpr/dump-settings`
(route `gdpr_dump.settings` — the `configure` route; permission `administer site configuration`).
For each listed table it shows its columns with a select of available **anonymizer plugins**
(options come from `plugin.manager.anonymizer`; empty value = "- No -"), plus an
"Empty this table" checkbox. It always surfaces sensitive tables — `users_field_data`,
`comment_field_data`, `contact_message`, `webform_submission`/`_data`/`_log`, and per-field
`user__*` / `comment__*` / `contact_message__*` tables — and lets you add more via the
"More tables" selector.

## Stored config

Config object **`gdpr_dump.table_map`** (constants `GDPR_DUMP_CONF_KEY = 'gdpr_dump.table_map'`,
no-plugin sentinel `'none'`):

```yaml
# config: gdpr_dump.table_map
mapping:
  users_field_data:
    mail: email_anonymizer      # column -> anonymizer plugin id
    name: username_anonymizer
empty_tables:
  sessions: 1                   # table -> 1 means "empty in the dump"
```

- `mapping[<table>][<column>] = <anonymizer_plugin_id>` — the anonymizer applied to that
  column's values at dump time.
- `empty_tables[<table>] = 1` — table is emptied (no rows) in the dump.

## Set it programmatically

```php
\Drupal::configFactory()->getEditable('gdpr_dump.table_map')
  ->set('mapping', ['users_field_data' => ['mail' => 'email_anonymizer']])
  ->set('empty_tables', [])
  ->save();
```

Read which anonymizer applies to a column:
```php
\Drupal::config('gdpr_dump.table_map')->get('mapping')['users_field_data']['mail']; // email_anonymizer
```

The plugin ids come from the [anonymizer](../../../anonymizer/3.1.x/agent/plugins/anonymizers.md)
module (`email_anonymizer`, `username_anonymizer`, `number_anonymizer`, `clear_anonymizer`, …).
There is no config schema shipped for this object.
