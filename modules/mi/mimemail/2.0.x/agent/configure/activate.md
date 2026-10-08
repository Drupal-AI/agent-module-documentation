# Making Mime Mail the active mailer

Mime Mail is a **component** module — it provides the `mime_mail` Mail plugin but does not
force itself on. You choose it through the **Mail System** module (`mailsystem`, a hard
dependency), at `/admin/config/system/mailsystem`.

- Set the site-wide (or per-module / per-key) **Formatter** and **Sender** to
  **Mime Mail mailer** (`mime_mail`).
- Typical setup: formatter = Mime Mail (builds the MIME/HTML body), sender = Mime Mail (or
  an SMTP sender plugin such as `smtp`/`symfony_mailer` if you want SMTP delivery while Mime
  Mail formats the body).

Once selected, any `MailManagerInterface::mail()` call for that module/key is rendered
through Mime Mail's template and MIME-encoded.

Nothing in `mimemail.settings` activates the mailer — configuring the settings form alone
has no effect until Mail System routes mail to the `mime_mail` plugin.
