<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Engaging Networks (engaging_networks) — agent index

A thin Drupal service wrapper around the **Engaging Networks Services (ENS) REST API**, built on the
`openpublicmedia/engaging-networks-php` library. Package `Web services`. Core `^10.3 || ^11`, PHP `>=8.1`.
License GPL-2.0-or-later. Version-dir 1.0.x (installed release **1.0.0-beta1**). Marked unsupported on drupal.org.

Hard dependency: **`key`** (Key module) — stores the ENS API key as a Key entity. Library dependency:
`openpublicmedia/engaging-networks-php` `~0.10` (Composer, not a front-end JS library).

- **The service + client wiring, methods, token/auth flow** → [api/rest-client.md](api/rest-client.md)
- **The settings form, config object, schema, routes, permission** → [config/settings.md](config/settings.md)

## What it actually provides

- **One service** `engaging_networks.rest_api` → `Drupal\engaging_networks\RestApi` (`src/RestApi.php`,
  args `@config.factory`, `@key.repository`, `@state`). `getClient()` returns the library `Client`.
- **One config-form** `Drupal\engaging_networks\Form\RestApiSettingsForm` (`src/Form/RestApiSettingsForm.php`),
  a `ConfigFormBase` editing config object **`engaging_networks.rest_api`**.
- **One permission** `administer engaging networks` (`restrict access: TRUE`), gating both routes.
- **Two routes** (`engaging_networks.routing.yml`): `engaging_networks.admin_config_engaging_networks`
  (`/admin/config/engaging-networks`, core `SystemController` menu block) and
  `engaging_networks.settings.rest_api` (`/admin/config/engaging-networks/settings/rest-api`, the form).
- **No** entities, blocks, plugins, hooks, Drush commands, webhooks, or public/anonymous endpoints.

## Notes

- `configure:` in `engaging_networks.info.yml` points at `engaging_networks.settings`, but no route by that id
  exists — the working form route is `engaging_networks.settings.rest_api`.
- Data flow is **outbound only**: Drupal → ENS REST API. No inbound callback/webhook route ships.
