# Configure — settings form & OAuth flow

Source: `src/Form/Oauth2SettingsForm.php`, `phpmailer_oauth2.routing.yml`, `config/install/phpmailer_oauth2.settings.yml`.

## Config object `phpmailer_oauth2.settings`

| Key | Set by | Meaning |
|---|---|---|
| `ms_email_address` | admin form | Mailbox / user name used for XOAUTH2 (the `From`/auth user) |
| `ms_client_id` | admin form | Azure app registration Application (client) ID |
| `ms_client_secret` | admin form | Azure app client secret (field is `#type => password`; blank on submit keeps the existing value) |
| `ms_tenant_id` | admin form | Azure directory (tenant) ID |
| `ms_refresh_token` | callback | The raw **authorization code** returned by Azure (stored under this key) |
| `ms_access_token` | callback | Access token from the code exchange |
| `ms_refresh_access_token` | callback | Refresh token from the code exchange — this is what PHPMailer uses to renew tokens |

All ship empty in `config/install`. Schema: `config/schema/phpmailer_oauth2.schema.yml`.

## Admin UI

Route `phpmailer_oauth2.settings` → `/admin/config/system/phpmailer-oauth2` (menu link under
*Configuration › System*). Form fields: Email address, Client ID, Client secret, Tenant ID, and a
**Get auth token** button (link to `phpmailer_oauth2.aad_login`). The form also prints the exact
Redirect URI you must add in Azure: `Url::fromRoute('phpmailer_oauth2.aad_callback')->setAbsolute()`.

`submitForm()` saves email/client id/tenant id always; it only overwrites `ms_client_secret` when the
password field is non-empty (so re-saving without re-typing the secret preserves it).

## Authorization-code flow (routes)

All three routes require permission `administer phpmailer oauth2 settings` (`restrict access: TRUE`);
login and callback set `no_cache: TRUE`.

1. `phpmailer_oauth2.aad_login` (`/phpmailer_oauth2/aad-login`) →
   `MsLoginController::login()` builds the Azure authorization URL (scope
   `https://outlook.office.com/SMTP.Send` + `offline_access`) and returns a `TrustedRedirectResponse`
   to Microsoft.
2. User consents; Azure redirects to `phpmailer_oauth2.aad_callback`
   (`/phpmailer_oauth2/aad-callback`) → `MsOauth2CallbackController::callback()`:
   - No `code` and no `error` → 404.
   - `error` present → logged to the `phpmailer_oauth2` channel + error message.
   - `code` present → stores it as `ms_refresh_token`, then calls the provider's
     `getAccessToken('authorization_code', ['code' => …])` and saves `ms_access_token` +
     `ms_refresh_access_token`, then redirects back to the settings page.

## Setup checklist

1. Enable `phpmailer_smtp` and configure it to use OAuth2 with the `azure` provider.
2. Register an app in Azure AD; add redirect URI `<host>/phpmailer_oauth2/aad-callback`; grant the
   `SMTP.Send` (delegated) permission; create a client secret.
3. Fill the settings form (email, client id, secret, tenant id) and save.
4. Click **Get auth token**, consent, and confirm the three "…token retrieved" messages.
