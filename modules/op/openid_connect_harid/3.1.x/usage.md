<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenID Connect HarID is a thin client plugin for the OpenID Connect module that lets Drupal users log in via HarID (harid.ee), the Estonian identity federation, including optional requirements for a strong (ID-card / Mobile-ID / Smart-ID) session and a personal code.

---

The module adds one `OpenIDConnectClient` plugin, `harid`
(`Plugin/OpenIDConnectClient/OpenIDConnectHarIDClient`, extends `OpenIDConnectClientBase` from
`openid_connect` v3). It only defines the HarID endpoints (authorization `/authorizations/new`, token
`/access_tokens`, userinfo `/user_info`) against either `https://harid.ee/et` or the test IdP
`https://test.harid.ee/et` (toggle `use_test_idp`), the requested scopes (base
`openid profile email roles`, plus `session_type` and/or `personal_code` when the matching requirement
is on), and three extra config flags on top of the standard client id/secret. **All the OAuth2/OIDC
security machinery — redirect_uri, `state`, `nonce`, the authorization-code exchange and token
handling — lives in the parent `openid_connect` module, not here.** Two hooks add HarID behaviour:
`hook_openid_connect_pre_authorize` blocks login when `require_strong_session` is set but the session is
not strong, or when `require_personal_code` is set but the user has none; `hook_openid_connect_post_authorize`
sets the Drupal user's language from the IdP's `ui_locales` when it matches an enabled language. The
client is configured entirely through the OpenID Connect admin UI
(`/admin/config/people/openid-connect/add/harid`); this module provides no route or permission of its
own (`configure` is null). Config schema `openid_connect.client.plugin.harid` adds
`require_strong_session`, `require_personal_code`, `use_test_idp` to the base client settings.

---

- Let users log into Drupal with their HarID (Estonian) account.
- Add HarID as an SSO option alongside other OpenID Connect clients.
- Require a strong session (ID-card / Mobile-ID / Smart-ID) for HarID logins.
- Require that the HarID account has a personal code before allowing login.
- Point the client at the HarID **test** IdP for development, then switch to live.
- Automatically set a user's Drupal language from HarID's `ui_locales` on each login.
- Request the `roles` scope from HarID for future role mapping.
- Provide compliant authentication for Estonian education/research sites federated via HarID.
- Reuse the OpenID Connect module's account-mapping/registration flow with HarID as the provider.
- Restrict access to real, identity-verified persons via the strong-session requirement.
- Toggle strong-session / personal-code requirements per environment via client config.
- Configure the HarID client id/secret and redirect URL through the OpenID Connect UI.
- Keep the client secret out of code (entered in the OpenID Connect client config).
- Stand up a HarID login button using the OpenID Connect login block.
- Add the `session_type` scope automatically when strong session is required.
- Add the `personal_code` scope automatically when a personal code is required.
- Map HarID users to Drupal accounts via OpenID Connect's account-matching settings.
- Switch a client from test to live HarID with a single config toggle.
- Register the client's redirect URL with HarID from the client creation page.
