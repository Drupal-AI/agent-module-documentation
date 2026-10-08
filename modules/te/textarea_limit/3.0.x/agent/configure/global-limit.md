# Global character limit

The module keeps one site-wide number that any opted-in widget can share instead of
carrying its own limit. Set it on the settings form or directly in config.

- Route: `textarea_limit.settings` → `/admin/config/content/textarea-limit`
- Form: `\Drupal\textarea_limit\Form\LimitTextSettingsForm` (`getFormId()` = `textarea_limit_text_settings_form`)
- Permission required: `administer textarea_limit`
- Config object: `textarea_limit.settings`
- Menu link: `textarea_limit.settings` under `system.admin_config_content` (admin menu)

## Config keys

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `global_limit` | string | `'1000'` | Character count offered to widgets whose third-party setting `textarea_limit_use_global_limit` is on. |

The form's single field is a plain `textfield` (`#title` "Global limit"). It is stored as
the raw submitted string — the value is not cast to int and is not validated for range or
type, so keep it numeric. When the stored value is empty the form re-defaults the displayed
value to `'1000'`, but a widget reading an empty `global_limit` simply gets no limit (see
`configure/widget.md`).

## Set it without the UI

Drush:

```
drush config:set textarea_limit.settings global_limit 500
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('textarea_limit.settings')
  ->set('global_limit', '500')
  ->save();
```

## Note on config schema

No `config/schema/*.yml` ships with the module. `config/install/textarea_limit.settings.yml`
seeds `global_limit: '1000'` at install, but there is no typed-config schema, so this config
is untyped (config inspector / translation tooling will flag it).
