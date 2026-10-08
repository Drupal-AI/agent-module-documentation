# Permissions

Defined in `simple_oauth.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer simple_oauth entities` | The settings form and Access Token admin (create/list/delete tokens, key generation, OIDC settings). |
| `add simple_oauth entities` | Create Access Token entities. |
| `view own simple_oauth entities` | View one's own Access Token entities. |
| `update own simple_oauth entities` | Edit one's own Access Token entities. |
| `delete own simple_oauth entities` | Delete one's own Access Token entities. |
| `debug simple_oauth tokens` | Access `/oauth/debug` (extended token info). Restricted. |
| `grant simple_oauth codes` | Use the AuthCode grant. |
| `view oauth2 scopes` | View OAuth2 scopes (dynamic + static listings). |
| `add oauth2 scopes` | Create dynamic OAuth2 scopes. |
| `edit oauth2 scopes` | Edit dynamic OAuth2 scopes. |
| `delete oauth scopes` | Delete dynamic OAuth2 scopes. |
| `administer oauth2 scopes` | Manage OAuth2 scopes. Restricted. |

`administer simple_oauth entities` and the scope permissions are trusted/admin-level — grant
only to site administrators. What an authenticated *token* can do is governed by its granted
**scopes** (mapped to permissions/roles), not by these UI permissions.
