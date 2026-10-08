<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas LMS — shared settings

Everything this module does lives in one config object and one form.

## Install / enable

- `drush en canvas_lms -y`. No dependencies, no default config, no install steps.
- It is meant to be enabled alongside consuming modules (Canvas API, Canvas LTI) that read its
  settings; on its own it only exposes the form below.

## Config object: `canvas_lms.settings`

Written by `CanvasLmsSettingsForm` (`src/Form/CanvasLmsSettingsForm.php`,
`getEditableConfigNames()` → `['canvas_lms.settings']`). Two keys:

| Key           | Type                 | Meaning |
|---------------|----------------------|---------|
| `institution` | string               | The subdomain in `https://<institution>.instructure.com`. From the "Institution" textfield. |
| `environment` | string enum          | `test`, `beta`, or `production`. From the "Environment" radios. |

There is **no config schema and no `config/install/` default** shipped — the object does not exist
until an admin saves the form, and both keys are untyped (a schema-completeness note, not a
functional bug). Export with `drush cex` after saving if you manage config in code.

Example exported state:

```yaml
# canvas_lms.settings.yml
institution: myschool
environment: production
```

## Form

- `getFormId()` → `canvas_lms_settings`. Extends `ConfigFormBase`.
- `buildForm()` renders `institution` (textfield, default from config) and `environment` (radios
  test/beta/production, default from config).
- `submitForm()` sets both values on `canvas_lms.settings` and saves, then `parent::submitForm()`
  (standard "configuration saved" message).

## Routes & permissions

| Route | Path | Handler | Permission |
|-------|------|---------|------------|
| `canvas_lms.admin_config` | `/admin/config/canvas_lms` | `SystemController::systemAdminMenuBlockPage` (menu landing) | `administer site configuration` |
| `canvas_lms.settings` | `/admin/config/canvas_lms/canvas_lms` | `CanvasLmsSettingsForm` | `administer site configuration` |

Both routes require the core **`administer site configuration`** permission — the standard,
appropriately-restrictive gate for a settings form. `canvas_lms.settings` is an `_admin_route`.
Menu links (`canvas_lms.links.menu.yml`) place the landing under *Configuration* and the settings
link beneath it.

## Consuming the values

Other modules read (never write) these keys:

```php
$config = \Drupal::config('canvas_lms.settings');
$host = 'https://' . $config->get('institution') . '.instructure.com';
// $config->get('environment') selects test/beta/production behavior in the consuming module.
```

This module itself performs no network I/O; it is purely a shared configuration holder.
