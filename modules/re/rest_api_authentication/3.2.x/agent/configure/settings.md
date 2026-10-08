<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Everything is stored in the **`rest_api_authentication.settings`** config object. There is no
plain settings form beyond the miniOrange admin UI; you can read/write the config directly.

## Admin routes (all require core `administer site configuration`)

| Route | Path | Purpose |
|---|---|---|
| `rest_api_authentication.auth_settings` (the `configure` link) | `/admin/config/people/rest_api_authentication/auth_settings` | main API-auth settings (`MiniOrangeAPIAuth`) |
| `rest_api_authentication.advanced_settings` | `.../advanced-settings` | advanced settings |
| `rest_api_authentication.headless_sso` | `.../headless-sso` | headless SSO (premium) |
| `rest_api_authentication.audit_logs` | `.../audit-logs` | authentication attempt logs |
| `rest_api_authentication.delete_logs_confirm` | `.../delete-logs-confirm` | purge old logs |
| `rest_api_authentication.upgrade_plans` | `.../upgrade-plans` | premium plans |
| `rest_api_authentication.request_api_support` | `.../requestSupport` | miniOrange support modal |
| `rest_api_authentication.request_trial` | `.../requestFreeTrial` | trial request modal |

Non-form endpoints: `rest_api_authentication.token_revoke` at **`/rest_api/revoke`** (public
route, but Basic-Auth-gated / flood-limited / POST-only inside the controller), plus
`delete-application/{app_id}` and `set-default-application/{app_id}` controllers (CSRF-token
protected, `administer site configuration`).

## Config keys (`rest_api_authentication.settings`)

| Key | Type | Meaning |
|---|---|---|
| `enable_authentication` | int (`0`/`1`) | **Master switch.** `1` = the auth provider protects API requests. |
| `authentication_method` | int | legacy single-method selector (see method ids below) |
| `api_token` | string | expected token for the API-key method (compared with `hash_equals`) |
| `custom_header` | string | optional header name the Basic-auth validator reads credentials from |
| `applications` | map | `app_id => { name, authentication_method, credentials…, is_default }` (multi-app; premium for >1) |
| `default_application_id` | string | application used when no `auth-method` header is sent (must be flagged `is_default`) |
| `rest_api_authentication_customer_id` / `_customer_admin_email` / `_customer_admin_token` / `_customer_api_key` / `_license_key` / `_status` | string | miniOrange account / licensing fields (set by registration) |

The config schema (`config/schema/rest_api_authentication.schema.yml`) declares
`enable_authentication`, `authentication_method`, `api_token`, and the six miniOrange
customer/licensing fields; `applications`, `default_application_id`, and `custom_header` are set
at runtime by the admin forms/controllers. The install default
(`config/install/rest_api_authentication.settings.yml`) sets only the miniOrange
customer/licensing fields — `enable_authentication` and `api_token` are unset until configured.

Auth method ids (used in `authentication_method`): `0` basic_auth, `1` api_key, `2` oauth,
`3` jwt, `4` external_oauth.

## Read / write via drush

```bash
drush cget rest_api_authentication.settings
drush cget rest_api_authentication.settings enable_authentication
```

```php
// turn API protection on
\Drupal::configFactory()->getEditable('rest_api_authentication.settings')
  ->set('enable_authentication', 1)
  ->save();

// set the expected API-key token (keep this non-empty and secret)
\Drupal::configFactory()->getEditable('rest_api_authentication.settings')
  ->set('api_token', 'YOUR-SECRET-TOKEN')
  ->save();
```

## What gets protected

With `enable_authentication = 1`, the provider `applies()` to requests whose routed path contains
`/jsonapi/` or that carry a `_format` query parameter (the JSON:API admin path
`/admin/config/services/jsonapi/` is excluded, and `/user/login` is always allowed through).
Normal HTML page requests are untouched. See [../api/auth-provider.md](../api/auth-provider.md)
for the request flow and credential validation.
