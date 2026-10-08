<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24 (b24) — agent index

Base module for integrating Drupal with **Bitrix24 CRM**. Authenticates via the Bitrix24
local-application **OAuth2** flow, wraps the `crm.*` REST API in a `RestManager` service, and maps
Drupal entities to Bitrix24 records through a `b24_reference` table. Package `bitrix24`. Depends on
**`token`**. Core `^9 || ^10 || ^11`, PHP `^8.1`. License GPL-2.0-or-later. Version 2.1.1.

## What it provides

- **Service `b24.rest_manager`** (`src/Service/RestManager.php`) — the REST client: OAuth token
  refresh, `get()` low-level caller, and `addLead/updateLead/addDeal/updateDeal/addContact/
  updateContact/deleteContact/getLead/getDeal/getContact/getList/getFields/addEntity/updateEntity/
  deleteEntity`, product rows (`setLeadProducts`, `setDealProducts`), and CRM-mode detection
  (`getCrmMode/setCrmMode`). See [api/rest-manager.md](api/rest-manager.md).
- **Service `b24.reference_manager`** (`src/Service/ReferenceManager.php`) — CRUD on the
  `b24_reference` table (Drupal entity ↔ Bitrix24 id, with a change hash).
- **Service `b24.form_helper`** (`src/Service/FormHelper.php`) — builds field-mapping form elements
  from live Bitrix24 field definitions.
- **Config forms / routes** — all under `administer b24 configuration`:
  `b24.credentials` (`/admin/config/b24/credentials`, the configure route),
  `b24.settings` (`/admin/config/b24/settings`, assignee + CRM mode),
  `b24.auth` (`/b24/oauth`, the OAuth callback). See [config/credentials.md](config/credentials.md).
- **Permission** `administer b24 configuration` (restrict access). **Config objects**
  `b24.settings` (site, client_id, client_secret) and `b24.default_settings` (assignee, user_id,
  crm_mode); schema in `config/schema/b24.schema.yml`.
- **Extension points** — `hook_b24_push_alter(&$fields, $context)` (alter outbound fields, see
  `b24.api.php`); `B24Event` events `b24.entity.insert/update/delete` (`src/Event/B24Event.php`).
- **`hook_cron()`** refreshes the access token and syncs CRM mode.
- **`B24Interface`** constants: `CRM_MODE_CLASSIC = 1`, `CRM_MODE_SIMPLE = 2`.

## Submodules (each documented in its own tree under `modules/`)

- **b24_commerce** → [modules/b24_commerce/2.1.x/agent/start.md](../modules/b24_commerce/2.1.x/agent/start.md)
  — export Commerce orders to leads/deals and products to the catalog.
- **b24_contact** → [modules/b24_contact/2.1.x/agent/start.md](../modules/b24_contact/2.1.x/agent/start.md)
  — export core contact-form submissions to leads.
- **b24_user** → [modules/b24_user/2.1.x/agent/start.md](../modules/b24_user/2.1.x/agent/start.md)
  — sync Drupal users ↔ Bitrix24 contacts (live + batch export/import).
- **b24_utm** → [modules/b24_utm/2.1.x/agent/start.md](../modules/b24_utm/2.1.x/agent/start.md)
  — attach captured UTM marks to exported leads.
- **b24_webform** → [modules/b24_webform/2.1.x/agent/start.md](../modules/b24_webform/2.1.x/agent/start.md)
  — export Webform submissions to leads via a Webform handler.

## Solution docs

- [config/credentials.md](config/credentials.md) — install, OAuth setup, credential/settings config, routes.
- [api/rest-manager.md](api/rest-manager.md) — RestManager/ReferenceManager API, events, hooks.
