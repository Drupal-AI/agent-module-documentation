PHPMailer OAuth2 adds an OAuth2 (XOAUTH2) authentication client to the PHPMailer SMTP module so Drupal can send mail through Microsoft 365 / Azure AD (Outlook / Office 365) SMTP without a stored password.

---

The module ships one concrete OAuth2 provider — Azure AD — implemented as a `phpmailer_smtp` `PhpmailerOauth2` plugin (`azure`), plus a settings form, an authorization/callback flow, and a helper service that builds a `thenetworg/oauth2-azure` provider. An admin enters the Azure app's Email address, Client ID, Client secret and Tenant ID at `/admin/config/system/phpmailer-oauth2`, then clicks *Get auth token* to run the standard OAuth2 authorization-code flow: the `phpmailer_oauth2.aad_login` route redirects to Microsoft's consent screen (scopes `https://outlook.office.com/SMTP.Send` and `offline_access`), and the `phpmailer_oauth2.aad_callback` route exchanges the returned `code` for an access token and refresh token, saving them into `phpmailer_oauth2.settings`. When PHPMailer SMTP sends mail, it calls the `azure` plugin's `getAuthOptions()`, which returns the provider, user name, client id/secret and stored refresh token so PHPMailer's OAuth token provider can mint a fresh access token via XOAUTH2. All three routes (settings, login, callback) require the `administer phpmailer oauth2 settings` permission (`restrict access: TRUE`). The Azure endpoints are hardcoded to the v2.0 endpoint and Microsoft Graph 1.0 API base. There is no UI beyond the single settings form and no Drush commands; the provider is pluggable in principle (the `PhpmailerOauth2` plugin type lives in `phpmailer_smtp`) but only Azure is provided here.

---

- Send Drupal mail through Microsoft 365 / Office 365 SMTP using OAuth2 instead of a stored SMTP password.
- Authenticate an Outlook.com / Exchange Online mailbox for outbound SMTP via Azure AD app registration.
- Run the OAuth2 authorization-code flow from the admin UI to obtain and store a refresh token.
- Configure the Azure Client ID, Client secret and Tenant ID for an app registration.
- Grant an app the `SMTP.Send` delegated scope and `offline_access` for long-lived refresh tokens.
- Replace legacy basic-auth SMTP (deprecated by Microsoft) with modern OAuth2 XOAUTH2 auth.
- Provide the redirect URI (`/phpmailer_oauth2/aad-callback`) that must be registered in the Azure portal.
- Re-authorize / refresh credentials when a refresh token expires or is revoked.
- Wire an Azure AD tenant-restricted app (specific Tenant ID) to Drupal's mail system.
- Supply PHPMailer SMTP with per-send OAuth token options through the `azure` plugin.
- Keep the SMTP client secret out of the mail transport config by delegating token minting to the OAuth2 library.
- Add a new OAuth2 mail provider by implementing another `PhpmailerOauth2` plugin (Google, etc.) alongside Azure.
- Build a `thenetworg/oauth2-azure` provider preconfigured for SMTP.Send from Drupal config via the shared service.
- Use Microsoft Graph endpoint version 2.0 token issuance for SMTP authentication.
- Centralize Azure mail credentials in one Drupal settings page for site operators.
- Diagnose OAuth authorization failures via the `phpmailer_oauth2` logger channel (errors logged on callback).
- Redirect an admin back to the settings page after a successful or failed token exchange.
- Restrict who can manage mail OAuth credentials via a dedicated restricted-access permission.
