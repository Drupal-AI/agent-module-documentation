<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ecomail — settings, config object, route & permission

## Install / enable

- Requires the core **`key`** module (`dependencies: - key:key` in `ecomail.info.yml`) and the
  Composer packages `ecomailcz/ecomail` (the PHP SDK) and `drupal/key`. Install with Composer so the
  SDK autoloads, then enable `ecomail`.
- Before the service can authenticate you must create a **Key entity** holding the Ecomail API key
  (Key module, e.g. an env or configuration provider), then select it on the settings form.

## Settings form

- Class `Drupal\ecomail\Form\SettingsForm` (extends `ConfigFormBase`), form id `ecomail_settings`.
- `getEditableConfigNames()` → `['ecomail.settings']`.
- `buildForm()` adds a single element `api_key` of `#type => 'key_select'` (`#required => TRUE`),
  titled *"Ecomail API key"*, defaulted from `ecomail.settings:api_key`. This selector lists Key
  entities; the stored value is the **Key entity's machine name**, not the secret itself.
- `submitForm()` saves `form_state->getValue('api_key')` into `ecomail.settings:api_key`.

## Config object

- `ecomail.settings` — key **`api_key`** = name of the Key entity that holds the Ecomail API key.
- Schema `config/schema/ecomail.schema.yml` declares `ecomail.settings` as a `config_object` but only
  maps a placeholder key `example` (string); it does **not** declare `api_key`. The schema is a stub
  and does not match the config the form actually writes.

## Route, menu link & permission

- Route `ecomail.settings` (`ecomail.routing.yml`): path `/admin/config/services/ecomail`, `_form`
  `SettingsForm`, title *"Ecomail settings"*.
- Menu link `ecomail.settings` (`ecomail.links.menu.yml`) under `system.admin_config_services`
  (Configuration → Web services), weight 10.
- The route requirement is `_permission: 'administer ecomail configuration'`.
- **Permission-name mismatch (functional bug):** `ecomail.permissions.yml` defines the permission
  `administer ecomail` (title *"administer ecomail"*, `restrict access: TRUE`) — **not**
  `administer ecomail configuration`. Because the route requires a permission that is never declared,
  no role can be granted it, so the settings form is reachable only by user 1 (superuser bypass).
  Aligning the two names (in either file) is required to grant the form to a normal admin role.

## Operating notes

- The module has no `.module`/`.install`, no cron, no queue and no update hooks; enabling it only
  registers the service, route, menu link, permission and config schema.
- To use the integration, other code should read the configured key via the service (see
  [../api/client.md](../api/client.md)) rather than reading `ecomail.settings` directly.
