SendGrid Integration routes all of Drupal's outgoing mail through the SendGrid transactional email Web API instead of local SMTP, by providing a `sendgrid_integration` Mail (MailInterface) plugin.

---

SendGrid Integration ships a `SendGridMail` plugin that implements Drupal's `MailInterface`, so once it is selected as the site's (or a module's) mail system via the required Mailsystem module, every `MailManager::mail()` call is delivered over SendGrid's HTTPS API rather than PHP mail/SMTP. The plugin builds a SendGrid `Mail` object from Drupal's message array: it parses From/To/Cc/Bcc/Reply-To headers, splits multipart bodies into `text/plain` and `text/html` content (using `html2text` for an automatic text alternative), attaches files (both raw `$message['attachments']` and Mimemail-style `$message['params']['attachments']`), and applies click/open tracking from config. The API key is read from `sendgrid_integration.settings` (`apikey`); if the Key module is enabled the stored value is treated as a Key entity id and resolved through `key.repository`, otherwise it is used as the raw secret (and can be overridden from settings.php). Each message is tagged with SendGrid categories (site name, sending module, message id) so mail can be filtered in the SendGrid UI, and modules can alter categories, unique args, or the whole SendGrid message via hooks. Sends that fail with retryable HTTP codes (-110, 404, 408, 500, 502, 503, 504) are pushed to the `SendGridResendQueue` queue worker and retried on cron (60-minute window). Password-reset and Drupal Commerce messages automatically bypass SendGrid spam checks. A test form at `admin/config/services/sendgrid/test` sends a trial email to verify configuration. The bundled `sendgrid_integration_reports` submodule adds a statistics dashboard built from SendGrid's v3 stats API.

---

- Send all Drupal transactional email (registration, password reset, contact form) through SendGrid instead of local mail.
- Replace an unreliable SMTP setup with SendGrid's Web API for better deliverability.
- Route only a specific module's mail through SendGrid while leaving the rest on the default system (per-module Mailsystem setting).
- Store the SendGrid API key as a Key entity (Key module) rather than plain config.
- Keep the API key out of version control by defining it in settings.php (`$config['sendgrid_integration.settings']['apikey']`).
- Send HTML email with an automatically generated plain-text alternative.
- Send multipart (text + HTML) and multipart/mixed messages, including base64-decoded HTML parts.
- Attach files to outgoing mail, including Mimemail-style attachments from `$message['params']['attachments']`.
- Enable SendGrid click tracking and open tracking site-wide from the settings form.
- Tag outgoing mail with SendGrid categories (site name / module / message key) for filtering and stats.
- Verify configuration by sending a test email from the admin test form.
- Retry failed sends automatically via a cron queue when SendGrid returns a retryable error code.
- Bypass SendGrid spam filtering on password-reset and Drupal Commerce messages.
- Send to multiple recipients, plus Cc and Bcc, parsed from message headers.
- Set a custom From name/address and Reply-To per message via headers or mail params.
- Send using a SendGrid dynamic template by setting `$message['sendgrid']['template_id']`.
- Pass template substitution values via `$message['sendgrid']['substitutions']`.
- Override the API key for a single message with `$message['params']['apikey']`.
- Add a per-user `uid` custom arg to messages when a user account is present in params.
- Alter the SendGrid categories used for a message via `hook_sendgrid_integration_categories_alter()`.
- Add unique arguments / metadata to a message via `hook_sendgrid_integration_unique_args_alter()`.
- React after a message is sent (log, notify) via `hook_sendgrid_integration_sent()`.
- Alter the fully built SendGrid message object with `hook_sendgrid_integration_alter()`.
- Extend the list of allowed attachment MIME types via `hook_sendgrid_integration_valid_attachment_types_alter()`.
- Gate access to SendGrid configuration with the `administer sendgrid settings` permission.
- Add a SendGrid statistics/reporting dashboard by enabling the `sendgrid_integration_reports` submodule.
- Store local copies of sent mail for debugging by pairing with the Maillog module.
