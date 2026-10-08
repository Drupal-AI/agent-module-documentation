<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings entity types, routes & permission

How eck_site_settings creates and gates its settings pages. Cites `eck_site_settings.install`,
`.routing.yml`, `.permissions.yml`, `.links.menu.yml`, `config/schema/eck_site_settings.schema.yml`,
`src/EckEntityTypeFormAlter.php`, `src/Controller/*`, and `eck_site_settings.module`.

## Install / enable

`ddev drush en eck_site_settings -y`. Requires `eck` (>=2.1) and core `options`.
`eck_site_settings_install($isSyncing)` (skips when syncing config):
1. Creates the `settings` **eck_entity_type** unless it already exists, with `uid`, `created`,
   `changed`, `title`, `standalone_url` all `FALSE` and third-party setting
   `eck_site_settings.enabled = TRUE`.
2. Creates a `settings_type` bundle `general` (label "General") unless any bundle exists.

Updates: `_update_8002()` re-saves all roles (to trigger the view-when-edit grant, below);
`_update_8003()` forces `standalone_url = FALSE` on every settings entity type.

## What makes an entity type a "setting"

A settings entity type is simply an `eck_entity_type` config entity whose third-party setting
`eck_site_settings.enabled` is `TRUE`. Schema: `config/schema/eck_site_settings.schema.yml` defines
`eck.eck_entity_type.*.third_party.eck_site_settings` → `enabled: boolean`.

`EckEntityTypeFormAlter::alterForm()` (service `eck_site_settings.entity_type_form_alter`, wired
from `hook_form_eck_entity_type_form_alter`) adds a **"Use this entity type for site settings"**
checkbox to the ECK entity-type form, defaulting to the current third-party value, and disables the
"standalone URL" checkbox while it is ticked. The entity builder `formBuilder()` writes the checkbox
into `eck_site_settings.enabled` and, when enabled, sets `standalone_url = FALSE`.

`SettingsRepository::getEntityTypes()` / `isSetting()` find settings types by querying
`eck_entity_type` with `condition('third_party_settings.eck_site_settings.enabled', TRUE)`
(`accessCheck(FALSE)`); `isSetting()` caches the result in `cache.static` under
`eck_site_settings:is_setting:<id>` tagged `eck_entity_type:<id>`.

## Routes & permission

`eck_site_settings.permissions.yml` defines exactly one permission:
**`access site settings overview`** — "Access the overview page of all site settings".

`eck_site_settings.routing.yml` (both routes `options._admin_route: TRUE`, both
`requirements._permission: 'access site settings overview'`):

| Route | Path | Controller | Purpose |
|-------|------|-----------|---------|
| `eck_site_settings.settings` | `/admin/content/site-settings` | `SettingOverviewController::__invoke` | Table of settings types/bundles + ECK operations links |
| `eck_site_settings.setting` | `/admin/content/site-settings/{bundle}/{entityType}` (`entityType` defaults null) | `SettingRedirectController::__invoke` | 302 to the setting's `edit-form` |

`SettingOverviewController` lists `getEntityTypes()`; for each, groups bundles (with a bold
type-label header row when more than one settings type exists), loads each singleton via
`settings->getSetting($bundle->id(), $entityType->id())`, and renders the ECK list builder's
`getOperations()` in a `#theme => 'table'`. `SettingRedirectController` resolves the singleton and
returns `new RedirectResponse($setting->toUrl('edit-form')->toString())`, throwing 404 on unknown
bundle/type. The `edit-form` it redirects to enforces ECK's own `edit any <type> entities`
permission — the overview permission alone does not grant edit rights.

## Admin menu

`eck_site_settings.links.menu.yml`: a `Settings` link under `system.admin_content`, plus a derived
group `eck_site_settings.settings.types` whose deriver
`Plugin/Derivative/SettingsMenuItemsDeriver` emits one link per settings type/bundle (grouping under
a `<nolink>` per-type parent when more than one settings type exists), each pointing at the
`eck_site_settings.setting` redirect route.

## Permission hiding & view-when-edit coupling (`.module`)

- `hook_form_user_admin_permissions_alter` **unsets** the create/delete (and, with
  `eck_bundle_permissions`, per-bundle create/delete) permissions of every settings entity type from
  the permissions form (they are irrelevant for singletons), and calls
  `_eck_site_settings_permissions_force_view_when_edit()` to add `#states` that auto-check and
  disable each `view any/own` checkbox when the matching `edit any/own` is checked.
- `hook_user_role_presave` enforces the same server-side: granting `edit any/own <type> entities`
  also grants the matching `view` permission.
- `hook_entity_access`: for any settings entity, `delete` and `clone` return **forbidden**;
  everything else neutral. `hook_entity_create_access`: settings entities return **forbidden** for
  `create`. So settings singletons cannot be manually created, cloned, or deleted — only edited.

## Operate it

1. Add fields to the `general` bundle at `admin/structure/eck/entity/settings/…` (Field UI).
2. Grant editors `access site settings overview` and ECK `edit any settings entities`
   (`view any settings entities` follows automatically).
3. Editors open `/admin/content/site-settings` → edit a bundle's singleton.
4. Read the values via the service, `site_settings()` Twig function, or tokens — see
   [../api/repository.md](../api/repository.md).
