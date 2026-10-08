<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailjet API lets a Drupal site send its outbound email through Mailjet's transactional Send API v3.1 instead of local mail, by registering a mailer you enable through the Mail System module.

---

The module ships a `mailjet_api_mail` Mail plugin backed by the `mailjet_api.mail_handler` service, which maps a standard Drupal message array to the Mailjet v3.1 payload (From/To/Cc/Bcc, HTML and text parts, attachments, reply-to) and POSTs it with the official `mailjet/mailjet-apiv3-php` SDK. You set the public and secret API keys on the settings form, then point Mail System at the "Mailjet API mailer" globally or per module/key. Options add queue-and-send on cron, a sandbox mode, image embedding, running the body through a text format or a mail theme, Mailjet stored templates, custom-campaign tagging, and template-error reporting. Two events (`mailjet_api.message_pre_build` / `mailjet_api.message_post_build`) and a built-in test form round it out. Requires the Mail System module and a Mailjet account.

---

- Send Drupal email through Mailjet's API.
- Use Mailjet for transactional mail.
- Improve email deliverability with a managed provider.
- Route all site mail through Mailjet.
- Configure Mailjet public and secret API keys.
- Send emails using a Mailjet stored template.
- Pass template variables to Mailjet.
- Queue outgoing mail and send it on cron.
- Enable sandbox mode to validate without delivering.
- Embed images inline as base64 in outgoing mail.
- Render email bodies through a custom mail theme.
- Override the email template per module or mail key.
- Run mail bodies through a Drupal text format.
- Tag messages with a custom Mailjet campaign.
- Deduplicate recipients within a campaign.
- Send CC and BCC recipients (incl. Webform's cc_mail/bcc_mail).
- Attach files to outgoing messages.
- Set a per-message reply-to and sender name.
- Report Mailjet template errors to an address.
- Send a test email from the admin UI.
- Restrict Mailjet administration to trusted roles.
- Replace PHP mail() with an HTTP API sender.
- Send password-reset and system emails reliably.
- Alter the message before or after the payload is built via events.
- Log every send for debugging.
