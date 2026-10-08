<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings form

## Install / enable

```bash
composer require drupal/external_reset_password
drush en external_reset_password -y
```

Depends only on core `user`. No libraries. After configuring, clear the cache (`drush cr`) so the redirect takes effect.

## Settings form

- Class: `Drupal\external_reset_password\Form\ErpSettingsForm` (extends `Drupal\Core\Form\ConfigFormBase`).
- Form ID: `external_reset_password_configuration_form`.
- Route: `external_reset_password.settings_form` → path `/admin/config/people/external-reset-password/settings` (`external_reset_password.routing.yml`).
- Permission requirement: `administer site configuration` (core).
- Menu link: `entity.external_reset_password.settings` (`external_reset_password.links.menu.yml`), parent `user.admin_index`, i.e. Configuration → People → "External reset password".
- `configure` route in `.info.yml` points here.

The form renders a single element:

- `url` — `#type => 'url'`, title "External URL", placeholder `https://`, default from `config('external_reset_password.settings')->get('url')`. `submitForm()` saves `$form_state->getValue('url')` into that config key. Being a `ConfigFormBase`, the form is CSRF-protected and submitted via POST.

## Config object & schema

- Config object: `external_reset_password.settings` (editable name returned by `getEditableConfigNames()`).
- Key: `url` (string). Schema in `config/schema/external_reset_password.schema.yml` types it as `config_object` with mapping `url: string`.
- No `config/install/*` default file ships, so the value is empty until an admin sets it. When empty, the module takes no action.

The value is normal exportable configuration; it moves between environments through config sync.
