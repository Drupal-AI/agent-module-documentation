# symfony_mailer (Mailer Plus) — agent start

Replaces core mail with a Symfony-Mailer pipeline: an `Email` object flows through phases
(init → build → pre_render → post_render → post_send), built by **component mailers**
(`#[MailerInfo]` plugins via `MailerLookup`) and modified by **processors**. Depends on
`mailer_transport` (submodule) + core `filter`. Requires libs `symfony/mailer`,
`html2text/html2text`, `css-to-inline-styles`. Verify page: **Config → System → Mailer Plus**
(`/admin/config/system/mailer`, route `symfony_mailer.verify`). Permission: `administer mailer`.

- Verify/settings page & how config is split across submodules → [configure/configure.md](configure/configure.md)
- Component mailers (`MailerInfo`) & email processors → [plugins/plugins.md](plugins/plugins.md)
- Email API — build & send in code → [api/email.md](api/email.md)
- Phase hooks & mailer-info alter → [hooks/hooks.md](hooks/hooks.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)

Submodules (documented separately — enable as needed): `mailer_transport` (SMTP/Sendmail/DSN
transports), `mailer_policy` (EmailAdjuster policy config entities), `mailer_override`
(redirect legacy `hook_mail` emails into Mailer Plus).
