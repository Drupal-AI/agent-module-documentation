<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `harid` OpenID Connect client plugin

- Class `Plugin/OpenIDConnectClient/OpenIDConnectHarIDClient` (`@OpenIDConnectClient(id="harid")`),
  extends `Drupal\openid_connect\Plugin\OpenIDConnectClientBase`. It is an implementation of the
  **openid_connect** module's client plugin type — this module defines no plugin type itself.

## What the plugin overrides
- `getEndpoints()` — returns HarID URLs built from `getBaseUrl()`:
  - authorization: `<base>/authorizations/new`
  - token: `<base>/access_tokens`
  - userinfo: `<base>/user_info`
  - `<base>` = `https://harid.ee/et`, or `https://test.harid.ee/et` when `use_test_idp` is TRUE.
- `getClientScopes()` — `['openid','profile','email','roles']`, plus `session_type` when
  `require_strong_session`, plus `personal_code` when `require_personal_code`.
- `defaultConfiguration()` / `buildConfigurationForm()` — adds three checkboxes
  (`require_strong_session`, `require_personal_code`, `use_test_idp`) on top of the base client id /
  secret / redirect fields, and a link to HarID dev docs.

## Configure a client
No route in this module — use the OpenID Connect UI:
1. `/admin/config/people/openid-connect` → add client → choose **HarID**
   (`/admin/config/people/openid-connect/add/harid`).
2. Enter the Client ID / Client secret issued by HarID; copy the shown **Redirect URL** into your HarID
   service registration (https://harid.ee/en/pages/dev-info).
3. Optionally tick Require strong session / Require personal code / Use test IdP.

## Trust boundary
The redirect_uri, CSRF `state`, `nonce`, code→token exchange, userinfo fetch, and Drupal
account matching/creation are all handled by `openid_connect` (`OpenIDConnectClientBase` +
`openid_connect` services), not by this plugin. This plugin contributes only endpoints, scopes, config
flags, and the two behaviour hooks (see [../configure/client.md](../configure/client.md)).
