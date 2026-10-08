<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, permissions & routes

## Settings form (`Form/SettingsForm`)

- Route `client_support.settings_form` → `/admin/config/client-support/client-support-settings`,
  `_permission: administer client support`, `_admin_route: TRUE`. Form id
  `client_support_settings_form`; extends `ConfigFormBase`.
- Editable config: `client_support.settings`.
- `buildForm()` builds a single **required** `select` named `integration_plugins`, options = every
  discovered SupportIntegration plugin (`id => title`), default from
  `settings.integration_plugin`.
- `submitForm()` writes the chosen id to `client_support.settings:settings.integration_plugin`.

With only the base module enabled the select is empty (no plugins), so there is nothing meaningful
to save — enable `client_support_contact_form` or a custom plugin first.

## Config object

`client_support.settings` — one key:

| key | value |
|-----|-------|
| `settings.integration_plugin` | plugin id of the active SupportIntegration plugin (e.g. `contact_form`) |

Created on first save of the settings form. **No default config file and no config schema** ship
with the module (`provides_config_schema: false`); the config is untyped.

## Landing page route

`client_support.settings` → `/admin/config/client-support` uses core
`SystemController::systemAdminMenuBlockPage` to render the child admin-menu links; requires
`administer client support`, `_admin_route: TRUE`. Admin-menu links are declared in
`client_support.links.menu.yml` (`system.admin_config.client_support` and
`client_support.settings_form`).

## Permissions (`client_support.permissions.yml`)

| permission | grants |
|------------|--------|
| `access client support` | See/use the Support toolbar tab and reach `/client-support`. Note: "users must have access for the target route as well." |
| `administer client support` | Reach the settings form and choose the active plugin. |

Both are non-restricted string permissions (no `restrict access` flag). Because a support
destination (e.g. the contact form) may collect personal data, grant `administer client support`
only to trusted staff.

## Route summary

| route | path | access |
|-------|------|--------|
| `client_support.toolbar` | `/client-support` | `access client support` |
| `client_support.settings` | `/admin/config/client-support` | `administer client support` |
| `client_support.settings_form` | `/admin/config/client-support/client-support-settings` | `administer client support` |
