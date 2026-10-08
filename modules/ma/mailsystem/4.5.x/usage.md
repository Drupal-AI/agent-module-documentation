Mail System gives site builders a UI (and developers an API) to choose which mail backend/plugin Drupal uses to format and send email — globally, per module, and per mail key — instead of editing the `mail_system` variable by hand.

---

Drupal core lets one `MailInterface` plugin format and send all mail, and swapping it normally means overriding the `mail_system` container parameter in code. Mail System replaces that with an admin form at **Admin → Configuration → System → Mail System** where you pick a **formatter** and a **sender** plugin for the site default and, optionally, override them for specific modules or specific mail keys (e.g. use an HTML formatter for `user` mails but the plain-text sender for everything else). It ships a `MailsystemManager` that extends core's `MailManager`, reading the module's own `mailsystem.settings` config to decide which formatter/sender pair to instantiate for a given `$module`/`$key`. It also lets you select the theme used when rendering HTML mail (default theme, active theme, or a fixed one) via `mailsystem_get_mail_theme()`. This makes it the standard integration point for contrib mail modules such as SMTP, Swift Mailer / Symfony Mailer, Mailgun, Mime Mail and HTML mail, which register formatter and sender plugins that you then wire up here. Settings are stored as exportable configuration, so mail routing is deployable across environments. A migrate process plugin is included to carry Drupal 7 mail configuration forward.

---

- Select a site-wide default mail formatter and sender plugin from the UI.
- Use a different sender (transport) than formatter, e.g. Mime Mail formatting + SMTP sending.
- Route a specific module's mail (e.g. `contact`, `user`) through its own backend.
- Override the backend for a single mail key such as `user_password_reset`.
- Wire up the SMTP module as the sending plugin for all outgoing mail.
- Send HTML email by selecting an HTML/Mime Mail formatter.
- Integrate Swift Mailer or Symfony Mailer as the sender.
- Send transactional mail through Mailgun/SendGrid contrib backends.
- Keep plain-text formatting for system mail but HTML for newsletters.
- Choose which theme renders HTML mail (default, current, or a fixed theme).
- Deploy consistent mail routing between dev, stage and prod as config.
- Give a specific mailing (mail key) a dedicated formatter without touching code.
- Reset a per-module override back to the site default.
- Provide a single admin screen for all mail backend decisions.
- Let a custom module expose its own `MailInterface` plugin and select it here.
- Debug delivery by temporarily switching the sender to a test/log backend.
- Format newsletters with a rich formatter while sending via a bulk provider.
- Migrate Drupal 7 `mail_system` variable settings during an upgrade.
- Gate access to mail configuration behind the `administer_mailsystem` permission.
- Combine several contrib mail modules and control precedence centrally.
- Standardize mail formatting across a multisite via exported config.
- Avoid hard-coding `mail_system` overrides in `settings.php` or service files.
- Apply a custom formatter only to password/one-time-login emails.
- Programmatically resolve the correct backend for a module/key via the manager.
