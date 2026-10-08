<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: site-wide default

Route `preserve_changed_ui.settings_form` → `/admin/config/system/preserve-changed-ui`
(`Drupal\preserve_changed_ui\Form\SettingsForm`, a `ConfigFormBase`; form id
`preserve_changed_ui_settings`). Requires permission `administer preserve_changed_ui configuration`.
A menu link (`preserve_changed_ui.links.menu.yml`) places it under
Administration » Configuration » Content authoring (`system.admin_config_content`).

## Config object

Object: `preserve_changed_ui.settings` (schema type `config_object`,
`config/schema/preserve_changed_ui.schema.yml`). Default from `config/install`: `FALSE`.

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `enable_preserve_changed_time` | boolean | `FALSE` | Default checked-state of the per-node "Preserve changed time" checkbox, applied to ALL node types. Editors can still toggle it per node. |

This is only the DEFAULT value for the form checkbox — it does not force the behavior. The actual
preservation happens per node, based on whether the box is checked when that node is saved.

## Set it programmatically

Drush:

```bash
drush config:set preserve_changed_ui.settings enable_preserve_changed_time true -y
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('preserve_changed_ui.settings')
  ->set('enable_preserve_changed_time', TRUE)
  ->save();
```

`SettingsForm::buildForm()` reads `enable_preserve_changed_time` for the checkbox `#default_value`;
`SettingsForm::submitForm()` writes it back. `getEditableConfigNames()` returns
`['preserve_changed_ui.settings']`.
