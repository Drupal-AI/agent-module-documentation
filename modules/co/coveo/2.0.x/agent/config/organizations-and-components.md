<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo config entities, routes & permissions

Base module `coveo`. Enable with `drush en coveo`. All admin lives under
**`/admin/config/search/coveo`** (`coveo.links.menu.yml` → parent `system.admin_config_search`).

## Permissions (`coveo.permissions.yml`)

- `administer coveo search` (`restrict access: true`) — every `/admin/config/search/coveo/**` route,
  and the `admin_permission` of both config entities.
- `access coveo search` — the `/coveo/refresh` token route only.

## Config entity: `coveo_organization`

`src/Entity/CoveoOrganization.php` (`config_prefix: organization`, schema
`config/schema/coveo.organization.schema.yml`). Form `src/Form/Organization/CoveoOrganizationForm.php`.
Exported/config keys:

- `name` (machine id), `label`.
- `organization_id` — the Coveo organization ID to target (required).
- `read_only` (bool) — when true, disables anything that would push to Coveo.
- `auto_sync` (bool) — sync field definitions to Coveo during save operations.
- `prefix` — environment prefix for namespacing fields/elements (dev/test sub-environments).
- `push_source_id` — Coveo Push source id used by some API calls.
- `push_key` — the Push API key. Entered via a `#type => 'password'` field; on edit an empty
  submission keeps the stored value (`validateForm()` restores `#previous_value`). Stored as a plain
  string property on the config entity (`getPushKey()`); no Key/env indirection.

The entity is the API entry point: `pushApiCreate()`, `fieldApiCreate()`, `securityCacheCreate()` and
`getSecurityProviderApi()` all build a `neclimdul/coveo-*` client through
`coveo.org_api_helper` (`OrganizationApiHelper`) using `getPushKey()`. `getIndexHelper()` returns a
`src/Coveo/Index.php` for pushing. `sync()` dispatches `CoveoOrganizationSync`.

### Organization routes (`coveo.routing.yml`)

- `entity.coveo_organization.collection` `/…/organization` (list).
- `coveo.coveo_organization_add` `/…/organization/add`.
- `entity.coveo_organization.view` `/…/organization/manage/{coveo_organization}`
  (`OrganizationOverview::overview` — currently a placeholder `#markup`).
- `entity.coveo_organization.sync` `/…/organization/manage/{coveo_organization}/sync`
  (`Form/Organization/CoveoOrganizationSyncForm`).
- `entity.coveo_organization.edit_form` / `.delete_form`. All require `administer coveo search`
  except delete, which uses `_entity_access: coveo_organization.delete`.

## Config entity: `coveo_search_component`

`src/Entity/CoveoSearchComponent.php` (`config_prefix: search_component`, schema
`config/schema/coveo.search_component.schema.yml`). Form `src/Form/SearchComponents/CoveoSearchComponentForm.php`.
Exported keys:

- `name`, `label`.
- `search_key` — Coveo search access key used to mint per-user search tokens (password field, same
  keep-on-empty behavior as the org form).
- `organization_name` — machine id of the linked `coveo_organization` (added as a config dependency in
  `calculateDependencies()`).
- `security_provider` — id of the chosen `coveo_security_provider` plugin.

Key methods: `getSearchApi()` builds a `SearchV2Api` via `coveo.rest.search_api_factory` using
`searchKey()`; `getSecurityProvider()` loads the plugin; `getToken(Request, AccountInterface)`
delegates to the provider's `generateToken()` (see plugins/security-providers.md).

### Search-component routes

- `entity.coveo_search_component.collection` `/…/search_components`.
- `coveo.coveo_search_component_add` `/…/search_components/add`.
- `entity.coveo_search_component.edit_form` `/…/search_components/manage/{…}`.
- `entity.coveo_search_component.delete_form` (`_entity_access: coveo_search_component.delete`).
- Overview `coveo.coveo_overview` `/admin/config/search/coveo` and `coveo.security_providers`
  `/…/security_providers` (`SecurityProviders::overview`). All `administer coveo search`.

## Setup order (from README)

1. In Coveo: create a Push source, a Push API key (custom privileges), and a Search-pages API key.
2. Drupal: add a `coveo_organization` with the organization ID, push source ID and push key.
3. Add a Search API server of type `coveo` (search-api submodule) with the search/query key.
4. Create indexes; name one field `coveo_data`, one `coveo_title`, others `coveo_*` to map to Coveo
   fields. Then index as normal.
