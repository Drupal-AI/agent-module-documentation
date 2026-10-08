<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External reset password (external_reset_password) — agent index

Redirects Drupal's password-reset request page to an administrator-configured external URL. Version dir `2.0.x` (installed 2.0.3). Core `^8.8 || ^9 || ^10 || ^11`. Package: User interface.

## What it provides

- One config object `external_reset_password.settings` with a single key `url` (schema: `config/schema/external_reset_password.schema.yml`).
- A settings form `ErpSettingsForm` (`Drupal\external_reset_password\Form\ErpSettingsForm`, extends `ConfigFormBase`) at route `external_reset_password.settings_form` → `/admin/config/people/external-reset-password/settings`, requiring the core permission `administer site configuration`.
- An event subscriber service `external_reset_password.redirect_subscriber` (`Drupal\external_reset_password\EventSubscriber\ExternalRedirectSubscriber`) that acts on `kernel.request`.
- A menu link `entity.external_reset_password.settings` under `user.admin_index` (Configuration → People).

## Dependencies

- Core `user` module only. No third-party Composer or PHP library requirements (composer.json requires just `php >=7.2.5` and `drupal/core`).

## Does NOT provide

Permissions (uses the core `administer site configuration` permission), entities, plugins/plugin types, Drush commands, or additional services.

## Solution docs

- [config/settings.md](config/settings.md) — install/enable, the settings form, the config object + schema, route and permission.
- [behavior/redirect.md](behavior/redirect.md) — how the `kernel.request` subscriber redirects the `user.pass` route.
