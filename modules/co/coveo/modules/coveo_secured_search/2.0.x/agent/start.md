<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo Secured Search (coveo_secured_search) — agent index

Submodule of **Coveo** adding **secured search**: Coveo-side custom security providers, Drupal→Coveo
identity mapping, and identity push. Depends on `coveo` **and `coveo_search_api`**
(`coveo_secured_search.info.yml`). Package Search. Core `^10 || ^11`. No permissions of its own (admin
routes reuse base `administer coveo search`). Provides config schema.

- **Config entity, plugin type, providers, identity backend** → [security/secured-search.md](security/secured-search.md)

## What it provides

- **Config entity** `coveo_custom_security_provider` — `src/Entity/CoveoCustomSecurityProvider.php`
  (`config_prefix: custom_security_provider`, `admin_permission: administer coveo search`). Exported
  keys: `name`, `label`, `coveo_name`, `description`, `security_provider` (plugin id),
  `organization_name`, `push_sources[]`. Schema `config/schema/coveo_secured_search.schema.yml`. Forms
  in `src/Form/SecurityProviders/`, storage `SecurityProviderStorage`.
- **Plugin type** `coveo_custom_security_provider` — manager
  `plugin.manager.coveo_custom_security_provider` (`CoveoCustomSecurityProviderManager`), attribute
  `Drupal\coveo_secured_search\Attribute\CoveoCustomSecurityProvider` (+ legacy annotation). Plugins in
  `src/Plugin/Coveo/CustomSecurityProvider/`.
- **Providers**:
  - `DrupalProvider` (`drupal_provider`) — extends base `AbstractSecuredUserProvider`; `getName()` = the
    Drupal user id; resolves identities from Search API item ids.
  - `CustomProvider` (`custom_provider`, base `coveo` security-provider plugin, deriver
    `CustomSecurityProviderDeriver`) — one derivative per `coveo_custom_security_provider` entity;
    delegates `generateToken()`/`getIdentityProviderId()` to that entity's configured plugin.
- **Search API backend** `coveo_identity` — `src/Plugin/search_api/backend/CoveoIdentityBackend.php`
  (`@SearchApiBackend`). Indexes **identities** (item id = identity; fields ignored) to Coveo via the
  Push API `SecurityIdentityApi`.
- **Events** `src/Event/`: `CoveoIdentitiesAlter`, `CoveoSecurityProviderAlter`.

## Routes (`coveo_secured_search.routing.yml`)

Custom-provider collection/add/edit/delete under `/admin/config/search/coveo/security_providers/custom`,
all requiring `administer coveo search`.

## How it fits

Content is pushed by `coveo_search_api`; identities are pushed by the `coveo_identity` backend; a search
component using the `custom_provider`/`Drupal Provider` mints a per-user token scoped to the user's Coveo
identity, so Coveo returns only permitted results.
