<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object, route & permission

## Install & enable

```bash
drush en admin_status_report -y
```

No dependencies and no composer.json ship with the package; it is pure Drupal + core services.

## Route, menu, permission

- Route `admin_status_report.admin_status_form` (`.routing.yml`):
  - path `/admin/config/system/admin_status_report`
  - `_form: \Drupal\admin_status_report\Form\AdminStatusReportForm`
  - `requirements: _permission: 'administer admin status report'`
- Menu link `admin_status_report.admin_status_form` (`.links.menu.yml`) under
  `system.admin_config_system` (Configuration → System). Also referenced as `configure` in the
  `.info.yml`.
- Permission `administer admin status report` (`.permissions.yml`, title "Administer admin status
  messages"). This is the **only** permission the module defines, and it gates only the settings
  form.

## The settings form

`src/Form/AdminStatusReportForm.php` extends `ConfigFormBase`; editable config is
`admin_status_report.settings` (`getEditableConfigNames()`), form id `admin_status_report_form`.

`buildForm()`:
- loads `plugin_status` from config (default `[]`),
- calls `adminStatusManager->getDefinitions()` and, per plugin, renders a `details` fieldset with:
  - the plugin's `description()` as `#markup`,
  - an **Enable** checkbox (`plugin_status[<id>][enabled]`),
  - the plugin's own `configForm()` sub-form inside a `fieldset` that is `#states`-hidden until the
    plugin is enabled.

`validateForm()` iterates the submitted `plugins` values and calls each plugin's
`configValidateForm()`. `submitForm()` iterates them, records `enabled` = `!empty($v['enabled'])`,
calls each plugin's `configSubmitForm()` to produce the values to persist, and writes the assembled
array to `admin_status_report.settings:plugin_status`.

## Config object shape

`admin_status_report.settings` holds a single key:

```yaml
plugin_status:
  core_status_report:
    enabled: true
    config:
      message_type:
        error: error
        warning: 0
  default_message:
    enabled: false
    config:
      type: warning
      message: 'Scheduled maintenance tonight.'
```

- `enabled` (bool) — whether the plugin's messages are displayed.
- `config` (array) — per-plugin options, whose shape is defined by that plugin's `configForm()` /
  `configSubmitForm()`.

**No `config/schema/*` file ships**, so strict config-schema validation tooling will flag
`admin_status_report.settings`; the values still save and load correctly.

## Operating it

1. Enable the module.
2. Grant `administer admin status report` to the appropriate role(s).
3. Visit `/admin/config/system/admin_status_report`, tick the plugins you want, set their options,
   and save.
4. Enabled plugins' messages then render through the messenger — see
   [../plugins/admin-status.md](../plugins/admin-status.md) for when and to whom they display.
