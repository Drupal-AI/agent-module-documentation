# How SMTP delivers mail (Mail plugin)

SMTP does not define a new plugin type — it provides a core **Mail** plugin,
`Drupal\smtp\Plugin\Mail\SMTPMailSystem` (id `SMTP`), that wraps the bundled
`phpmailer/phpmailer` library.

- When `smtp.settings.smtp_on` is true, the module makes `SMTPMailSystem` the active mail
  backend (saving the prior one in `prev_mail_system`). `format()` and `mail()` build and send
  each message through an authenticated PHPMailer connection using the configured host, port,
  protocol, and credentials.
- To use SMTP for **some** mail only, install `drupal/mailsystem` and assign the `SMTP` plugin
  to specific modules/keys there instead of enabling it globally.
- `smtp_reroute_address`, when set, forces every message's recipient to that address (staging
  safety) inside the plugin.
- Connection health can be checked with the `Drupal\smtp\ConnectionTester\ConnectionTester`
  service (used by the settings form's test-email button).

Most sites need no code — configure via [configure/settings.md](../configure/settings.md).
