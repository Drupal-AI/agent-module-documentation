# Manage overrides

## Where
`/admin/config/system/mailer/override` (route `mailer_override.status`, controller
`MailerOverrideController::overrideStatus`, permission `administer mailer`). Lists every
`MailerOverride` plugin with its current status. Per-override actions run via
`/admin/config/system/mailer/override/{id}/{action}` (form `OverrideActionForm`).

## What activating does
State is stored in `mailer_override.settings:override` (a list of active override ids).
Enabling an override:
1. Registers it so `MailManagerReplacement` intercepts that source's legacy `hook_mail`
   calls and rebuilds them as Mailer Plus `Email`s (`LegacyMailerHelper` / `LegacyProcessor`).
2. Imports the override's default `mailer_policy` config entities via `ImportHelper`
   (subjects, From, theme). These become normal, editable policies (see mailer_policy docs).

Actions available: **enable**, **disable** (hand the source back to core mail), and
**import/re-import** default policies.

## Shipped overrides
`user` (core account emails), `contact`, `update` (status notifications),
`user_registrationpassword`, and — when those modules exist — `commerce_order`,
`simplenews_newsletter`, `simplenews_subscriber`. Emails with no dedicated override are still
routed generically through the `LegacyMailer` component.

## Notes
- Requires `mailer_policy` (imported policies) and `symfony_mailer`.
- CLI equivalents: [../drush/commands.md](../drush/commands.md).
- Keep secrets out of any exported override/policy config.
