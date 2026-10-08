Easy Email Overrides replaces emails sent by core and contrib modules (such as the user password-reset, account-activation, and welcome emails) with rich HTML emails generated from Easy Email templates, mapping the original mail parameters onto the template.

---

Easy Email Overrides (submodule of `easy_email`) works by decorating Drupal's `plugin.manager.mail` service: its `MailManager` decorator intercepts each outgoing `mail()` call, checks whether an `easy_email_override` config entity matches that mail's module + key, and if so builds and sends an Easy Email instead of the module's default message. Each override is a config entity (`easy_email_override`) storing the target `module` and `key`, the `easy_email_type` template to use, a `param_map` (mapping the original mail parameters — e.g. a user `account` — onto template fields), and `copied_fields` flags (from, reply_to, to, cc, bcc, subject, body_html, body_plain, attachments) that control which parts of the original mail are copied through versus taken from the template. Overridable emails are discovered as plugins: a `DeclaredEmailManager` (`plugin.manager.easy_email_override`) reads `{module}.emails.yml` files, so any module can declare an email as overridable by shipping an `emails.yml` entry (id, label, module, key, params). The submodule ships declarations for many core user emails (register/welcome, activation, blocked, cancellation, password recovery), and `easy_email_commerce` declares the Commerce order receipt. Overrides are managed at Admin → Structure → Email templates → Overrides (`entity.easy_email_override.collection`, the `configure` route), and access is gated by core `administer site configuration`. It defines the override config entity, the declared-email plugin type, and the mail-manager decorator; it adds no permissions of its own.

---

- Replace the user password-reset email with a branded HTML template.
- Override the "welcome (no approval required)" new-account email with HTML.
- Override account activation, blocking, and cancellation emails with templates.
- Override the admin-created-account welcome email.
- Override the awaiting-approval and pending-approval-admin emails.
- Send an HTML version of any core or contrib email without patching that module.
- Map the original mail's `account`/`order` parameter onto an Easy Email template field.
- Choose which parts of the original email (subject, body, to, cc, from) are copied vs. templated.
- Declare your own module's email as overridable by shipping a `{module}.emails.yml` entry.
- Let site builders swap any declared email for an Easy Email template via the UI.
- Convert plain-text transactional emails to HTML site-wide by adding overrides.
- Keep the original recipient/subject but replace only the body with a template.
- Override the Commerce order receipt (with easy_email_commerce declaring it).
- Manage all overrides in one place at Admin → Structure → Email templates → Overrides.
- Deploy email overrides as configuration between environments.
- Gate override administration behind `administer site configuration`.
- Intercept outgoing mail centrally via the mail-manager decorator (no per-module hooks).
- Provide different templates for different mail keys of the same module.
