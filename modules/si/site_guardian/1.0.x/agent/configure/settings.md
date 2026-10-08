<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure

Config object `site_guardian.settings` (schema `config/schema/site_guardian.schema.yml`). Form at
`/admin/config/development/site_guardian` (route `site_guardian.form`, permission
`administer site configuration`).

| Key | Type | Meaning |
|---|---|---|
| `site_guardian_key` | string | The access key required (as `?site_guardian_key=`) to hit the JSON endpoints. Auto-generated on install (`Crypt::randomBytesBase64(55)`). Required, cannot be blank; a "Generate new key" button rotates it. |
| `site_guardian_activated` | integer(bool) | Master switch. Defaults TRUE on install. When FALSE, endpoints return 403 regardless of key. |
| `site_guardian_notes` | string | Free-text notes exposed to consumers and shown as an INFO requirement in the local Status report. |

## Access model (endpoints)

`SiteGuardianController::access()` → `SiteGuardianService::accessAllowed($key)`:
1. Module must be activated (else warn + forbidden).
2. Stored key non-empty, provided key non-empty, and `hash_equals($provided, $stored)` — else warn +
   forbidden.
3. On failure, register a flood event (`site_guardian_check_attempt`, 10/hour); when tripped, log the
   client IP as a possible attacker. On success, clear the flood counter.

No route-level `_auth`/login is enforced for authorization — the random key is the sole credential, so
transmit it only over HTTPS.

## Admin routes

| Route | Path | Permission |
|---|---|---|
| `site_guardian.form` | `/admin/config/development/site_guardian` | `administer site configuration` |
| `site_guardian.endpoints` | `.../site_guardian/endpoints` | `administer site configuration` |

The endpoints page (`SiteGuardianEndpointsController::endpoints`) reads routes named
`site_guardian.endpoint.*` from `{router}` and renders links with the current key pre-filled.

## Config export note

`site_guardian_key` is included in config exports like any config value. To keep it out, override it
in `settings.php` (`$config['site_guardian.settings']['site_guardian_key']`) or use Config Ignore —
this is a deployment choice, not a module flaw.

## Install behaviour

`site_guardian_install()` sets a fresh random key + `activated = TRUE`. Uninstalling and re-enabling
generates a brand-new key (old consumers must be updated).
