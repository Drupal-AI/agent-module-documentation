<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Cloudflare

Config object **`cloudflare.settings`**. UI is a CTools **wizard** at
`/admin/config/services/cloudflare` (route `cloudflare.admin_settings_form`, permission
`administer cloudflare`). Programmatic access via the config factory is straightforward.

## Config keys

```yaml
auth_using: 'token'              # 'token' or 'key' — which auth method to use
api_token: ''                    # used when auth_using = token (sent as Authorization: Bearer)
apikey: ''                       # used when auth_using = key (sent as X-Auth-Key)
email: ''                        # used when auth_using = key (sent as X-Auth-Email)
valid_credentials: false         # set true once a credential check passes
zones: {}                        # Cloudflare zones used by this site (id => name)
client_ip_restore_enabled: false # restore the visitor's real IP from CF headers
remote_addr_validate: true       # only restore when the request IP is a real Cloudflare edge IP
bypass_host: ''                  # origin hostname allowed to bypass Cloudflare (suppresses warnings)
# deprecated (2.0 -> removed in 3.0): zone_id, zone_name
```

## Authentication methods

| `auth_using` | Keys used | HTTP headers sent by `CloudflareApiClient` |
|---|---|---|
| `token` (default) | `api_token` | `Authorization: Bearer <token>` |
| `key` | `apikey` + `email` | `X-Auth-Key: <key>`, `X-Auth-Email: <email>` |

Prefer an **API token** (scoped, revocable). Store the secret in an environment variable / Key
entity, not in committed config.

## Client-IP restoration

Because Cloudflare proxies traffic, `$request->getClientIp()` would otherwise be a Cloudflare
edge IP. With `client_ip_restore_enabled: true`, the middleware rewrites it to the real visitor
from `CF-Connecting-IP` / `CF-Visitor`. `remote_addr_validate: true` first checks the incoming
IP is within Cloudflare's published edge ranges. `bypass_host` names a hostname that reaches the
origin directly (e.g. a health-check host) so it is not flagged as "bypassing Cloudflare".

## Set config in code

```php
$c = \Drupal::configFactory()->getEditable('cloudflare.settings');
// API token auth:
$c->set('auth_using', 'token')->set('api_token', getenv('CLOUDFLARE_API_TOKEN'))->save();
// or API key auth:
$c->set('auth_using', 'key')->set('apikey', getenv('CLOUDFLARE_API_KEY'))
  ->set('email', 'admin@example.com')->save();
// Client IP restore:
$c->set('client_ip_restore_enabled', TRUE)->set('bypass_host', 'origin.example.com')->save();
```

Read: `\Drupal::config('cloudflare.settings')->get('auth_using');` or
`drush config:get cloudflare.settings client_ip_restore_enabled`.

Purging (by tag/URL/everything) is configured in the **cloudflarepurger** submodule and the
Purge module UI — see that submodule's docs.
