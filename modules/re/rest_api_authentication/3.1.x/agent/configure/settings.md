<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Everything is stored in the **`rest_api_authentication.settings`** config object. There is no
`configure`-route setting form beyond the miniOrange admin UI; you can read/write the config
directly.

## Admin routes (all require core `administer site configuration`)

| Route | Path | Purpose |
|---|---|---|
| `rest_api_authentication.auth_settings` (the `configure` link) | `/admin/config/people/rest_api_authentication/auth_settings` | main API-auth settings (`MiniOrangeAPIAuth`) |
| `rest_api_authentication.advanced_settings` | `.../advanced-settings` | advanced settings |
| `rest_api_authentication.headless_sso` | `.../headless-sso` | headless SSO (premium) |
| `rest_api_authentication.audit_logs` | `.../audit-logs` | authentication attempt logs |
| `rest_api_authentication.delete_logs_confirm` | `.../delete-logs-confirm` | purge old logs |
| `rest_api_authentication.upgrade_plans` | `.../upgrade-plans` | premium plans |

Non-form endpoints: `rest_api_authentication.token_revoke` at **`/rest_api/revoke`** (public;
validated inside the controller), plus delete/set-default application controllers.

## Config keys (`rest_api_authentication.settings`)

| Key | Type | Meaning |
|---|---|---|
| `enable_authentication` | int (`0`/`1`) | **Master switch.** `1` = the auth provider protects API requests. |
| `authentication_method` | int | legacy single-method selector (see method ids below) |
| `api_token` | string | expected token for the API-key method |
| `applications` | map | `app_id => { name, authentication_method, credentials…, is_default }` (multi-app; premium for >1) |
| `default_application_id` | string | application used when no `auth-method` header is sent |
| `rest_api_authentication_customer_id` / `_customer_admin_email` / `_customer_admin_token` / `_customer_api_key` / `_license_key` / `_status` | string | miniOrange account / licensing fields (set by registration) |

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

// set the expected API-key token
\Drupal::configFactory()->getEditable('rest_api_authentication.settings')
  ->set('api_token', 'YOUR-SECRET-TOKEN')
  ->save();
```

## What gets protected

With `enable_authentication = 1`, the provider `applies()` to requests whose URI contains
`/jsonapi/` or `?_format=` (the JSON:API admin path `/admin/config/services/jsonapi/` is
excluded, and `/user/login` is always allowed through). Normal HTML page requests are
untouched. See [../api/auth-provider.md](../api/auth-provider.md) for the request flow and
credential validation.
