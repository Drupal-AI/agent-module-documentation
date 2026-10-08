Submodule of Reroute Email that reroutes email sent through the Symfony Mailer transport (the `symfony_mailer` module) to the predefined test addresses, since Symfony Mailer bypasses the classic `hook_mail_alter()` path.

---

Reroute Email's core interception is built on `hook_mail_alter()`, which the Symfony Mailer stack does not use, so this submodule bridges the gap. It registers a `RerouteEmailHandler` plugin (`SymfonyMailer`, `applied = {"symfony_mailer_adjuster"}`) that adapts the shared reroute logic in `RerouteEmailHandlerPluginBase` to Symfony Mailer's `EmailInterface` (get/set To, Cc, Bcc, headers, and text/HTML body). It also provides an `EmailAdjuster` plugin (id `reroute_email`) that runs the handler during the email build/postRender phases and exposes a per-policy settings form — either "use global configuration" (the `reroute_email.settings` object) or per-mailer-policy overrides (address, allowlist, roles, mail-key filters). An `EmailBuilder` plugin (id `reroute_email`, sub-type `test_email_form`) powers the Reroute Email test form so it can send through Symfony Mailer, and a `hook_form_FORM_ID_alter()` swaps the test form's submit handler to `email_factory->sendTypedEmail()` and shows the mailer policy. The adjuster is weighted to run after all other adjusters (`hook_mailer_adjuster_info_alter()` adds +100 to the max weight). Aborting a message is implemented by throwing Symfony Mailer's `SkipMailException`. Requires both `reroute_email` and `symfony_mailer`. All the same rerouting settings and behavior apply.

---

- Reroute outgoing mail on a site that uses the Symfony Mailer (`symfony_mailer`) transport.
- Keep test-site mail contained when the classic Drupal mail system has been replaced by Symfony Mailer.
- Reuse the global `reroute_email.settings` (address, allowlist, roles, mail keys) for Symfony Mailer emails.
- Override reroute settings per Symfony Mailer policy instead of globally (uncheck "use global configuration").
- Set a per-policy rerouting address for a specific mailer type/sub-type.
- Allowlist addresses/domains per mailer policy so some Symfony Mailer emails still deliver.
- Exempt users with given roles from rerouting for Symfony Mailer emails.
- Filter which mail keys are rerouted (or skipped) for Symfony Mailer messages.
- Abort Symfony Mailer messages (empty address) via a raised SkipMailException.
- Prepend the reroute description block into the text and HTML bodies of Symfony Mailer emails.
- Send from the Reroute Email test form through Symfony Mailer to verify the policy.
- View the applied mailer policy directly on the test email form.
- Ensure the reroute adjuster runs after all other Symfony Mailer adjusters (highest weight).
- Reroute Symfony Mailer messages while preserving original To/Cc/Bcc as X-Rerouted headers.
- Add rerouting to a decoupled/HTML-email setup built on Symfony Mailer.
