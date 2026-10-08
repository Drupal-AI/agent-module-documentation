<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACSF Modules Listing Module (acsf_module_listing) — agent index

Administrative reporting tool for **Acquia Cloud Site Factory (ACSF)**. It searches which modules
are enabled across the sites of an ACSF environment: it calls the **Acquia Cloud API v1** for the
site list, then runs **`drush pm-list` over SSH** on each site and matches the output against a
search term. Package *Acquia Cloud Site Factory*. Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.3. **Requires the PHP `ssh2` extension** (search form degrades to a
notice when `ssh2_connect()` is absent). No composer/Drupal module dependencies. Does **not** expose
the current site's own module list to anyone — it audits remote sites.

- **Config entity, credentials, forms, routes, permissions, cache** →
  [config/environments.md](config/environments.md)
- **The search flow: Acquia API + SSH/drush services and the batch** →
  [api/search-flow.md](api/search-flow.md)

## What it provides (from source)

- **Config entity type** `acsf_environment_entity` (`src/Entity/AcsfEnvironmentEntity.php`,
  `@ConfigEntityType`, `admin_permission = "administer acsf_environment_entity"`). One entity per
  ACSF environment; stores SSH creds (`ssh_user`, `ssh_url`, `drush_path`, `public_key_path`,
  `private_key_path`, `pass_phrase`) and Acquia API creds (`acsf_env_url`, `acsf_username`,
  `acsf_api_key`) plus `label`/`description`. `config_export` includes all of these. List builder
  `AcsfEnvironmentEntityListBuilder`; add/edit form `Form\ACSFEnvironmentEntityForm`; delete uses
  core `EntityDeleteForm`. Accessors via `Entity\AcsfEntityVariableTrait` (`getVariable()`/`setVariable()`).
- **Simple config** `acsf_module_listing.modules_usage_configuration` — one key
  `configuration.cache_lifetime` (install default 86400; form default 3600). Schema in
  `config/schema/acsf_module_listing.schema.yml`.
- **Forms**: `Form\ACSFModulesListingForm` (search), `Form\ACSFModulesListingConfigurationForm`
  (cache lifetime), `Form\ACSFEnvironmentEntityForm` (environment entity).
- **Services** (`acsf_module_listing.services.yml`):
  - `acsf_module_listing.acsf_api_v1_service` → `Services\AcsfApiV1Service` — GET
    `{acsf_env_url}/api/v1/sites` with Guzzle basic auth `[username, api_key]`, `limit=10000`.
  - `acsf_module_listing.ssh_service` → `Services\SshShellService` — `ssh2_connect` +
    `ssh2_auth_pubkey_file`, runs `drush -r <path> -l <site> pm-list`, caches results.
  - `acsf_module_listing.acsf_environment_entity` → `Services\AcsfEnvironmentEntityService` — loads
    entities by id.
  - `acsf_module_listing.acsf_modules` → `Services\AcsfModulesCommon` — `remapModulesList()` maps
    site→modules to module→sites (helper; not wired into the shipped forms).
- **Permission** (`acsf_module_listing.permissions.yml`): `administer acsf_environment_entity`.
- **Routes** (`acsf_module_listing.routing.yml`): search `/admin/config/services/modules-usage/search`,
  config `/…/configuration`, entity collection/add/edit/delete under
  `/admin/structure/acsf-environment-entity`. See [config/environments.md](config/environments.md).

## Notes

- `.module` is empty ("Not much to see here"). No hooks, no Drush commands, no plugin types.
- The route `acsf_module_listing.modules_usage.list` references a form class
  `Drupal\acsf_module_listing\Form\ACSFModulesStatisticsForm` that **does not exist in the source**
  — that admin path (`/…/modules-usage/list`) is broken (500/class-not-found) as shipped.
