Drupal Symfony Mailer Lite integrates Drupal with the Symfony Mailer library so the site can send HTML-formatted emails and emails with attachments. It is a drop-in successor to the deprecated Swiftmailer module.

---

The module registers a Mail plugin (`symfony_mailer_lite`) that you assign — via the required Mail System module — as the formatter and/or sender either sitewide or for specific modules and keys. Outgoing mail is delivered through configurable **transport** config entities (a plugin type): Native (php.ini sendmail), SMTP, Sendmail, Null, and a raw DSN transport, each editable at Configuration → System → Symfony Mailer Lite. It converts render arrays and HTML to properly formatted messages, inlines CSS (via css-to-inline-styles), generates a plain-text alternative (via html2text), and can embed images. A Twig template (`symfony-mailer-lite-email.html.twig`) with per-module/per-key theme suggestions controls the HTML wrapper, and message settings let you tune character set and formatting. A built-in test form sends a sample email to verify configuration. It intentionally mirrors Swiftmailer's approach and API so existing sites can switch with minimal changes, while the separate full "Symfony Mailer" project offers a larger templating/API system for those who want more. Custom sendmail commands must be allow-listed in settings.php via `$settings['mailer_sendmail_commands']`.

---

- Send HTML-formatted emails from Drupal instead of plain text.
- Attach files (PDFs, images) to outgoing site emails.
- Replace the deprecated Swiftmailer module as a drop-in successor.
- Route all site mail through an external SMTP server.
- Use the native php.ini sendmail transport with no extra config.
- Use the local sendmail binary as the mail transport.
- Configure a transport from a raw Symfony Mailer DSN string.
- Disable real sending in dev with the Null transport.
- Assign Symfony Mailer Lite as the default mail formatter/sender via Mail System.
- Use a different mailer for specific modules or mail keys only.
- Send a test email to confirm mail is configured correctly.
- Inline CSS into email HTML so styles survive in mail clients.
- Auto-generate a plain-text alternative body from HTML.
- Embed images inline in HTML emails.
- Customize the email HTML wrapper via a Twig template.
- Provide per-module or per-key email templates with theme suggestions.
- Set the message character set / encoding.
- Define multiple named transports and switch the default.
- Manage transports as exportable configuration entities.
- Restrict mail administration with a dedicated permission.
- Add a custom transport type by writing a transport plugin.
- Alter available transports via the transport info alter hook.
- Migrate Swiftmailer templates/libraries by renaming to the new names.
- Allow-list custom sendmail commands securely via settings.php.
- Send transactional emails (password resets, notifications) as styled HTML.
- Integrate with Symfony Messenger for queued/async mail dispatch.
