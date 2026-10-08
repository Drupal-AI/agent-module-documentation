<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Auth0

Two admin forms, both requiring `administer site configuration`, both writing to config object
`auth0.settings`:

- **Basic Settings** — `auth0.settings`, `/admin/config/auth0` (`BasicSettingsForm`).
- **Advanced Settings** — `auth0.advanced_settings`, `/admin/config/auth0/advanced` (`BasicAdvancedForm`).

## Config keys (`auth0.settings`)

| Key | Form | Meaning |
|---|---|---|
| `auth0_domain` | Basic | Auth0 tenant domain (e.g. `your-tenant.eu.auth0.com`). |
| `auth0_client_id` | Basic | Application Client ID. |
| `auth0_client_secret_key` | Basic | **Key entity id** holding the client secret (preferred). |
| `auth0_client_secret` | Basic | Direct client secret (used only if no key id; logs a warning). |
| `auth0_cookie_secret_key` | Basic | Key entity id holding the SDK cookie/session encryption secret. |
| `auth0_cookie_secret` | Basic | Direct cookie secret (fallback; logs a warning). |
| `auth0_requires_verified_email` | Advanced | Require a verified email at Auth0 (default `false`). |
| `auth0_username_claim` | Advanced | Which claim becomes the Drupal username (default `nickname`). |
| `auth0_claim_mapping` | Advanced | Claim→Drupal-field map, one `claim|field` per line. |
| `auth0_sync_claim_mapping` | Advanced | Re-apply claim mapping on every login (default `false`). |
| `auth0_role_mapping` | Advanced | Auth0-role→Drupal-role map, one `auth0_role|drupal_role` per line. |
| `auth0_sync_role_mapping` | Advanced | Re-apply role mapping on every login (default `false`). |
| `auth0_password_reset_enabled` | Advanced | Enable the self-service Auth0 password-reset action (default `false`). |
| `auth0_password_reset_connection` | Advanced | Auth0 DB connection name (default `Username-Password-Authentication`). |

Redirect URI is computed, not stored: `{scheme_host}/auth0/callback` (register this in Auth0).
Default scopes are hardcoded `openid email profile`.

## Key-module integration (secrets)

`ConfigurationService::getClientSecret()` / `getCookieSecret()`:
1. If the corresponding `*_key` config holds a Key id and that Key loads → return `$key->getKeyValue()`.
2. Otherwise return the direct config value; if that direct value is non-empty, log a
   `warning`: "Using … from configuration. Consider using Key module for better security."

So the recommended setup is to store both secrets as Key entities (env or file provider). The
`config/install` defaults ship **empty** — there is no shipped/default secret.

## Mapping syntax

Role mapping (`getRoleMappingRules()`) and claim mapping (`getProfileFieldMappingRules()`) parse
pipe-delimited lines:

```
# role mapping — Auth0 role name | Drupal role machine name
admin|administrator
editor|content_editor

# claim mapping — Auth0 claim | Drupal field machine name
given_name|field_first_name
```

Role sync applies only when `auth0_role_mapping` is set **and** `auth0_sync_role_mapping` is on.
Claim sync applies only when `auth0_claim_mapping` is set **and** `auth0_sync_claim_mapping` is on, and
it skips protected fields (`uid`, `init`, `name`, `uuid`, `pass`, `roles`, `status`).

## Drush

```bash
ddev drush config:set auth0.settings auth0_domain your-tenant.eu.auth0.com -y
ddev drush config:set auth0.settings auth0_client_id XXXX -y
# reference a Key entity for the secret instead of a plaintext value:
ddev drush config:set auth0.settings auth0_client_secret_key auth0_client_secret -y
```
