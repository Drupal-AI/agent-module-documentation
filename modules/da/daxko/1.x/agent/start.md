<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Daxko (daxko) — agent index

Basic server-side integration with the **Daxko** operations API for **Open Y / YMCA Website
Services** sites. Wraps Daxko REST endpoints in a Guzzle client and feeds branch/program/
membership data into Open Y via the "Socrates" data-service layer. Package *YMCA Website Services*.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version 1.0.5 (doc dir `1.x`).

**Dependencies (hard, non-core):** `openy_socrates`, `openy_mappings`. No composer requirements,
no libraries. Guzzle comes from core.

## What it provides

- **Services** (`daxko.services.yml`):
  - `daxko.client` — a `Drupal\daxko\DaxkoClient` (extends `GuzzleHttp\Client`), built by
    `daxko.client.factory` (`DaxkoClientFactory::get`) from `daxko.settings`.
  - `daxko.data_wrapper` — `Drupal\daxko\DaxkoDataWrapper`, tagged `openy_data_service`
    (priority 100) so Open Y Socrates can call it.
  - `logger.channel.daxko_data_wrapper` — logger channel.
- **Config:** one object `daxko.settings` (`client_id`, `base_uri`, `user`, `pass`). No config
  schema file ships. Settings form `Form\SettingsForm` (`administer daxko`).
- **Route:** `daxko.settings` → `/admin/openy/integrations/daxko/daxko` (permission
  `administer daxko`). Menu link `daxko.admin` under `openy_system.openy_integrations_daxko`.
- **Permission:** `administer daxko`.
- **No** controllers, blocks, entities, plugins, hooks, or Drush commands (README drives
  operations through `drush ev`).

## Solution docs

- **Configure the API client + credentials, and the settings form** →
  [config/settings.md](config/settings.md)
- **The HTTP client, the data wrapper, Socrates integration, and how to operate it** →
  [api/client-and-datawrapper.md](api/client-and-datawrapper.md)

## Notes

- `DaxkoClient::__call` maps method names to fixed Daxko URIs: `getBranches` → `branches`,
  `getSessions` → `sessions`, `getPrograms` → `programs`, `getChildCarePrograms` →
  `childcare/programs`, `getMembershipTypes` → `membershiptypes`. Args become a query string.
- The price-matrix / branch-pin sample data in `DaxkoDataWrapper` and `DummyDataWrapper` is
  hard-coded placeholder data; the live path is `populateDaxkoMembershipTypes()`.
