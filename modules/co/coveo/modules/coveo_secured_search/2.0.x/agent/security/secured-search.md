<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo secured search: providers, identities, backend

Enable: `drush en coveo_secured_search` (requires `coveo` + `coveo_search_api`). Admin lives under
`/admin/config/search/coveo/security_providers/custom`. This submodule makes Coveo honor Drupal-style
access on results by (a) modeling Coveo custom security providers as config, (b) mapping Drupal users to
Coveo identities, and (c) pushing those identities to Coveo.

## Config entity `coveo_custom_security_provider`

`src/Entity/CoveoCustomSecurityProvider.php` (`config_prefix: custom_security_provider`,
`admin_permission: administer coveo search`). Exported keys:

- `name`, `label`.
- `coveo_name` — the provider name on the Coveo side.
- `description`.
- `security_provider` — id of the `coveo_custom_security_provider` plugin that resolves identities.
- `organization_name` — linked `coveo_organization`.
- `push_sources` — sequence of push source ids the provider applies to.

The entity `generateToken()` and provider sync build a `SecurityProviderModel` and use the org's
`getSecurityProviderApi()` (base module `SecurityCacheFactory`, authenticated with the push key).
List builder `CustomSecurityProviderListBuilder`, storage `SecurityProviderStorage`, forms in
`src/Form/SecurityProviders/`.

## Plugin type `coveo_custom_security_provider`

- Manager `plugin.manager.coveo_custom_security_provider`
  (`src/Plugin/CoveoCustomSecurityProviderManager.php`, `DefaultPluginManager`).
- Attribute `Attribute\CoveoCustomSecurityProvider` (id/baseName/title/description); legacy annotation
  `Annotation\CoveoCustomSecurityProvider`. Interface
  `CoveoCustomSecurityProviderPluginInterface` (extends the base identity-provider interface; adds
  `getNameFromId()`).
- **`DrupalProvider`** (`drupal_provider`) — `src/Plugin/Coveo/CustomSecurityProvider/DrupalProvider.php`,
  extends the base `AbstractSecuredUserProvider`. `getName($account)` = `(string) $account->id()`;
  `getIdentityProviderId()` = `configuration['provider_id'] ?? 'Default Drupal Provider'`;
  `getNameFromId()` parses a Search API combined id (`entity:user/1:en` → `1`) back to the user id.

## Base security-provider bridge `custom_provider`

`src/Plugin/Coveo/SecurityProvider/CustomProvider.php` — a base-module `coveo_security_provider` plugin
(`custom_provider`, category `custom`) with deriver `CustomSecurityProviderDeriver` producing one
derivative per `coveo_custom_security_provider` entity. It loads that entity and delegates
`generateToken()` / `getIdentityProviderId()` to it, so a `coveo_search_component` can select a custom
provider and mint per-user, identity-scoped Coveo search tokens.

## Identity backend `coveo_identity`

`src/Plugin/search_api/backend/CoveoIdentityBackend.php` (`@SearchApiBackend id="coveo_identity"`).
Its label warns: *"Index identity items in Coveo. IMPORTANT: The Search API item ID will be the
identity and all fields will be ignored."* It pushes identities to Coveo via the Push API
`SecurityIdentityApi` (`Identity`/`IdentityBody`), using the org push key. Point a Search API index of
users at a `coveo_identity` server to populate Coveo's security cache; content indexed with matching
permissions is then filtered per-identity at query time.

## Events

- `CoveoIdentitiesAlter` — adjust the identity set before it is pushed.
- `CoveoSecurityProviderAlter` — adjust a security-provider definition before it is synced to Coveo.

## Operating notes

All admin routes require `administer coveo search` (`restrict access: true`). Content indexing
(`coveo_search_api`) and identity indexing (`coveo_identity`) must both run for filtering to work; the
Coveo push source must be created with "Same users and groups as in your current permissions system"
(see the base README).
