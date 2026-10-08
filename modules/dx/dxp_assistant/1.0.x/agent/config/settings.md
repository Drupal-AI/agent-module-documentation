<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DXP Assistant — configuration

## Install / enable
```
composer require drupal/dxp_assistant
drush en dxp_assistant -y
```
No module dependencies, no Composer requirements (the project ships no `composer.json`), no PHP extension requirement. Requires Drupal core `^10.4 || ^11`. This is a `1.0.0-alpha1` pre-release.

## Settings form
- Class: `Drupal\dxp_assistant\Form\DxpAssistantConfigurationForm` (extends `ConfigFormBase`), form id `dxp_assistant_configuration_form`.
- Route: `dxp_assistant.configuration` → path `/admin/config/user-interface/dxp-assistant`, title "DXP Assistant".
- Access: `_permission: 'administer dxp assistant'`.
- Menu link: `dxp_assistant.links.menu.yml`, parent `system.admin_config_ui` (Configuration → User interface → DXP Assistant).

The form renders exactly one field:
- **Script URL** (`script_url`, `#type` textfield) — "Enter the URL from which to load the DXP Assistant script." `buildForm()` seeds it from `dxp_assistant.configuration:script_url`; `submitForm()` writes the raw submitted value back with `->set('script_url', $values['script_url'])->save()`.

There is no API key, tenant id, secret, token, or endpoint field on this form — the only stored setting is the script URL. The URL is saved as **plain configuration**; it is not treated as a secret, and the module has no environment-variable / Key-module credential flow.

## Config object & schema
- Config object: `dxp_assistant.configuration`.
- Key: `script_url` (string).
- Schema: `config/schema/dxp_assistant.schema.yml` — `type: config_object`, `mapping.script_url.type: string`.
- No `config/install/` default is shipped, so `script_url` is unset (null) until an admin saves the form. While unset, the module attaches nothing.

## Permissions
`dxp_assistant.permissions.yml` defines two permissions:
- `access dxp assistant` — "Determines if the DXP assistant script should be loaded for the current user." Grant to whichever roles should receive the assistant (including the anonymous role if the assistant is public).
- `administer dxp assistant` — "Access the DXP assistant configuration." Guards the settings route above.

Configure both at `/admin/people/permissions`.
