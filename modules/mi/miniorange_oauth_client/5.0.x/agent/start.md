# miniOrange OAuth Client — agent index

Makes Drupal an OAuth2 / OpenID Connect **client (relying party)** for SSO against an external IdP.
Each IdP connection is a `mo_client_config` config entity. All admin UI lives under
`/admin/config/people/mo-oauth-client/...` and is gated by the single `mo_administrator` permission
(`configure` in info.yml is null — there is no core "Configure" link; entry point is the
*Client Configuration* list at `entity.mo_client_config.collection`). No Drush commands.

Tiering: the free/community build only logs in **existing** users matched by email; auto-provisioning,
non-email login attributes, and role/group mapping require a paid license validated against miniOrange
servers (`MoUnoLicenseTierManager::validateModuleLicense`).

- **Create/configure an IdP connection, endpoints, grant types, protocols, mapping, module settings** →
  [configure/client.md](configure/client.md)
- **The runtime SSO flow (login + callback routes, state validation, token/userinfo, programmatic SSO,
  invited hooks)** → [api/sso-flow.md](api/sso-flow.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes: `mo_oauth.authorization_request` (`/mo-oauth-client/user/login/{mo_client_config}`) and
  `mo_oauth.authorization_response` (`/mo-oauth-client/callback/{mo_client_config}`) are `_access: 'TRUE'`
  (anonymous by design); the callback validates the OAuth `state` against the session before any login.
- Config entities: `mo_client_config` (connection), `mo_client_settings`, `mo_attribute_mapping`,
  `mo_role_mapping`, `mo_group_mapping`, `mo_profile_mapping`, `mo_login_reports`.
- Grant types: `authorization_code`, `authorization_code_with_pkce`, `implicit`, `password`,
  `refresh_token`. Protocols: `OAuth`, `OpenID`.
- Security posture (verified): `state` is generated with `random_bytes` + stored in session and the
  callback rejects any mismatch; the post-login redirect `destination` is carried inside that
  session-bound state and forced under the site's own base URL — see api/sso-flow.md.
