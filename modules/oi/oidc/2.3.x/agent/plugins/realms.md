<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — OpenID Connect realms

The module defines one plugin type, **`OpenidConnectRealm`** (one plugin = one identity provider).

| Aspect | Value |
| --- | --- |
| Manager service | `plugin.manager.openid_connect_realm` (`OpenidConnectRealmManager`, extends `DefaultPluginManager`) |
| Annotation | `Drupal\oidc\OpenidConnectRealm\Annotation\OpenidConnectRealm` (`id`, `name`) |
| Discovery dir | `src/Plugin/OpenidConnectRealm/` |
| Interface | `OpenidConnectRealmInterface` (+ `OpenidConnectRealmConfigurableInterface` for UI-configurable ones) |
| Base class | `OpenidConnectRealm\OpenidConnectRealmBase` |
| Alter hook | `hook_oidc_openid_connect_realm_alter($definitions)` |
| Bundled plugin | `generic` (`GenericOpenidConnectRealm`, configurable + derived) |

## Manager methods (`OpenidConnectRealmManagerInterface`)
- `loadInstance($plugin_id)` — instantiate a realm, hydrating config from `oidc.realm.<...>` for
  configurable plugins (cached per request).
- `getAll($provider = NULL)` / `getConfigurable($provider = NULL)` — list plugin ids (optionally by
  providing module).
- `saveInstance($plugin)` / `deleteInstance($plugin_id)` — persist / remove a configurable realm's
  config object.

## `OpenidConnectRealmInterface` (what a realm must provide)
- `isEnabled()` — whether the realm can be used (base returns TRUE).
- `getLoginUrl($state, Url $redirect_url)` — build the authorization-endpoint URL.
- `getJsonWebTokensForLogin($state, $code)` — exchange the auth code at the token endpoint → `JsonWebTokens`.
- `getJsonWebTokensforRefresh(Token $refresh_token)` — refresh-token grant → `JsonWebTokens`.
- `getLogoutUrl(Token $id_token, $state, Url $redirect_url)` — RP-initiated logout URL (or the redirect
  URL itself when there is no `end_session_endpoint`).
- `updateJwks()` / `clearJwks()` — sync/clear the provider's signing keys (also run from `hook_cron`).
- `getDisplayNameFormat()` — token pattern for the display name.

`OpenidConnectRealmBase` implements all HTTP/JWT plumbing (token exchange with Basic auth, ID-token
validation against the JWKS, userinfo fetch, JWKS storage in key-value `oidc.jwks.<plugin_id>`). It
leaves abstract only the provider specifics: `getClientId()`, `getClientSecret()`, `getScopes()`,
`getIssuer()`, `getAuthorizationEndpoint()`, `getTokenEndpoint()`, `getJwksUrl()`, and the optional
`getUserinfoEndpoint()` / `getEndSessionEndpoint()`.

## Writing your own realm (hard-coded provider)

For a fixed provider you do not need config forms or a deriver — extend the base and return your
endpoints. Minimal example:

```php
namespace Drupal\my_module\Plugin\OpenidConnectRealm;

use Drupal\oidc\OpenidConnectRealm\OpenidConnectRealmBase;

/**
 * @OpenidConnectRealm(
 *   id = "acme",
 *   name = @Translation("Acme")
 * )
 */
class AcmeRealm extends OpenidConnectRealmBase {
  protected function getClientId() { return 'my-client-id'; }
  protected function getClientSecret() { return \Drupal::service('key.repository')->getKey('acme')->getKeyValue(); }
  protected function getScopes() { return ['profile', 'email']; }
  protected function getIssuer() { return 'https://acme.example.com/'; }
  protected function getAuthorizationEndpoint() { return 'https://acme.example.com/authorize'; }
  protected function getTokenEndpoint() { return 'https://acme.example.com/token'; }
  protected function getJwksUrl() { return 'https://acme.example.com/jwks'; }
  protected function getUserinfoEndpoint() { return 'https://acme.example.com/userinfo'; } // optional
  protected function getEndSessionEndpoint() { return 'https://acme.example.com/logout'; } // optional
  public function getDisplayNameFormat() { return '[user:given-name] [user:family-name]'; }
}
```

Its login path becomes `/oidc/login/acme`. Set the claim names by overriding `getJsonWebTokens()` and
calling the `JsonWebTokens::set*Claim()` setters (as `GenericOpenidConnectRealm` does), or accept the
`JsonWebTokens` defaults (`sub` / `preferred_username` / `email` / `given_name` / `family_name`).

To make it configurable in the admin UI, implement `OpenidConnectRealmConfigurableInterface`
(`buildConfigurationForm`/`validateConfigurationForm`/`submitConfigurationForm` +
`getConfiguration`/`setConfiguration`/`defaultConfiguration`) — see `GenericOpenidConnectRealm`.

## How `generic` is derived
`GenericOpenidConnectRealmDeriver` reads `oidc.settings:generic_realms` and produces one derivative
`generic:<id>` per entry, wiring `config_dependencies` to `oidc.settings` and the realm's config
object. That is why generic realms are created by editing that list (see configure/realms.md), not by
adding annotations.
