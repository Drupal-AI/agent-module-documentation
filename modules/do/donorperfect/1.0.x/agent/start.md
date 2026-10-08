<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DonorPerfect Base Module (donorperfect) — agent index

Base integration with the **DonorPerfect** nonprofit CRM. Exposes DonorPerfect records as
Drupal content entities (via four submodules), provides the **`DPQuery`** XML-API client and
Name/Address/Email/Phone form elements. Package `DonorPerfect`. Core `^10 || ^11`, PHP `^8.0`.
License GPL-2.0-or-later. Version 1.0.x (installed 1.0.20).

Dependencies: core `datetime`, `options`; contrib **`address` (^2.0)** and **`entity` (^1.0)**.
Submodules (each its own doc tree): `donorperfect_donor`, `donorperfect_gift`,
`donorperfect_contact`, `donorperfect_other`.

## Solution docs

- **The DPQuery client, the XML API endpoint, credential config, hooks, metadata cache** →
  [api/dpquery.md](api/dpquery.md)
- **Settings form, config objects, routes, permissions, entity-field selection, cache refresh** →
  [config/settings.md](config/settings.md)
- **Name/Address/Email/Phone form elements, FormValidator, donor AJAX search** →
  [forms/elements.md](forms/elements.md)

## What it provides (from source)

- **Services** (`donorperfect.services.yml`):
  - `donorperfect.dpquery` → `DPQuery` (Guzzle `http_client`, config.factory, current_user, dputility).
  - `donorperfect.dputility` → `DPUtility` (module_handler, extension.list.module, config.factory,
    entity_type.manager, current_user).
  - `donorperfect.entity.controller_service` → `ControllerService`, a `service_collector` gathering
    all `donorperfect.entity_controller`-tagged services (submodules register here).
  - `donorperfect.entity.query` → `Entity\Query\QueryFactory` (`backend_overridable`), backing the
    custom entity storage that queries DonorPerfect.
  - `donorperfect.views.date_sql` → `Plugin\views\query\SqlsrvDateSql`.
- **Routes** (`donorperfect.routing.yml`):
  - `donorperfect.admin` — `/admin/donorperfect` (perm `donorperfect user`).
  - `donorperfect.admin.settings` — `/admin/donorperfect/settings` → `Form\SettingsForm`
    (perm `donorperfect admin`).
  - `donorperfect.admin.refresh_cache` — `/admin/donorperfect/refresh-cache/{ajax}` →
    `Controller\DonorPerfectController::refreshCache` (perm `donorperfect user`).
  - `donorperfect.form_element.name.search` — `POST /donorperfect/form_element/name/search` →
    `DonorPerfectController::searchDonors` (perm `donorperfect user`).
- **Permissions** (`donorperfect.permissions.yml`, both `restrict access: TRUE`):
  `donorperfect user`, `donorperfect admin`.
- **Config**: `config/install/donorperfect.settings.yml` (ships `first_name_variations`). Runtime
  config objects: `donorperfect.settings` (holds `api` credentials, `entity.*.fields`,
  `first_name_variations`) and `donorperfect.cache` (`dptables`, `dpcodes`, `dpmultivalues`).
  **No config schema is shipped** (`config/schema/` does not exist).
- **Form elements** (`src/Element/*`): `donorperfect_name`, `donorperfect_address`,
  `donorperfect_email`, `donorperfect_phone` (base `FormElementBase`); validation via
  `src/FormValidator.php`.
- **Entity framework** (`src/Entity/*`): `EntityBase` (builds base fields from the metadata cache),
  custom `Storage`/`StorageSchema`/`Query\*`/`ViewsData`, and `AccessControlHandler` (extends
  `entity` module's handler; **delete is always forbidden**).
- **Hooks**: `hook_form_alter` (wires `FormValidator::addValidation`), `hook_toolbar_alter`
  (adds the toolbar library). Provided alter hooks in `donorperfect.api.php`:
  `donorperfect_api_credentials_load`, `_validate`, `_save`, and `donorperfect_field_defaults`.

## Not provided

No Drush commands. No new plugin *types* (it implements core Views/entity plugin types). No block
plugins. No config schema.
