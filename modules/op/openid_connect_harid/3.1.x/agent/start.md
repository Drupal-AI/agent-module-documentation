<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenID Connect HarID — agent index

A `harid` OpenID Connect **client plugin** for the `openid_connect` module (v3): HarID (harid.ee)
login, with optional strong-session and personal-code requirements. Configured through the OpenID
Connect admin UI; no route/permission/`configure` of its own. All state/nonce/redirect/token handling is
in the parent `openid_connect` module.

- **The `harid` client plugin: endpoints, scopes, config flags, and how to configure a client** →
  [plugins/harid_client.md](plugins/harid_client.md)
- **The two behaviour hooks (`pre_authorize` gate, `post_authorize` language)** and config keys →
  [configure/client.md](configure/client.md)

Key facts:
- Plugin id `harid`, class `OpenIDConnectHarIDClient extends OpenIDConnectClientBase`.
- Endpoints from `harid.ee/et` (or `test.harid.ee/et` when `use_test_idp`).
- Base scopes `openid profile email roles`; `+session_type` if `require_strong_session`,
  `+personal_code` if `require_personal_code`.
- Config schema `openid_connect.client.plugin.harid` (adds `require_strong_session`,
  `require_personal_code`, `use_test_idp` to the base client id/secret).
