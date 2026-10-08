# Configure Mailer Plus

The base module ships a **verify** screen and the pipeline; most configuration lives in the
three submodules.

## Verify page
`/admin/config/system/mailer` (route `symfony_mailer.verify`, form `VerifyEmailForm`,
permission `administer mailer`). Sends a test email and reports whether outgoing mail and
the configured transport are working. There is no `configure:` route key on the base module
itself — this page is the entry point, and it links to the submodule config below.

## Where configuration lives
- **Transports** (how mail is sent): the `mailer_transport` submodule (a hard dependency)
  provides `mailer_transport` config entities at `/admin/config/system/mailer/transport`.
  SMTP/Sendmail/DSN/native/null.
- **Policies** (what emails look like / who they go to): the `mailer_policy` submodule
  provides `mailer_policy` config entities at `/admin/config/system/mailer/policy`, each a
  stack of EmailAdjuster plugins keyed by email type.
- **Legacy override** (redirect core `hook_mail`): the `mailer_override` submodule at
  `/admin/config/system/mailer/override`.

(These are separate modules — see their own docs.)

## How an email is identified
Each email has a hierarchical **type/sub-type tag** (e.g. `user`, `user__password_reset`)
declared by the component mailer's `#[MailerInfo(base_tag: ...)]`. Policies and hooks target
emails by that tag, so you can configure — say — only password-reset mail without touching
other user emails.

## Rendering
Bodies are rendered as HTML through a Drupal theme, CSS is inlined
(`tijsverkoyen/css-to-inline-styles`), and a plain-text alternative is produced with
`html2text/html2text`. The theme/inline/plain behaviour is controlled by EmailAdjuster
plugins in a policy (`theme`, `inline_css`, `convert`/`plain`).
