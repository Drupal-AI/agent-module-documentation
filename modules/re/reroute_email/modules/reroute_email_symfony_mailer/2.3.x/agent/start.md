# reroute_email_symfony_mailer — agent start

Submodule of **Reroute Email**. The core module reroutes via `hook_mail_alter()`, which the
Symfony Mailer transport does not use; this submodule reroutes mail sent through
`symfony_mailer` instead. Depends on `reroute_email` + `symfony_mailer`. Shares the same
`reroute_email.settings` config and the settings form (`reroute_email.settings`,
`/admin/config/development/reroute_email`). RC release, version dir `2.3.x`.

- Enable it, use global vs per-policy settings, the adjuster/builder/handler plugins →
  [extend/reroute_email_symfony_mailer.md](extend/reroute_email_symfony_mailer.md)

Configuration keys and drush usage are identical to the parent module:
`../../../../2.3.x/agent/configure/reroute_email.md`.
