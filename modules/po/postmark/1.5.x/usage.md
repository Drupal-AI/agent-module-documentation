Postmark routes Drupal's outbound email through the third-party [Postmark](https://postmarkapp.com/) transactional-email service over its HTTPS REST API instead of local SMTP, via a Mail System (`mailsystem`) mail plugin.

---

The module registers a `postmark_mail` Drupal mail plugin (`PostmarkMail`) that you select — globally or per-module — on the Mail System module's settings page. When Drupal sends mail, the plugin formats the body (optionally running it through a configured text format, and deriving a plain-text alternative with `html2text/html2text`), then hands a message array to the `postmark.mail_handler` service (`PostmarkHandler`), which calls the official `wildbit/postmark-php` `PostmarkClient::sendEmail()` with the site's Postmark Server API token. All mail is sent **from** a single address that must be a verified Postmark *Sender Signature*; core Contact-module mail uses the submitter's address as Reply-To. The settings form (`/admin/config/mail/postmark`, permission `administer postmark`, which is `restrict access: TRUE`) stores the API token, sender signature, debug options, and can send a test email. A debug mode can redirect all mail to one address, log full API responses, or "no-send" test mode that validates config without spending a Postmark credit. `hook_requirements()` surfaces whether the PHP library is installed and whether the API token + sender signature are configured. Cc/Bcc/Reply-To headers and file attachments (existing file paths) are forwarded to the API. The module has no submodules, Drush commands, or config schema.

---

- Send all site email through Postmark's REST API instead of SMTP/sendmail.
- Configure Postmark only for specific modules (e.g. Commerce order mail) while leaving others on the default mailer.
- Improve deliverability of transactional email (password resets, order receipts) via Postmark's infrastructure.
- Send a test email from the settings form to confirm the integration works.
- Use "no-send" debug mode to validate configuration without consuming a Postmark credit.
- Redirect every outgoing message to a single debug inbox on staging/dev environments.
- Log full Postmark API responses to the `postmark` logger channel for troubleshooting.
- Enforce a single verified Sender Signature as the From address for all mail.
- Automatically generate a plain-text alternative from HTML email bodies with html2text.
- Run outgoing bodies through a chosen Drupal text format before sending.
- Forward Cc and Bcc headers to Postmark.
- Preserve Reply-To (e.g. so Contact form replies reach the original sender).
- Attach files to outgoing Postmark messages by file path.
- Gate mail configuration behind the restricted `administer postmark` permission.
- Verify at runtime (Status report) that the Postmark PHP library and API settings are present.
- Swap SMTP for an API-based sender on hosts that block outbound SMTP ports.
- Centralize transactional email for a multisite by pointing each site at its own Postmark server token.
- Keep the Postmark Server API token overridable per-environment via settings.php config overrides.
- Pair with Mail System to mix Postmark (sending) with a different formatter.
- Provide a drop-in mail backend that needs no code changes beyond selecting the plugin.
- Diagnose sender-signature mismatches via the logged error messages when sends fail.
