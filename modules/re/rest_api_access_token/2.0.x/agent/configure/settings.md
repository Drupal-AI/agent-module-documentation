<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure REST API Access Token

Admin form at `/admin/config/system/rest_api_access_token` (`ConfigForm`, permission `administer rest api access token`). Writes config object `rest_api_access_token.config`. **No `config/install` ships**, so every value defaults to unset/falsy until you save the form — signature verification and caching are OFF by default.

| Key | Form field | Meaning | Default (unset) |
|---|---|---|---|
| `login_by_name` | Login via API by user name | Allow `login` to match username. | (validation requires name and/or mail on save) |
| `login_by_mail` | Login via API by user mail | Allow `login` to match email. | — |
| `signature_verification` | Enable signature verification | Require valid `X-AUTH-SIGNATURE` per request. | off |
| `cache_endpoints` | Enable cache endpoints by REQUEST-ID | Cache responses per user+request-id; requires `REQUEST-ID` header. | off |
| `cache_endpoints_lifetime` | Lifetime of cache endpoints (seconds) | Cache TTL. `0` = permanent, `-1` = disabled. | 0 |
| `token_lifetime_hours` | Lifetime of auth token (hours) | Cron prunes tokens older than this. `0` = infinite. | 0 (infinite) |

Form validation requires at least one of `login_by_name` / `login_by_mail`. `update_8022` sets both to `1` for existing installs.

## Programmatic set
```php
\Drupal::configFactory()->getEditable('rest_api_access_token.config')
  ->set('signature_verification', 1)
  ->set('token_lifetime_hours', 24)
  ->save();
```

## Notes
- `cron` (`rest_api_access_token_cron`) deletes tokens whose `refreshed_at` is older than `token_lifetime_hours` (skipped when `0`).
- With `token_lifetime_hours = 0`, tokens never expire — a leaked token is valid until an explicit logout. Set a finite lifetime for production.
- Consider enabling `signature_verification` so possession of the public token alone is not sufficient.
