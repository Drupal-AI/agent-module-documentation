<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA HubSpot (eca_hubspot) — agent index

Adds **40 HubSpot CRM actions to ECA**. Package `ECA`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version dir 1.0.x (release 1.0.0). No routes, no permissions, no config forms, no Drush.

- **Dependencies (both required):** `eca:eca` (Event–Condition–Action) and `hubspot_api:hubspot_api`
  (supplies the API client + credentials). Binds to the `hubspot/api-client` PHP SDK (`\HubSpot\…`),
  which `hubspot_api` provides. Credentials/token/TLS live in `hubspot_api` — **not** in this module.
- **What it provides:** ECA Action plugins only (`src/Plugin/Action/*`), all in the *"HubSpot"*
  action category, plus one service `eca_hubspot.hubspot` (`HubSpotService`) and a private logger
  channel `logger.channel.eca_hubspot`.

## Solution docs

- **All 40 actions — ids, config fields, YAML/token behavior, config schema** →
  [plugins/actions.md](plugins/actions.md)
- **`HubSpotService` — SDK client, per-object methods, associations, search, response formatting** →
  [api/service.md](api/service.md)

## Quick facts (from source)

- `eca_hubspot.info.yml`: `dependencies: eca:eca`, `hubspot_api:hubspot_api`; `package: ECA`.
- `eca_hubspot.services.yml`: `eca_hubspot.hubspot` = `Service\HubSpotService`
  (args `@hubspot_api.manager`, `@logger.factory`, `@token`); logger channel `eca_hubspot`.
- Action base classes: `HubSpotActionBase` (extends ECA `ConfigurableActionBase`) and
  `HubSpotSearchActionBase`. Every action attribute pair is `#[Action(... category: 'HubSpot',
  type: 'system')]` + `#[EcaAction(... version_introduced: '1.0.0')]`.
- Config schema for all action configs in `config/schema/eca_hubspot.schema.yml`
  (`action.configuration.eca_hubspot_*`). No `config/install`, no settings config object.
- 7 objects × {create, update, get, delete, search} + associate/disassociate/get-associations +
  list/get pipeline = 40 actions.
