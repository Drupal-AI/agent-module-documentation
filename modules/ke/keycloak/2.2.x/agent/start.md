<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Keycloak OpenID Connect — agent index

A plugin for the `openid_connect` module: registers an `OpenIDConnectClient` plugin (id
`keycloak`) so Drupal can authenticate against a Keycloak server. You configure a **client
config entity**, not a settings form of its own (`configure` points at OpenID Connect's
`openid_connect.admin_settings`).

- **Create/configure a Keycloak client (config entity, settings keys, endpoints)** →
  [configure/client.md](configure/client.md)
- **SSO, single sign-out, i18n, and group→role mapping options** →
  [configure/features.md](configure/features.md)
- **The `keycloak` plugin, `KeycloakService`, subscribers, routes** →
  [api/service.md](api/service.md)

Key facts:
- Client config entity: `openid_connect.client.<id>` with `plugin: keycloak` and a `settings`
  map. Managed at `/admin/config/people/openid-connect`.
- Endpoints are derived from two settings: `keycloak_base` + `keycloak_realm` →
  `{base}/realms/{realm}/protocol/openid-connect/{auth,token,userinfo,logout}`.
- Needs a real external Keycloak server to actually authenticate; on this site the
  **config/plugin state** is what's inspected and built (no live IdP).
- Routes: `keycloak/login`, `keycloak/logout`. Service: `keycloak.keycloak`.
