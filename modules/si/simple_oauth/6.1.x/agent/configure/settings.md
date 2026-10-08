# Settings & signing keys

Config object `simple_oauth.settings` (schema `config/schema/simple_oauth.schema.yml`). UI at
`/admin/config/people/simple_oauth` (route `oauth2_token.settings`, permission
`administer simple_oauth entities`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `public_key` | path | – | Filesystem path to the RSA public key (verify tokens). |
| `private_key` | path | – | Filesystem path to the RSA private key (sign tokens). Store OUTSIDE docroot. |
| `scope_provider` | string | `dynamic` | Active scope provider plugin id (`dynamic`, or `static` with the static-scope submodule). |
| `token_cron_batch_size` | int | `0` | Expired tokens deleted per cron run (`0` = no limit). |
| `disable_openid_connect` | bool | `false` | If TRUE, disables the OpenID Connect layer. |

Deprecated keys (moved to base fields on the **consumer** entity — set these per client, not
globally now): `access_token_expiration`, `authorization_code_expiration`,
`refresh_token_expiration`, `remember_clients`, `use_implicit`.

## Generating keys
- UI: the settings form has a "Generate keys" action (route
  `oauth2_token.settings.generate_key`), backed by `simple_oauth.key.generator`.
- Drush: `drush simple-oauth:generate-keys /path/to/dir` (see [../drush/commands.md](../drush/commands.md)).
- Manual: `openssl genrsa -out private.key 2048 && openssl rsa -in private.key -pubout > public.key`.

## How a client is set up
1. Configure key paths here. 2. Create scopes (see [scopes.md](scopes.md)). 3. Create a
**Consumer** (`/admin/config/services/consumer/add`) enabling the desired grant types and
scopes. 4. Clients request tokens at `POST /oauth/token`. OpenID Connect settings have their
own form at `/admin/config/people/simple_oauth/openid-connect`.
