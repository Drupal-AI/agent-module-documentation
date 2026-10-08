# reroute_email — agent start

Intercepts all outgoing mail via `hook_mail_alter()` (run last) and reroutes To/Cc/Bcc to a
configured test address — or aborts it — so a non-production site never mails real users. All
behavior lives in the `reroute_email.settings` config object. No module dependencies.
Config UI: **Admin → Config → Development → Reroute Email**
(`/admin/config/development/reroute_email`); settings route `reroute_email.settings`.
RC release (`2.3.0-rc2`, version dir `2.3.x`).

- Enable/target rerouting, allowlist, roles, mail-key filters, settings.php overrides, drush,
  test form → [configure/reroute_email.md](configure/reroute_email.md)
- The interception mechanism: `RerouteEmailHandler` plugin type, `X-Rerouted-Force` header,
  `hook_reroute_email_handler_info_alter()` → [extend/reroute_email.md](extend/reroute_email.md)

Submodule: **reroute_email_symfony_mailer** — rerouting for the Symfony Mailer transport
(`modules/reroute_email_symfony_mailer/2.3.x/`).
