<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LTI Tool Provider (lti_tool_provider) — agent index

Turns Drupal into an **LTI Tool** so a Learning Tools Interoperability platform (an LMS such as
Moodle, Canvas or Blackboard) can launch a user into the site already authenticated, carrying course
context and roles. It ships **two authentication providers** registered as Drupal
`authentication_provider` services: `lti_auth_v1p0` for **LTI 1.0/1.1** (OAuth 1.0a two-legged,
HMAC-SHA1, verified with the PECL `ext-oauth` `\OAuthProvider::checkOAuthRequest()`), and
`lti_auth_v1p3` for **LTI 1.3** (OIDC + signed `id_token`, verified with the `oat-sa/lib-lti1p3-core`
`ToolLaunchValidator`). A launch POST to `/lti` (1.0) or `/lti/v1p3/launch` (1.3) runs the auth
provider, which validates the request, resolves/creates a Drupal user via
`LTIToolProviderBase::provisionUser()`, dispatches the LTI event chain, calls `user_login_finalize()`
and stores the launch data in the session key `lti_tool_provider_context`; the matching launch
controller then reads that session context and redirects the user to the configured destination.

Each remote platform is a **`lti_tool_provider_consumer`** content entity (key/secret for 1.0;
issuer/client-id/deployment-id/JWKS-url/Key-entity keypair for 1.3), managed at
`/admin/config/lti-tool-provider/consumer`. Replay is prevented by a **`lti_tool_provider_nonce`**
content entity (1.0) and the OAT nonce repository (1.3); `hook_cron` purges expired nonces. All
customisation is done through **events** (see the README pattern) rather than hooks.

- Depends on: `drupal:options`, `key:key`. Composer requires PHP `^8.3`, **`ext-oauth`**,
  `drupal/key ^1`, `oat-sa/lib-lti1p3-core ^7`, `oat-sa/lib-lti1p3-deep-linking ^4`.
- Core: `^10.3 || ^11`. Package: `LTI Tool Provider`. Version `3.0.0`.
- Configure route: `lti_tool_provider.admin` (menu hub at `admin/config/lti-tool-provider`).
- Permissions: one — `administer lti_tool_provider module`. No Drush. No plugin types. Provides
  config schema. Defines 3 content entity types (`lti_tool_provider_consumer`,
  `lti_tool_provider_nonce`, and — with the provision submodule — `lti_tool_provider_provision`).
- **Install note:** 3.0.0 requires the PHP **`ext-oauth`** extension or `composer require` fails and
  `hook_requirements` blocks install. In DDEV:
  `ddev config --webimage-extra-packages='php${DDEV_PHP_VERSION}-oauth'`, then `ddev restart`.

## What you'd do → where

- **Register an LMS / configure a consumer (1.0 key+secret, or 1.3 issuer+keys), set the redirect
  destination and iframe embedding** → [configure/consumers.md](configure/consumers.md)
- **Map LTI roles to Drupal roles, LTI attributes to user fields, auto-provision entities, or wire
  content selection (the four submodules)** → [configure/submodules.md](configure/submodules.md)
- **Understand the launch/return flow, the auth providers, entities, nonce & registration repos, and
  the session context object** → [api/authentication.md](api/authentication.md)
- **Look up every route, path, controller, access and `_auth` provider** →
  [api/routes.md](api/routes.md)
- **Alter the launch destination / user provisioning / return via an event subscriber** →
  [events/events.md](events/events.md)
- **Who can administer, and how consumer/provision entity access works** →
  [permissions/permissions.md](permissions/permissions.md)

## Submodules (all in `modules/`, `package: LTI Tool Provider`, depend on `lti_tool_provider`)

- **`lti_tool_provider_roles`** — "LTI Tool Provider Role Mapping". On the `PROVISION_USER` event,
  adds/removes admin-mapped Drupal roles based on the launch's LTI roles. Config
  `lti_tool_provider_roles.settings` (`v1p0_mapped_roles`, `v1p3_mapped_roles`). Forms at
  `/admin/config/lti-tool-provider/roles/v1p0` and `/v1p3`.
- **`lti_tool_provider_attributes`** — "Attributes Mapping". On `PROVISION_USER`, copies LTI
  launch/claim values into admin-mapped Drupal user fields. Config
  `lti_tool_provider_attributes.settings` (`v1p0_mapped_attributes`, `v1p3_mapped_attributes`). Forms
  at `/admin/config/lti-tool-provider/attributes/v1p0` and `/v1p3`.
- **`lti_tool_provider_provision`** — "Entity Provisioning". Creates/loads a default entity
  (node, etc.) per launch context and can redirect to it; adds the `lti_tool_provider_provision`
  entity, `ProvisionService` (`lti_tool_provider_provision.provision`) and an allowed-roles gate.
  Config `lti_tool_provider_provision.settings`. Forms at
  `/admin/config/lti-tool-provider/provision/v1p0` and `/v1p3`.
- **`lti_tool_provider_content`** — "Content Selection". LTI 1.3 Deep Linking: a picker form lets the
  platform select site content to embed. Routes under `/lti/v1p3/content/*`. Config
  `lti_tool_provider_content.settings` (`enabled`, `entity_types`, `entity_bundles`,
  `entity_defaults`, `owner`, `sync`). Admin form at `/admin/config/lti-tool-provider/content`.

## Key facts (real machine names)

- Auth providers (services, tag `authentication_provider`, priority 100):
  `authentication.lti_tool_provider.v1p0` (provider_id `lti_auth_v1p0`,
  `Authentication\Provider\LTIToolProviderV1P0`), `authentication.lti_tool_provider.v1p3`
  (`lti_auth_v1p3`, `LTIToolProviderV1P3`); base `LTIToolProviderBase`.
- Other services: `lti_tool_provider.nonce.repository` (`Services\LTIToolProviderNonceRepository`),
  `lti_tool_provider.registration.repository` (`Services\LTIToolProviderRegistrationRepository`),
  `lti_tool_provider.xframe.event_subscriber` (`EventSubscriber\RemoveXFrameOptionsSubscriber`).
- Parent routes: `lti_tool_provider.v1p0.launch` (`POST /lti`), `lti_tool_provider.v1p0.return`
  (`/lti/return`), `lti_tool_provider.v1p3.login` (`/lti/v1p3/login`), `lti_tool_provider.v1p3.launch`
  (`/lti/v1p3/launch`), `lti_tool_provider.v1p3.return` (`/lti/v1p3/return`),
  `lti_tool_provider.v1p3.jwks` (`/lti/v1p3/jwks`), `lti_tool_provider.admin`,
  `lti_tool_provider.settings` (`/admin/config/lti-tool-provider/settings`), and the
  `entity.lti_tool_provider_consumer.*` / `lti_tool_provider.consumer.add` entity routes.
- Content routes: `lti_tool_provider.content.list` (`/lti/v1p3/content/list`),
  `lti_tool_provider.content.select` (`/lti/v1p3/content/select`), `lti_tool_provider.content.return`
  (`/lti/v1p3/content/return`), `lti_tool_provider.content.launch` (`/lti/v1p3/content/launch`),
  `lti_tool_provider.admin.content`.
- Entities: `lti_tool_provider_consumer` (fields `consumer`, `lti_version` [`v1p0`|`v1p3`],
  `consumer_key`, `consumer_secret`, `platform_id`, `client_id`, `deployment_id`, `key_set_url`,
  `auth_token_url`, `auth_login_url`, `public_key`/`private_key` [key refs], `name`, `mail`,
  `created`); `lti_tool_provider_nonce` (`nonce`, `timestamp`); `lti_tool_provider_provision`.
- Permission: `administer lti_tool_provider module`.
- Config objects: `lti_tool_provider.settings` (`iframe`, `destination`, `v1p0_lti_launch`,
  `v1p3_lti_launch`, `v1p0_lti_roles`, `v1p3_lti_roles`), plus one `*.settings` per submodule.
- Event constants: `LtiToolProviderEvents::{AUTHENTICATED, CREATE_USER, PROVISION_USER, LAUNCH,
  RETURN}` = `lti_tool_provider.{authenticated, create.user, provision.user, launch, return}`; each
  submodule adds its own `*Events` class (see [events/events.md](events/events.md)).
- Session key: `lti_tool_provider_context` → a `LTIToolProviderContext` (implements
  `LTIToolProviderContextInterface`; `getVersion()` returns `V1P0`/`V1P3`).
- Helper: `parse_roles($roles)` in `.module`; nonce lifetimes `LTI_TOOL_PROVIDER_NONCE_INTERVAL`
  (5 min) and `LTI_TOOL_PROVIDER_NONCE_EXPIRY` (1.5 h).
