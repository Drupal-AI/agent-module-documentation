Mailer Override transparently redirects Drupal's legacy `hook_mail` / `MailManager` emails (core user, contact, update-status, plus Commerce and Simplenews) into the Mailer Plus pipeline, and imports ready-made Mailer Policies so those emails become themeable HTML without custom code.

---

Many modules still send email the old way via core's `MailManagerInterface`. This submodule
installs a `MailManagerReplacement` service that intercepts those calls and rebuilds each
message as a Mailer Plus `Email`, so legacy mail gains HTML rendering, theming, CSS inlining,
and policy-based configuration. Which sources are captured is controlled by **MailerOverride**
plugins (`#[Override]`, discovered by `OverrideManager`): shipped overrides cover core user
account mail, the Contact module, update-status notifications, Registration Password, and
(when present) Commerce orders and Simplenews. Each override, when activated, imports a set of
default `mailer_policy` config entities (subjects, From addresses, themes) via an
`ImportHelper`, giving you a working, editable configuration immediately. An admin screen at
Configuration → System → Mailer Plus → Override lists every available override with its status
and lets you enable, disable, or re-import it; the same actions are available through Drush
(`mailer:override`, `mailer:override-info`). A `LegacyMailer` component and `LegacyProcessor`
handle emails that have no dedicated override. This is the bridge that lets an existing site
adopt Mailer Plus for all of its mail, not just newly written mailers.

---

- Convert core user account emails (register, password reset, status) to HTML.
- Route Contact form emails through Mailer Plus with per-form policies.
- Send Commerce order confirmation/receipt emails as themed HTML.
- Bring Simplenews newsletter and subscription emails into the pipeline.
- Themed update-status security notification emails.
- Import ready-made Mailer Policies for each overridden email source.
- Enable an override for a single source while leaving others legacy.
- Disable an override to hand an email source back to core mail.
- Re-import default policies for an override after changing configuration.
- Redirect any remaining `hook_mail` email via the generic legacy mailer.
- Review the status of every override on one admin screen.
- Enable or disable overrides in bulk via Drush in CI/deploy scripts.
- List override status as a table or JSON with `mailer:override-info`.
- Migrate an existing site to Mailer Plus without rewriting mail code.
- Replace the SMTP/Mimemail stack while keeping core email working.
- Apply consistent branding to all transactional email at once.
- Override Registration Password confirmation emails.
- Keep contact auto-reply copies configurable per contact form.
- Gate override administration behind the `administer mailer` permission.
- Add a custom MailerOverride plugin for another contrib module's email.
- Alter available override definitions with `hook_mailer_override_info_alter()`.
- Roll out email overrides gradually, verifying each source as you go.
- Ensure decoupled/queued mail (e.g. newsletters) uses the new renderer.
