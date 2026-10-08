<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login.gov OpenID Connect (login_gov) — agent index

Provides a single **OpenID Connect client plugin** (id `login_gov`, label "Login.Gov") for the
`openid_connect` module so a Drupal site can authenticate the public through the US government's
Login.gov identity provider. The whole module is one plugin class,
`Drupal\login_gov\Plugin\OpenIDConnectClient\OpenIDConnectLoginGovClient`, which extends
`OpenIDConnectClientBase`; it has **no routes, services, permissions, drush commands or forms of its
own** — it configures itself through openid_connect's client-entity form and rides openid_connect's
redirect/callback controller and login flow. What the plugin actually overrides: the authorize/token/
userinfo/logout/certs **endpoints** (a sandbox pair and a production pair), the **client
authentication** (Login.gov requires **private-key JWT** — a signed `client_assertion` rather than a
shared `client_secret`), the **`acr_values`** it requests (built from the configured IAL and AAL
levels), a per-request **`nonce`**, the **scopes** (derived from the selected user fields), and the
logout redirect query.

Because Login.gov uses private-key JWT, the module depends on `key_asymmetric` and stores the RSA
private key in a **Key entity** (`key_select`, filtered to `asymmetric_private`); the public half is
registered with Login.gov. On the callback the plugin fetches Login.gov's JWKS from the `/certs`
endpoint and **verifies the returned `id_token`'s signature** (`firebase/php-jwt` `JWT::decode`)
before honoring it. Login CSRF (the `state` round-trip) and the actual account creation/login are
handled by the parent `openid_connect` module, not here.

- Depends on: `openid_connect:openid_connect (>=3.0)`, `key_asymmetric:key_asymmetric (>=1.2.0)`.
  Library: `firebase/php-jwt (^6.11)`.
- Core: `^10 || ^11`. Package: `User authentication`. Version `2.0.0`.
- **No dedicated settings page / `configure` route.** Configuration lives on the openid_connect
  client entity at `/admin/config/people/openid-connect` (choose plugin "Login.Gov"). Provides config
  schema. No permissions, no drush, no services, no plugin types.
- Two update hooks: `login_gov_update_9001` (migrate an inline `private_key` string into a Key
  entity) and `login_gov_update_10001` (convert the old `acr_level`/`require_piv`/`verified_within`
  settings into the new `ial_level` + `aal_level`).

## What you'd do → where

- **Create/configure the Login.gov client — key setup, client ID/issuer, sandbox vs production, IAL &
  AAL levels, which user fields/scopes** → [configure/client.md](configure/client.md)
- **Understand the plugin internals — endpoints, private-key-JWT client assertion, acr_values, nonce
  & id_token verification, scope mapping, logout, update hooks — or subclass/debug it** →
  [api/plugin.md](api/plugin.md)

## Key facts (real machine names)

- Plugin: `@OpenIDConnectClient` id **`login_gov`**, label "Login.Gov", class
  `Drupal\login_gov\Plugin\OpenIDConnectClient\OpenIDConnectLoginGovClient` (extends
  `Drupal\openid_connect\Plugin\OpenIDConnectClientBase`).
- Exception: `Drupal\login_gov\Exception\LoginGovConfigException` (thrown by `generateAcrValue()` on a
  bad IAL/AAL combination).
- Config schema type: **`openid_connect.client.plugin.login_gov`**. Settings keys:
  `client_id`, `sandbox_mode` (bool, default TRUE), `ial_level` (default `verified`),
  `aal_level` (default `phishing_resistant`), `userinfo_fields` (sequence of strings),
  `key_private_key` (Key entity id). Legacy/removed keys still read for fallback/migration:
  `private_key`, `acr_level`, `require_piv`, `verified_within*`, `force_reauth`.
- `ial_level` options: `auth-only`, `verified`, `verified-facial-match-preferred`,
  `verified-facial-match-required`.
- `aal_level` options: `duo`, `separate`, `phishing_resistant`, `require_hspd12`.
- Endpoints (sandbox `idp.int.identitysandbox.gov` / production `secure.login.gov`):
  `authorization`, `token`, `userinfo`, `end_session`, `certs`.
- Update hooks: `login_gov_update_9001`, `login_gov_update_10001` (both operate on
  `openid_connect_client` config entities with `plugin == login_gov`).
- Config entity host route (parent module): `/admin/config/people/openid-connect`
  (`openid_connect.admin_settings`); callback route `openid_connect.redirect_controller_redirect`.
