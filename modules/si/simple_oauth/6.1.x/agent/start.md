# simple_oauth — agent start

OAuth 2.0 + OpenID Connect authorization server. Issues bearer tokens for API/decoupled auth.
Requires `consumers` (each client = a consumer) + `league/oauth2-server`. Settings UI:
**Admin → Config → People → Simple OAuth** (`/admin/config/people/simple_oauth`, route
`oauth2_token.settings`). Endpoints: `/oauth/token`, `/oauth/authorize`, `/oauth/userinfo`,
`/oauth/jwks`, `/oauth/debug`.

- Settings, signing keys, scope provider, token expiry → [configure/settings.md](configure/settings.md)
- Scopes: dynamic entities + granularity (permission/role) → [configure/scopes.md](configure/scopes.md)
- Authenticate requests / endpoints / token entity → [api/authentication.md](api/authentication.md)
- Plugin types it defines (grants, scope providers, granularity) → [plugins/plugin-types.md](plugins/plugin-types.md)
- Inject custom JWT/OIDC claims (hooks) → [hooks/hooks.md](hooks/hooks.md)
- Generate keys via Drush → [drush/commands.md](drush/commands.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
