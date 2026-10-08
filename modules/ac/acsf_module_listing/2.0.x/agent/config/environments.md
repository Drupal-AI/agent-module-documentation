<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration, entities, routes & permissions

## Install / enable

- `drush en acsf_module_listing`. **Requires the PHP `ssh2` extension**
  (`https://www.php.net/manual/en/book.ssh2.php`). If `ssh2_connect()` is not available, the search
  form (`ACSFModulesListingForm::buildForm()`) renders only a notice linking to the SSH2 docs and no
  search is possible. No composer requirements, no Drupal module dependencies (`.info.yml` has no
  `dependencies`).
- `info.yml` `configure` points at route `acsf_module_listing.modules_usage.configuration`.

## Global configuration

- Route `acsf_module_listing.modules_usage.configuration` →
  `/admin/config/services/modules-usage/configuration`, form
  `Form\ACSFModulesListingConfigurationForm` (extends `ConfigFormBase`),
  permission **`administer site configuration`**.
- Edits config object **`acsf_module_listing.modules_usage_configuration`**, key
  `configuration.cache_lifetime` (seconds, `#type` number, `#maxlength` 5). **Install default is
  `86400`** (`config/install/acsf_module_listing.modules_usage_configuration.yml`), but the form's
  `#default_value` fallback and README say `3600`. Controls how long search results and per-site
  module lists are cached.
- Schema: `config/schema/acsf_module_listing.schema.yml` defines
  `acsf_module_listing.acsf_environment_entity.*` (the config entity mapping); the simple
  configuration object has no dedicated schema entry.

## The `acsf_environment_entity` config entity

Defined in `src/Entity/AcsfEnvironmentEntity.php` (`@ConfigEntityType`, id `acsf_environment_entity`,
`config_prefix = acsf_environment_entity`, `admin_permission = "administer acsf_environment_entity"`).
Handlers: list builder `AcsfEnvironmentEntityListBuilder` (columns Label / Machine name / SSH URL /
Status), `add`/`edit` form `Form\ACSFEnvironmentEntityForm`, `delete` = core `EntityDeleteForm`.
`config_export` (all persisted, plaintext) — `id`, `label`, `description`, `ssh_user`, `ssh_url`,
`drush_path`, `acsf_username`, `acsf_api_key`, `acsf_env_url`, `public_key_path`, `private_key_path`,
`pass_phrase`.

Fields on the add/edit form (`ACSFEnvironmentEntityForm::form()`):

- `label` + `id` (machine name).
- `ssh_user`, `ssh_url` — SSH gateway user and host (Acquia Cloud).
- `drush_path` — absolute server path where drush is runnable for the target sites.
- `acsf_env_url` — Acquia Cloud API base (e.g. `https://www.dev.acquia.com`); trailing slash is
  stripped by the `removeTrailingSlash()` element validator.
- `acsf_username`, `acsf_api_key` — Acquia Cloud API basic-auth credentials.
- `public_key_path`, `private_key_path` — absolute paths to the SSH key pair. `validateForm()`
  requires both files to exist (`file_exists()`), else sets a form error.
- `pass_phrase` — optional SSH key passphrase.
- `status` (enabled checkbox), `description` (textarea).

Value access is via `Entity\AcsfEntityVariableTrait`: `getVariable($name)` returns `$this->$name`,
`setVariable($name, $value)` sets it (refuses `id`).

### Entity routes (all `_permission: 'administer acsf_environment_entity'`)

| Route | Path |
|---|---|
| `entity.acsf_environment_entity.collection` | `/admin/structure/acsf-environment-entity` |
| `entity.acsf_environment_entity.add_form` | `/admin/structure/acsf_environment_entity/add` |
| `entity.acsf_environment_entity.edit_form` | `/admin/structure/acsf-environment-entity/{acsf_environment_entity}` |
| `entity.acsf_environment_entity.delete_form` | `/admin/structure/acsf-environment-entity/{…}/delete` |

Menu links (`*.links.menu.yml`) add the collection under Configuration -> Web services and Structure;
local tasks (`*.links.task.yml`) add Environment / Global configuration / Search tabs on the
collection; an action link adds "Add ACSF environment entity".

## Permissions

`acsf_module_listing.permissions.yml` declares a single permission **`administer acsf_environment_entity`**
(title "Administer acsf environment entity"). It gates all four entity routes above and is the
entity's `admin_permission`. The search and configuration screens instead use core
**`administer site configuration`**.

## Search & list routes

- `acsf_module_listing.modules_usage.search` → `/admin/config/services/modules-usage/search`, form
  `Form\ACSFModulesListingForm`, `_permission: 'administer site configuration'`. See
  [../api/search-flow.md](../api/search-flow.md).
- `acsf_module_listing.modules_usage.list` → `/admin/config/services/modules-usage/list`,
  `_form: Drupal\acsf_module_listing\Form\ACSFModulesStatisticsForm`, `_permission:
  'administer site configuration'`. **That form class is not present in `src/` — this route is broken
  as shipped.**

All admin routes set `_admin_route: TRUE` (except the entity routes, which don't but live under
`/admin`).
