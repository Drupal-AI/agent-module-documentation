Reroute Email intercepts every outgoing email a Drupal site sends and reroutes it to one or more predefined test addresses (or aborts it), so mail from a non-production copy never reaches real users.

---

Reroute Email implements `hook_mail_alter()` (forced to run last, and after `queue_mail` if present) to catch all outgoing messages and rewrite their recipients. When rerouting is enabled, each message's To/Cc/Bcc is replaced with the configured rerouting address (falling back to `system.site` mail if the address is left empty; if the address resolves to an empty string the email is aborted instead of sent). Behavior is driven by the `reroute_email.settings` config object: `enable` turns rerouting on, `address` holds the destination address list, `allowed` is an allowlist of addresses/domains/patterns (e.g. `*@example.com`) that pass through unchanged, and `roles` exempts mail belonging to users with those roles. Two mail-key filters (`mailkeys` to reroute only listed keys, `mailkeys_skip` to exempt listed keys) let you target specific modules or message keys. `message` shows a Drupal status message on reroute, and `description` prepends an explanatory block (original To/Cc/Bcc, site URL, mail key) into the email body. Rerouted messages are logged with a full variable dump, and X-Rerouted-* headers record status and original recipients; a custom `X-Rerouted-Force` header can force or skip rerouting per message. All settings can be overridden in `settings.php`, and a Test Email form (`/admin/config/development/reroute_email/test`) helps verify the setup. The rerouting logic is a pluggable `RerouteEmailHandler` plugin type; the bundled `reroute_email_symfony_mailer` submodule adds a handler for the Symfony Mailer transport.

---

- Reroute all outgoing mail from a staging/test copy of a live site to a single QA inbox.
- Prevent password-reset, order, and notification emails on a dev site from reaching real users.
- Abort all outgoing email entirely by enabling rerouting with an empty address.
- Send test-site mail to a shared team address list (comma/space/semicolon/newline separated).
- Allowlist your own domain (`*@example.com`) so internal addresses still receive real mail.
- Allowlist a specific address or a `name+*@example.com` pattern to pass certain mail through.
- Exempt users with a given role (e.g. administrator) from rerouting via the `roles` setting.
- Reroute only mail from specific modules/keys using the `mailkeys` filter.
- Reroute everything except a few mail keys using the `mailkeys_skip` filter.
- Enable rerouting per-environment by setting `enable`/`address` in `settings.php`.
- Keep production safe by hard-disabling rerouting (`enable = FALSE`) in the live `settings.php`.
- Inspect outgoing email formatting, footers, and headers by capturing them in one inbox.
- Review the full email variable dump in the log to debug what a module actually sends.
- Show editors a status message whenever an email was rerouted (`message` setting).
- Prepend original-recipient details into the rerouted body for traceability (`description`).
- Send a test message from the built-in Test Email form to confirm rerouting works.
- Verify Cc and Bcc handling — original Cc/Bcc are stripped and preserved as X-Rerouted headers.
- Force a single message to always reroute by adding an `X-Rerouted-Force: TRUE` header.
- Force a single message to never reroute by adding an `X-Rerouted-Force: FALSE` header.
- Configure rerouting from an automated deploy script with `drush config:set`.
- Ensure queued mail (`queue_mail` module) is still rerouted after dequeue.
- Route mail with invalid recipient addresses to the test inbox instead of dropping silently.
- Add a custom rerouting handler by implementing the `RerouteEmailHandler` plugin type.
- Reroute mail sent through the Symfony Mailer transport via the bundled submodule.
- Gate access to the settings and test forms with the `administer reroute email` permission.
