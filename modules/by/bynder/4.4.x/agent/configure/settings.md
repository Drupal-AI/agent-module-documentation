# Configure Bynder

Config UI: *Configuration → Media → Bynder* (`/admin/config/services/bynder`,
`bynder.configuration_form`, `BynderConfigurationForm`), gated by permission `administer bynder
configuration` (marked `restrict access: TRUE`). All values persist in the `bynder.settings` config
object.

## Credentials & connection

- **Permanent token** (`permanent_token`, required) — a Bynder permanent API token (create at
  `your-domain/pysettings`). Used for global, server-to-server access.
- **Account domain** (`account_domain`, required) — e.g. `name.bynder.com` (trailing slash stripped on save).
- **Client ID / Client secret** (`client_id`, `client_secret`) — an OAuth2 app; needed for user-attributed
  features like upload.
- **OAuth redirect URL** — read-only display of `bynder.oauth` absolute URL; paste it into the Bynder OAuth
  app's "Authorization redirect URIs".
- **Test connection** — AJAX button (and a "Test connection before saving" checkbox, default on) that calls
  `getBrands()` with the entered token/domain; save is blocked on failure unless you uncheck it.
- **Debug** (`debug`, bool) — verbose logging of every API method/args/result to the `bynder` channel.

## Usage restriction metadata (shown only once credentials work)

- **Usage metaproperty** (`usage_metaproperty`) — select which Bynder metaproperty encodes usage rights.
- **Restrictions** (`restrictions.royalty_free`, `.web_license`, `.print_license`) — map each license level
  to a metaproperty option. If unset, assets are treated as royalty-free.

## Metadata & performance

- **Metadata update frequency** (`update_frequency`, default 604800s) — how often cron refreshes local
  media metadata; **Update local metadata** button runs it as a batch immediately.
- **Cache life time** (`cache_lifetime`, default 86400s) — lifetime of cached metaproperties/derivatives/tags.
- **Timeout** (`timeout`, default 10s) — per-request API timeout.
- **Use remote images** (`use_remote_images`, default false) — serve remote thumbnails without local
  download; only enabled if `remote_stream_wrapper` is installed.
- **Bynder image derivatives** — lists `mini`/`webimage`/`thul` plus custom derivatives; **Update cached
  information** re-fetches derivatives/metaproperties/tags from Bynder.

## Full `bynder.settings` keys (schema `config/schema/bynder.schema.yml`)

| Key | Type | Default | Notes |
|---|---|---|---|
| `permanent_token` | string | `''` | Global API token. |
| `client_id` / `client_secret` | string | `''` | OAuth2 app credentials. |
| `account_domain` | string | `''` | `name.bynder.com`. |
| `debug` | bool | `false` | Verbose logging. |
| `usage_metaproperty` | string | `''` | Metaproperty id for usage rights. |
| `restrictions.{royalty_free,web_license,print_license}` | string | `''` | Metaproperty option ids. |
| `cache_lifetime` | int | `86400` | Cache TTL (s). |
| `timeout` | int | `10` | API timeout (s). |
| `update_frequency` | int | `604800` | Metadata sync interval (s). |
| `use_remote_images` | bool | `false` | Needs Remote Stream Wrapper. |

> Credentials are stored in `bynder.settings`. As with any Drupal config, override them per-environment
> via `settings.php` (`$config['bynder.settings']['permanent_token'] = getenv('BYNDER_TOKEN');`).

## Permissions (`bynder.permissions.yml`)

- `administer bynder configuration` — access the config form (**restricted**).
- `view bynder media usage` — access the per-node "Bynder media usage" tab (`bynder.usage`).

## OAuth login flow

Route `bynder.oauth` (`/bynder-oauth`, `no_cache`) drives OAuth2: with no `code` it redirects the user to
Bynder's `/v6/authentication/oauth2/auth`; on return with a `code` it exchanges it for an access token stored
in the session (`finishOAuthTokenRetrieval`). Access to the route is granted to users who can reach an entity
browser page containing a Bynder widget. See [../api/service.md](../api/service.md) for token handling.

## Media type auto-fields

Creating a media type whose source is `bynder` triggers `bynder_media_type_insert()`, which auto-creates the
shared metadata field and a `bynder_transformations` field on `media`. `bynder_cron()` refreshes caches (when
stale) and runs `updateLocalMetadataCron()` each run.
