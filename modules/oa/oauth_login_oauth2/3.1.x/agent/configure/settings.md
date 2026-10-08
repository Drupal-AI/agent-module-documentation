# Configure miniOrange OAuth Login

Admin UI lives under `admin/config/people/oauth_login_oauth2/…`, all gated by core
`administer site configuration`. Config route (the `configure` link):
`oauth_login_oauth2.config_clc` → *Configure Application* tab.

## Admin tabs / routes

| Route | Path | Purpose |
|---|---|---|
| `oauth_login_oauth2.config_clc` | `/admin/config/people/oauth_login_oauth2/config_clc` | Configure the OAuth application (main form). |
| `oauth_login_oauth2.mapping` | `…/mapping` | Attribute & role mapping (mostly premium). |
| `oauth_login_oauth2.settings` | `…/Settings` | Sign-in settings (base URL / HTTPS callback). |
| `oauth_login_oauth2.troubleshoot` | `…/MoOAuthTroubleshoot` | Troubleshooting / logs. |
| `oauth_login_oauth2.login_reports` | `…/LoginReports` | Login reports (premium). |
| `oauth_login_oauth2.testConfig` | `/testSSO` | Starts a Test Configuration round-trip. |

## Runtime routes (no admin permission)

- `oauth_login_oauth2.moLogin` → `/moLogin` (`_access: TRUE`): initiates SSO. Honors a
  `?destination=` param (stored in `state`). Returns error to `/user/login` if login disabled.
- `oauth_login_oauth2.mo_login` → `/mo_callback` (`_access: TRUE`): OAuth redirect URI.
  Exchanges `code` → token → userinfo → logs in matching user. **Use this as the redirect_uri
  registered at the provider.**
- `oauth_login_oauth2.post_testconfig` → `/mo_post_testconfig` (`_access: TRUE`): saves the
  email attribute chosen at the end of the Test Configuration popup.

## Settings keys (`oauth_login_oauth2.settings` config object)

Defaults ship in `config/install/oauth_login_oauth2.settings.yml`. The keys the free flow reads:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `miniorange_oauth_enable_login_with_oauth` | bool | `true` | Master switch; `/moLogin` errors out if false. |
| `miniorange_auth_client_display_link` | string | `''` | Label of the login link added to `/user/login`. |
| `miniorange_auth_client_client_id` | string | `''` | OAuth client ID. |
| `miniorange_auth_client_client_secret` | string | `''` | Client secret, **stored encrypted** (see below). |
| `miniorange_auth_client_scope` | string | `''` | Requested scopes, e.g. `openid email profile`. |
| `miniorange_auth_client_authorize_endpoint` | string | `''` | Provider authorize URL. |
| `miniorange_auth_client_access_token_ep` | string | `''` | Token endpoint URL. |
| `miniorange_auth_client_user_info_ep` | string | `''` | Userinfo endpoint URL. If it ends in `=`, the access token is appended to the query. |
| `miniorange_auth_client_callback_uri` | string | `''` | Redirect URI sent to the provider (should be `<site>/mo_callback`). |
| `miniorange_oauth_send_with_body_oauth` | bool | `true` | Send client_id/secret in the token request body. |
| `miniorange_oauth_send_with_header_oauth` | bool | `false` | Send credentials as HTTP Basic `Authorization` header instead. |
| `miniorange_oauth_client_email_attr_val` | string | `''` | Which userinfo attribute holds the email used to match a Drupal user. |
| `miniorange_oauth_client_base_url_checkbox` | bool | `false` | Rewrite `http://` → `https://` in the base/callback URL. |
| `miniorange_oauth_client_enable_logging` | bool | `''`/false | Enable verbose debug logging (`Utilities::addLogger`). |
| `miniorange_oauth_client_attr_list_from_server` / `…_show_attr_list_from_server` | string(JSON) | `''` | Cached attributes captured during Test Configuration. |

Additional keys appear on the forms (auto-create, role mapping, page/domain restriction,
multiple providers, force-auth, logout redirect) but are **premium-locked** in this version and
not honored by the free login flow.

## Client secret encryption

`Utilities::encrypt()` / `decrypt()` use AES-256-CBC with a key = `hash('sha256', <site private
key>)` and a random IV prepended to the ciphertext. The update hook `…_update_113101()` migrates
a previously plaintext secret to encrypted form. The secret is therefore not stored in plaintext
in config, but it is recoverable by anything that can read the site's private key.

## Typical setup (drush)

```php
\Drupal::configFactory()->getEditable('oauth_login_oauth2.settings')
  ->set('miniorange_auth_client_client_id', '<id>')
  ->set('miniorange_auth_client_client_secret',
        \Drupal\oauth_login_oauth2\Utilities::encrypt('<secret>'))
  ->set('miniorange_auth_client_scope', 'openid email profile')
  ->set('miniorange_auth_client_authorize_endpoint', 'https://idp/authorize')
  ->set('miniorange_auth_client_access_token_ep', 'https://idp/token')
  ->set('miniorange_auth_client_user_info_ep', 'https://idp/userinfo')
  ->set('miniorange_auth_client_callback_uri', 'https://site/mo_callback')
  ->set('miniorange_oauth_client_email_attr_val', 'email')
  ->set('miniorange_oauth_enable_login_with_oauth', TRUE)
  ->set('miniorange_auth_client_display_link', 'Login with SSO')
  ->save();
```

Then register `https://site/mo_callback` as the redirect URI at the provider and visit
`/testSSO` to confirm and select the email attribute.
