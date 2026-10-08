Azure Mailer is a Drupal mail backend that delivers outgoing email through the Azure Communication Services (ACS) Email REST API instead of PHP `mail()`/SMTP.

---

The module registers one `@Mail` plugin, `azure_mailer` ("Azure Communication Service"), and depends on the [Mailsystem](https://www.drupal.org/project/mailsystem) module to make it the site's active mail backend. On send, `AzureMailer::mail()` reads two config values from `azure_mailer.settings` — the ACS `endpoint` host and a shared `secret` — builds an ACS email JSON payload (recipients, `senderAddress`, `replyTo`, headers, and both `html`/`plainText` content derived from Drupal's rendered message body and subject), and POSTs it to `https://<endpoint>/emails:send?api-version=2023-03-31` over Guzzle. Requests are signed with Azure's HMAC scheme by the `mobomo/guzzle-azure-hmac-auth` Guzzle middleware using the `secret`. The `endpoint` is entered on the settings form at `/admin/config/config/azure_mailer` (permission `administer site configuration`); the `secret` field on that form is intentionally **disabled/read-only** — you set the secret out-of-band in `settings.php` (`$config['azure_mailer.settings']['secret'] = …`) or via Drush so it is never editable or displayed in the UI. There is no config schema, no permissions of its own, and no Drush commands. A Guzzle error surfaces as a Drupal messenger error and `mail()` returns FALSE; a successful POST returns TRUE.

---

- Send Drupal transactional email through Azure Communication Services instead of local SMTP.
- Replace `sendmail`/`mail()` on a host that has no outbound mail server.
- Route all site email via ACS by selecting the mailer as the site-wide default in Mailsystem.
- Use ACS for a specific module's mail while keeping another backend for the rest (Mailsystem per-module).
- Deliver HTML email (with an auto-generated plain-text alternative) via ACS.
- Keep the ACS access secret out of the database and UI by setting it in `settings.php`.
- Inject the ACS secret from an environment variable at deploy time (`getenv('AZURE_COMM_SECRET')`).
- Set a per-environment ACS endpoint (dev/stage/prod) via config overrides.
- Sign outbound requests with Azure HMAC automatically through the bundled Guzzle middleware.
- Honour a message `reply-to`, falling back to the `from` address when none is set.
- Pass Drupal message headers through to the ACS payload.
- Send password-reset, registration and other core notification emails through ACS.
- Deliver Webform / Commerce / Contact-form notifications via ACS.
- Centralise email deliverability and reputation management in Azure.
- Avoid SMTP credentials on the web server by using ACS REST + HMAC instead.
- Surface delivery/transport failures to admins as Drupal error messages.
- Serve as the mail transport in an Azure-hosted Drupal stack.
- Swap providers by pointing Mailsystem back to the default backend without code changes.
- Configure the ACS endpoint through the admin form while managing the secret via infrastructure tooling.
