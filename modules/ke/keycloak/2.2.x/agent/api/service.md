<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin, service, subscribers & routes

## OpenID Connect client plugin

`Drupal\keycloak\Plugin\OpenIDConnectClient\Keycloak` (id `keycloak`, label "Keycloak"),
extends `openid_connect`'s `OpenIDConnectClientBase` and uses `KeycloakRoleMatcherTrait`.
Notable methods: `defaultConfiguration()`, `buildConfigurationForm()`, `getEndpoints()`
(derives URLs from base+realm), `authorize()`, `retrieveTokens()`, `retrieveUserInfo()`,
and role/i18n handling. This is not a plugin *type* the module defines — it is an
implementation of the plugin type `openid_connect_client` owned by `openid_connect`.

## Service

`keycloak.keycloak` → `Drupal\keycloak\Service\KeycloakService`
(`KeycloakServiceInterface`). Injected: `config.factory`,
`plugin.manager.openid_connect_client`, `language_manager`, `current_user`,
`tempstore.private`, `logger.factory`. Ask it whether SSO/sign-out/i18n/groups are active,
build locale mappings, and resolve the active Keycloak client. Fetch with
`\Drupal::service('keycloak.keycloak')`.

## Event subscribers

- `keycloak.route_subscriber` (`KeycloakRouteSubscriber`) — alters the user login/logout
  routes to drive the SSO redirect when `keycloak_sso` is enabled.
- `keycloak.request_subscriber` (`KeycloakRequestSubscriber`) — injects locale params and
  handles ISS-initiated SSO / language forwarding on incoming requests.

## Routes

| route | path | purpose |
|---|---|---|
| `keycloak.login` | `/keycloak/login` | login entry (user login form, SSO redirect target) |
| `keycloak.logout` | `/keycloak/logout` | logout controller (`KeycloakController::logout`) |

## JS

`keycloak-session.js` (library) polls the Keycloak session iframe on the
`check_session.interval` to detect a remote logout.

## No hooks / no Drush / no plugin types

The module invites no `hook_*` of its own, ships no Drush commands, and defines no plugin
manager. Programmatic configuration = create/update an `openid_connect_client` entity with
`plugin: keycloak` (see [../configure/client.md](../configure/client.md)).
