# Azure Mailer — agent index

A Drupal mail backend (`@Mail` plugin `azure_mailer`) that sends email via the Azure
Communication Services (ACS) Email REST API. Depends on **Mailsystem** to become the active
backend. Config UI at `/admin/config/config/azure_mailer` (`configure: azure_mailer.config`,
permission `administer site configuration`). No permissions of its own, no schema, no Drush.

- **Set the endpoint + secret and wire it up as the mailer (Mailsystem)** →
  [configure/settings.md](configure/settings.md)
- **What the mail plugin sends: the ACS payload, HMAC signing, return/error behaviour** →
  [api/mail_plugin.md](api/mail_plugin.md)

Key facts:
- Two config keys in `azure_mailer.settings`: `endpoint` (host, e.g.
  `yoursite.communication.azure.com`) and `secret` (ACS access key).
- The `secret` form field is **disabled** in the UI by design — set it in `settings.php`
  (`$config['azure_mailer.settings']['secret'] = …`) or via Drush.
- Sends `POST https://<endpoint>/emails:send?api-version=2023-03-31`, signed with Azure HMAC by
  `mobomo/guzzle-azure-hmac-auth` (external Composer lib, tracked at `dev-main`).
- Requires PHP >= 8.1 and `drupal/mailsystem ^4.1`.
