<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DruxtJS (druxt) — agent index

Drupal back-end bridge for a decoupled **Drupal + Nuxt.js** site. Exposes a curated set of core
**JSON:API** resources to a frontend and enriches **Decoupled Router** path translation. Version
**1.3.1**. Core `^10 || ^11 || ^12`.

## Dependencies (all required, in info.yml)
`decoupled_router`, `jsonapi` (core), `jsonapi_menu_items`, `jsonapi_views`.
Composer: `drupal/decoupled_router:^2.0`, `drupal/jsonapi_menu_items:^1.2`, `drupal/jsonapi_views:^1.1`.

## What it provides
- **Permissions** (`druxt.permissions.yml`): `access druxt resources` (read the exposed JSON:API
  resources); `administer druxt` (restricted; configure the list).
- **Route** (`druxt.routing.yml`): `druxt.settings` → `/admin/config/services/druxt`, settings form,
  requires `administer druxt`. Menu link under *Configuration → Web services*.
- **Config**: `druxt.settings` (`resources` sequence) with schema constraint `DruxtResource`
  (`config/schema/druxt.schema.yml`, default list in `config/install/druxt.settings.yml`).
- **Access model** (`druxt.module`): `druxt_entity_access()` + `druxt_jsonapi_entity_filter_access()`
  grant read to configured resources for holders of `access druxt resources`; `druxt_resources()` /
  `druxt_default_resources()` build the list; `hook_druxt_resources_alter()` extends it (`druxt.api.php`).
- **Services** (`druxt.services.yml`): four event subscribers — three extend Decoupled Router's
  `RouterPathTranslatorSubscriber` (`ContactPathTranslatorSubscriber`, `ViewsPathTranslatorSubscriber`,
  `WildcardPathTranslatorSubscriber`); `DruxtConfigImportSubscriber` validates the resource list on import.
- **Service modifier** (`DruxtServiceProvider`): enables **CORS** by default.
- **Plugins**: `Plugin/Condition/DruxtRequestPath` (overrides core `request_path` condition via
  `hook_condition_info_alter`); `Plugin/Validation/Constraint/DruxtResource(+Validator)`.
- **Install** (`druxt.install`): `hook_requirements` status-report checks; `druxt_install` /
  `druxt_update_9000` create missing entity view displays; `druxt_update_10301` installs default config.

## Solution docs
- [Settings & exposed-resource configuration](config/settings.md)
- [Access model, resource list & the alter hook](api/resources.md)
- [Decoupled Router path-translation subscribers & CORS](api/path-translation.md)

No sub-modules. No Drush commands. Provides no new plugin types (uses core Condition/Validation types).
