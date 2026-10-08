# Configure Microsoft Entra ID SSO

Settings form `SocialAuthEntraIdSettingsForm` (extends `ConfigFormBase`) at
`/admin/config/services/entra-id/settings` (route `social_auth_entra_id.settings`, gated by core
`administer site configuration`). It edits the single config object `social_auth_entra_id.settings`.

## Config keys

| Key | Type | Default | Purpose |
|---|---|---|---|
| `client_id` | string | `''` | Azure "Application (client) ID". Required. |
| `client_secret` | string | `''` | Azure client secret. Form field is `#type => password`; on save an empty submit KEEPS the stored value (only a non-empty value overwrites). |
| `tenant_id` | string | `''` | Azure "Directory (tenant) ID". Required only when `account_type = organization`. |
| `account_type` | string | `organization` | `organization` (single tenant → uses `tenant_id` in the endpoint), `common` (work/school + personal), or `consumers` (personal only). For `common`/`consumers` the literal word is used as the authority path segment instead of a tenant id. |
| `login_behavior` | string | `register_and_login` | `register_and_login` auto-creates a Drupal user on first login; `login_only` only logs in users that already exist. |
| `allowed_domains` | string | `''` | Comma- and/or newline-separated email-domain allowlist. Empty = all domains. Matched case-insensitively against the email-claim domain. |
| `block_user_1` | bool | `true` | Refuse SSO login for user ID 1. |
| `block_admin_role` | bool | `true` | Refuse SSO login for any user holding the `administrator` role. |

The form also shows a read-only **Callback URL (Redirect URI)** field — the absolute URL of route
`social_auth_entra_id.callback` in the site default language — to paste into the Azure app's Redirect URIs.

## settings.php override support

`buildForm()` calls `$this->configFactory->get(...)->hasOverrides($key)` for `client_id`,
`client_secret`, `tenant_id`. If a key is overridden in `settings.php`, its field is disabled with a
warning and `submitForm()` skips writing it (the override wins at runtime). Example:

```php
// settings.php
$config['social_auth_entra_id.settings']['client_id']     = getenv('ENTRA_ID_CLIENT_ID');
$config['social_auth_entra_id.settings']['client_secret'] = getenv('ENTRA_ID_CLIENT_SECRET');
$config['social_auth_entra_id.settings']['tenant_id']     = getenv('ENTRA_ID_TENANT_ID');
```

## Set it with Drush / PHP

```php
$c = \Drupal::configFactory()->getEditable('social_auth_entra_id.settings');
$c->set('client_id', '<app-guid>')
  ->set('tenant_id', '<tenant-guid>')
  ->set('account_type', 'organization')      // or 'common' / 'consumers'
  ->set('login_behavior', 'login_only')      // or 'register_and_login'
  ->set('allowed_domains', 'example.com, company.org')
  ->set('block_user_1', TRUE)
  ->set('block_admin_role', TRUE)
  ->save();
// Secret separately (or via settings.php override):
$c->set('client_secret', '<secret-value>')->save();
```

```bash
ddev drush cset social_auth_entra_id.settings account_type common -y
ddev drush cget social_auth_entra_id.settings
```

## Azure app requirements (mirrored in README)

Register an app in the Azure portal, set the Redirect URI to the callback URL shown on the form
(`…/user/login/entra-id/callback`), create a client secret, and grant delegated Microsoft Graph
scopes `openid profile email User.Read`. Pick the Azure "Supported account types" that matches
`account_type` (single tenant ↔ `organization`, "any org directory and personal" ↔ `common`,
"personal only" ↔ `consumers`).

## Config schema

`config/schema/social_auth_entra_id.schema.yml` defines `social_auth_entra_id.settings` as a
`config_object` with the keys above (`account_type` and `login_behavior` carry `allowed_values`).
`config/install/social_auth_entra_id.settings.yml` ships the defaults. The block plugin has no config
schema; its `login_text` / `custom_class` live in block config.

## Stale service definitions (do not rely on)

`social_auth_entra_id.services.yml` declares `social_auth_entra_id.settings` (class
`Drupal\social_auth_entra_id\SocialAuthEntraIdSettings`) and `social_auth_entra_id.controller` with a
constructor signature that does NOT match the shipped classes — that settings class does not exist in
`src/`, and the controller is instantiated via `ContainerInjectionInterface::create()` (config.factory,
http_client, messenger, language_manager, logger.factory, string_translation), not from this service
definition. Configure through the config object above, not these services.
