# Permissions

The module defines exactly one permission (`miniorange_oauth_client.permissions.yml`):

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| miniOrange Administrator Privilege | `mo_administrator` | Every admin route under `/admin/config/people/mo-oauth-client/...` (client config, module settings, mapping, import/export, logging, login reports, password-grant test). | `restrict access: true` — treat as an administrative permission and grant it only to trusted roles; it exposes IdP client credentials and the ability to change how everyone authenticates. |

The two SSO runtime routes (`mo_oauth.authorization_request`, `mo_oauth.authorization_response`) and the
domain-validation route are **not** gated by this permission — they use `_access: 'TRUE'` because the IdP
and anonymous users must reach them (the callback validates the OAuth `state` instead). See
[../api/sso-flow.md](../api/sso-flow.md).
