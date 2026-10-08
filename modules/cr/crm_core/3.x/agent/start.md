<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core (crm_core) — agent index

The **base module** of the CRM Core suite. By itself it provides only the CRM admin
sections, a settings form and an optional per-page theme; contacts/activities/matching/sync
live in its submodules. Package `CRM Core`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
No hard dependencies (the base `crm_core.info.yml` declares none).

## What the base module actually provides

- **Routes** (`crm_core.routing.yml`):
  - `crm_core.manage` → `/admin/structure/crm-core` (system admin menu block; perm `administer site configuration`).
  - `crm_core.config_overview` → `/admin/config/crm-core` (perm `administer site configuration`). This is the `configure` route.
  - `crm_core.overview` → `/crm-core` (custom access via `CRMCoreAccess::access`).
  - `crm_core.settings` → `/admin/config/crm-core/settings` (form `SettingsForm`, perm `administer crm-core`).
- **Config**: object `crm_core.settings` with a single key `custom_theme` (schema in `config/schema/crm_core.settings.yml`, default `''` in `config/install/`).
- **Service** (`crm_core.services.yml`): `theme.negotiator.admin_theme.crm_core` = `Theme\CrmCoreNegotiator` — when `custom_theme` is set, forces that theme on any path starting `/crm-core` (theme_negotiator priority -39).
- **Access helper**: `Access\CRMCoreAccess` grants `/crm-core` if the user can reach any child menu link AND holds one of `administer crm_core_individual entities`, `administer crm_core_organization entities`, or `view any crm_core_activity entity`.
- **Permission builder**: `CRMCorePermissions::entityTypePermissions($entity_type)` — a helper used by the submodules' `permission_callbacks` to generate per-entity `administer / create / edit own / edit any / view own / view any` permissions. The base module ships **no** `*.permissions.yml` of its own.
- **Hook**: `crm_core_page_attachments()` attaches the `crm_core/admin` CSS library on the toolbar for users who can see `/crm-core`.
- **API hooks** (`crm_core.api.php`): `hook_crm_core_contact_CONTACT_BUNDLE_label()`, `hook_crm_core_contact_merge_contacts()`.

## Solution docs

- **General settings + CRM theme negotiator** → [config/settings.md](config/settings.md)
- **Permission/access model & the CRMCorePermissions helper** → [api/permissions-access.md](api/permissions-access.md)

## Submodules (each documented in its own tree under `../modules/<sub>/3.x/`)

- **crm_core_contact** — Individual & Organization entities, bundle types, primary fields, contact actions.
- **crm_core_activity** — Activity entity + activity-type plugins.
- **crm_core_match** — matcher config entity + matching-engine and match-field plugin frameworks.
- **crm_core_user_sync** — pairs user accounts with Individual contacts (Relation entity, rules, block).
- **crm_core_demo** — sample contact/activity type config only.
