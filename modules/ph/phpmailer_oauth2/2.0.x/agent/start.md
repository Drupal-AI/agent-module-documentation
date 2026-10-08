# PHPMailer OAuth2 — agent index

OAuth2 (XOAUTH2) client for the **PHPMailer SMTP** module, so Drupal can send mail via Microsoft 365 /
Azure AD without a stored password. Ships one provider (Azure AD) as a `phpmailer_smtp` `PhpmailerOauth2`
plugin plus a settings form and authorization-code flow. Depends on `phpmailer_smtp` and the
`thenetworg/oauth2-azure` library. Config UI: `/admin/config/system/phpmailer-oauth2`
(`configure` = `phpmailer_oauth2.settings`). No Drush.

- **Settings form, config keys, the login/callback OAuth flow, routes & permission** →
  [configure/settings.md](configure/settings.md)
- **`AzureProviderService` (build a provider, get PHPMailer auth options) for custom code** →
  [api/service.md](api/service.md)
- **The `azure` PhpmailerOauth2 plugin and how to add another provider** →
  [plugins/oauth2.md](plugins/oauth2.md)

Key facts:
- Config object `phpmailer_oauth2.settings`: `ms_email_address`, `ms_client_id`, `ms_client_secret`,
  `ms_tenant_id`, `ms_refresh_token` (auth code), `ms_access_token`, `ms_refresh_access_token`.
- Scopes are hardcoded: `https://outlook.office.com/SMTP.Send` + `offline_access`; endpoint v2.0,
  Graph API base `https://graph.microsoft.com/` v1.0.
- All three routes require `administer phpmailer oauth2 settings` (`restrict access: TRUE`).
- Redirect URI to register in Azure: `<host>/phpmailer_oauth2/aad-callback`.
