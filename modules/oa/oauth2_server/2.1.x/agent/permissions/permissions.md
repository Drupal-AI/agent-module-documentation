# Permissions

Two permissions (`oauth2_server.permissions.yml`), neither marked `restrict access: true`:

| Permission | Gates |
|---|---|
| `administer oauth2 server` | Full management of Server, Scope and Client config entities (all `/admin/structure/oauth2-servers/*` routes) and is the entities' `admin_permission`. Effectively controls who can mint OAuth clients/secrets and their grant types — treat as a trusted, admin-level permission. |
| `use oauth2 server` | Required to reach the OAuth endpoints `/oauth2/authorize`, `/oauth2/token`, `/oauth2/tokens/{token}`, `/oauth2/UserInfo`, `/oauth2/revoke`. This is the permission the **end user granting authorization** (and clients hitting the token endpoint over `basic_auth`) must hold. |

Notes:
- `/oauth2/certificates` and `/oauth2/jwk` are intentionally public (`_access: TRUE`) — they expose only the
  public signing key/certificate.
- Because the authorize/token flow needs `use oauth2 server`, grant it to the roles whose users are allowed to
  log into external apps via OAuth (commonly `authenticated user`). Granting it does not by itself let a user
  manage the server.
- The consent screen (`AuthorizeForm`) is a standard Drupal form (CSRF token enforced); it authorizes for the
  currently logged-in user only.
