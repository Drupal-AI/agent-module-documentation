# openid_connect — agent start

Pluggable OpenID Connect / OAuth 2.0 **client** (relying party): external identity providers
(Google, Okta, GitHub, Facebook, LinkedIn, or any generic OIDC server) authenticate and log in
Drupal users. Each provider is an `openid_connect_client` **config entity** referencing a client
**plugin**. Depends on core `file` and contrib `externalauth`. **3.0.x is alpha** (`3.0.0-alpha8`).
Config UI: **Admin → Config → People → OpenID Connect clients** (`/admin/config/people/openid-connect`);
`configure` route `entity.openid_connect_client.list`; global settings route `openid_connect.admin_settings`.

- Add a new identity-provider (OIDC client) plugin → [plugins/openid_connect.md](plugins/openid_connect.md)
- Configure a client + global settings, claim & role mappings → [configure/openid_connect.md](configure/openid_connect.md)
- Login/claims flow, services, and extension hooks → [api/openid_connect.md](api/openid_connect.md)
- Permissions → [permissions/openid_connect.md](permissions/openid_connect.md)
