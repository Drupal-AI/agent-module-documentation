<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECK Site Settings (eck_site_settings) — agent index

Turns **ECK entity types** into global, **singleton "settings" pages**: an ECK entity type flagged
as a settings type gets one lazily-created entity per bundle, editable through the normal ECK edit
form and readable from PHP/Twig/tokens. A content-entity alternative to Config Pages / Site Settings
and Labels. Package `User interface`. Deps: **`eck` (>=2.1)** and core **`options`**. Core
`^9.4 || ^10 || ^11`, PHP 7.4+. License GPL-2.0-or-later. Version 1.3.6 (doc dir `1.x`).

- **Install-created entity type, routes, permission, config schema, the entity-type "is a setting"
  flag, and hook_entity_access rules** → [config/settings.md](config/settings.md)
- **Reading settings: the SettingsRepository service, `site_settings()` Twig function, tokens,
  alter hooks, and the ModuleMigration importer** → [api/repository.md](api/repository.md)
- **Per-domain values (submodule)** → `../../modules/eck_site_settings_domain/1.x/agent/start.md`

## What it actually provides

- **Entity type flag**: any `eck_entity_type` with third-party setting
  `eck_site_settings.enabled = TRUE` is a "settings" type. `eck_site_settings_install()` creates a
  `settings` type + `general` bundle (uid/created/changed/title/standalone_url all FALSE).
- **Routes** (`eck_site_settings.routing.yml`, both `_admin_route`, both gated by permission
  **`access site settings overview`**):
  - `eck_site_settings.settings` — `/admin/content/site-settings`, controller
    `SettingOverviewController` (a table of every settings bundle + ECK operations links).
  - `eck_site_settings.setting` — `/admin/content/site-settings/{bundle}/{entityType}`, controller
    `SettingRedirectController` → 302 to the settings entity's `edit-form`.
- **Permission**: one only — `access site settings overview` (`*.permissions.yml`). Edit/view are
  delegated to ECK's own `edit any <type> entities` / `view any <type> entities`.
- **Service** `eck_site_settings.settings_repository` (`SettingsRepository`, iface
  `SettingsRepositoryInterface`): `getEntityTypes()`, `getBundles()`, `isSetting()`,
  `getSetting()`, `getSettingByClass()`.
- **Twig** `site_settings(bundle, entityTypeId = 'settings', context = [])` — `Twig\SiteSettingsExtension`.
- **Tokens** `eck_site_settings.tokens.inc` — `[eck_site_settings:<type>-<bundle>:<field>]`.
- **Menu deriver** `Plugin/Derivative/SettingsMenuItemsDeriver` — builds admin-menu links per
  settings type/bundle under `system.admin_content`.
- **Form alters** (`.module`): checkbox "Use this entity type for site settings" on the ECK
  entity-type form (`EckEntityTypeFormAlter`); hides irrelevant create/view/delete ECK permissions
  and force-couples view-when-edit on the permissions form and `user_role_presave`.
- **Alter hooks** (`.api.php`): `hook_eck_site_setting_context_alter`, `hook_eck_site_setting_values_alter`.
- **Migration** `ModuleMigration` (`fromSiteSettings()`, `fromWmSettings()`), iface
  `ModuleMigrationInterface` — run from a deploy hook.
- **Config schema**: `eck.eck_entity_type.*.third_party.eck_site_settings` (`enabled: boolean`).

## Access model (important for correctness, not a vuln)

`hook_entity_access` forbids `delete` and `clone`, and `hook_entity_create_access` forbids `create`,
for any settings entity — so settings are managed-only singletons. Edit and view fall through to
ECK's standard entity permissions. The overview and redirect routes require only
`access site settings overview`; the redirect target (`edit-form`) enforces ECK edit access itself.
