# OAuth2 Server — agent index

A full OAuth 2.0 / OpenID Connect **authorization server** for Drupal, wrapping
`bshaffer/oauth2-server-php`. Model: **Server** entities → **Scope** entities → **Client** entities;
standard endpoints as routes; tokens/codes stored as content entities; RS256 keys auto-generated and
rotated on cron. Config UI: `/admin/structure/oauth2-servers` (route `oauth2_server.overview`).

- **Servers, scopes, clients: every config-entity field, grant types, lifetimes, redirect_uri/state
  hardening, key rotation, the global `user_sub_property` setting** →
  [configure/servers-clients-scopes.md](configure/servers-clients-scopes.md)
- **Endpoints, the `oauth2` authentication provider, protecting your own routes with
  `Utility::checkAccess()`, storage service, entity types** →
  [api/endpoints-and-access.md](api/endpoints-and-access.md)
- **Permissions (`administer oauth2 server`, `use oauth2 server`) and route access** →
  [permissions/permissions.md](permissions/permissions.md)
- **Hooks: claims, scope access, default scope, pre-authorize** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Routes: `/oauth2/authorize`, `/oauth2/token`, `/oauth2/tokens/{token}`, `/oauth2/UserInfo`,
  `/oauth2/revoke` (perm `use oauth2 server`), `/oauth2/certificates`, `/oauth2/jwk` (`_access: TRUE`).
- Grant types: `authorization_code`, `client_credentials`, `refresh_token`, `password`,
  `urn:ietf:params:oauth:grant-type:jwt-bearer`, `implicit` (per-server, per-client override).
- Entities: `oauth2_server` + `oauth2_server_scope` + `oauth2_server_client` (config entities);
  `oauth2_server_token`, `oauth2_server_authorization_code`, `oauth2_server_jti` (content entities).
- Client secrets stored **hashed** (Drupal password hasher). ID tokens signed **RS256**; keys in
  `state` (`oauth2_server.keys`), rotated ~daily by `oauth2_server_cron()`, published at `/oauth2/jwk`.
- Sensitive OAuth logic (token/code generation, redirect_uri validation, state, PKCE) lives in the
  bshaffer library; this module is the Drupal storage + entities + endpoints wrapper.
