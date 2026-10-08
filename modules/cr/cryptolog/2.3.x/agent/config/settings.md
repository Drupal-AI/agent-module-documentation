<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cryptolog settings (`cryptolog.settings`)

Install/enable the module (`ddev drush en cryptolog -y`); no dependencies, nothing to add to
`settings.php`. Configure at **`/admin/config/people/cryptolog`** (route `cryptolog.settings`,
menu link *People → Cryptolog*), which requires the **`administer site configuration`**
permission. Form: `Drupal\cryptolog\ConfigForm` (`src/ConfigForm.php`), extends `ConfigFormBase`,
form id `cryptolog_settings`, editable config `cryptolog.settings`.

## Config object `cryptolog.settings`

Schema `config/schema/cryptolog.schema.yml` (`type: config_object`); install defaults
`config/install/cryptolog.settings.yml`:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `single_webhead` | boolean | `FALSE` | Store the salt **solely in APCu** (never on disk). Only effective if APCu is available. Leave FALSE on multi-node sites so the salt is shared via the default cache backend. |
| `ttl` | integer | `86400` | Salt lifetime in seconds. On expiry the salt regenerates and every IP maps to a new pseudonym. |

Config export example:

```yaml
# cryptolog.settings.yml
single_webhead: false
ttl: 86400
```

## Form fields (`buildForm`)

Salt section (`#type => details`):
- **Storage backend** (`item`) — `get_class()` of the middleware's active cache backend
  (diagnostic, read-only).
- **single_webhead** (`checkbox`, `#config_target 'cryptolog.settings:single_webhead'`).
- **Time remaining** (`item`) — `dateFormatter->formatInterval(salt->expire - requestTime)`.
- **TTL (seconds)** (`number`, `#config_target 'cryptolog.settings:ttl'`) — `#min` is taken from
  `user.flood`: `ip_window` when `uid_only`, else `user_window`. Description shows the default
  (`::TTL`) formatted.
- **Regenerate salt now** (`checkbox`, not persisted) — when checked, `submitForm()` calls
  `getCacheBackend()->invalidate('cryptolog')`, forcing a new salt on the next request.

Diagnostic section:
- **Cryptolog IP address** — `getRequest()->getClientIp()` (the pseudonym).
- **Original IP address** — `cryptologMiddleware->getClientIp()` (pre-hash; only known when the
  middleware ran this request).
- **Trusted reverse proxy** — Disabled / Yes / No, derived from `Settings::get('reverse_proxy')`
  and `isFromTrustedProxy()`.
- **HTTP host** / **Protocol** — shown only if the middleware had to restore them (see
  [../architecture/middleware.md](../architecture/middleware.md)).

## Container invalidation

`ConfigSubscriber::onSave` (`src/ConfigSubscriber.php`) listens on `ConfigEvents::SAVE`; when
`cryptolog.settings` changes `single_webhead` or `ttl`, it calls
`DrupalKernelInterface::invalidateContainer()`. This is required because those two values are
compiled into the middleware's constructor arguments by `CryptologServiceProvider` at
container-build time — the container must rebuild to pick up the new backend/TTL.

## Requirements surfaced

- Install: `CryptologRequirements::getRequirements()` errors if PHP lacks IPv6 support
  (`AF_INET6` / `inet_pton('::1')`).
- Runtime status report (`Hook/RuntimeRequirements`): whether the middleware initialized, which
  hash function is in use (BLAKE2b vs HMAC-MD5), and a **warning** if the salt TTL is shorter than
  the flood-control window (with a link to this settings form).
