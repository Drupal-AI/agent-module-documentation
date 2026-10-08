<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AhaSend routes Drupal's outbound email through the AhaSend transactional email-delivery service.

---

AhaSend registers a Mail System plugin (`ahasend_mail`) that hands each outgoing Drupal message to the AhaSend HTTP API (`POST https://api.ahasend.com/v1/email/send`) instead of the local sendmail transport. HTML and plain-text bodies are supported (plain text is auto-derived from HTML with html2text when not supplied), along with Cc/Bcc, Reply-To, and file attachments including inline/embedded images referenced by Content-ID. Configuration lives at `/admin/config/mail/ahasend` behind the `administer ahasend` permission: you enter an AhaSend API key and an optional default "from" name, and can send a test email. It depends on the Mail System module to select which mail interfaces AhaSend handles, and runs on Drupal 10 and 11.

---

- Send all site email through AhaSend's delivery API for better deliverability.
- Provide the `ahasend_mail` Mail System plugin.
- Route outbound Drupal mail via `POST /v1/email/send` on the AhaSend API.
- Configure the AhaSend API key at `/admin/config/mail/ahasend`.
- Set a default sender ("from") name for messages that lack a display name.
- Fall back to the site name as the sender name when no from-name is set.
- Fall back to the site email as the from address when a message has none.
- Send HTML email messages.
- Send plain-text email messages.
- Auto-generate a plain-text alternative from HTML bodies via html2text.
- Optionally run bodies through a text format (`format_filter`) before sending.
- Add Cc recipients from message headers.
- Add Bcc recipients from message headers.
- Set a Reply-To address on outgoing mail.
- Attach files from a file path or stream URI.
- Attach in-memory file content directly.
- Embed inline images/attachments using Content-ID.
- Send a test email from the settings form to verify configuration.
- Enable debug mode to log each send and the API response.
- Assign AhaSend as the default mailer via Mail System's interface mapping.
- Route only specific message keys/modules through AhaSend using Mail System.
- Handle transactional mail (registration, password reset, order notices).
- Gate mail configuration behind the `administer ahasend` permission.
- Use AhaSend's HTTP API as an alternative to SMTP delivery.
