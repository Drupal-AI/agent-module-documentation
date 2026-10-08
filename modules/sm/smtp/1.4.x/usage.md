The SMTP Authentication Support module routes all of Drupal's outgoing email through an external SMTP server of your choice (Gmail, SendGrid, Mailgun, Office 365, a corporate relay, etc.) instead of the local PHP mail function, using the bundled PHPMailer library.

---

By default Drupal hands mail to PHP's `mail()`, which is unreliable and often lands in spam. SMTP replaces Drupal's mail system with a PHPMailer-based backend (a `Mail` plugin, `SMTPMailSystem`) that connects to a configured SMTP host and authenticates with a username and password. You configure the host, backup host, port, encryption protocol (standard/SSL/TLS with optional AutoTLS), timeout, credentials, and default From address/name at Admin → Configuration → System → SMTP Authentication Support. It supports keep-alive connections, HTML email, connection debugging with adjustable verbosity, a built-in "send a test email" tool, and a reroute address that redirects all mail to one inbox (handy for staging). When enabled it stores the previous mail system so it can be restored if you turn SMTP off. It can be used on its own to capture all site mail, or combined with the Mailsystem module to apply SMTP selectively. It is the standard way to get reliable, authenticated transactional email out of a Drupal site.

---

- Send all site email through Gmail / Google Workspace SMTP.
- Relay mail through SendGrid, Mailgun, Postmark, or Amazon SES SMTP.
- Use a corporate/Office 365 SMTP relay for outgoing mail.
- Improve deliverability so messages avoid the spam folder.
- Authenticate outgoing mail with a username and password.
- Encrypt mail transport with TLS or SSL.
- Enable AutoTLS to opportunistically upgrade the connection.
- Configure a backup SMTP host for failover.
- Set a custom port (25, 465, 587, …).
- Set a site-wide default From address and name.
- Send a test email to verify the configuration.
- Reroute all outgoing mail to one address on a staging site.
- Turn on SMTP debugging to diagnose delivery failures.
- Allow HTML-formatted email bodies.
- Keep the SMTP connection alive across multiple messages.
- Restore the previous mail system by disabling SMTP.
- Combine with Mailsystem to use SMTP for only some mail.
- Deliver user registration and password-reset emails reliably.
- Send Webform or Contact form notifications via SMTP.
- Send commerce order confirmations through a transactional provider.
- Adjust the debug verbosity level for troubleshooting.
- Set a custom client hostname / HELO string for the SMTP handshake.
- Configure a connection timeout to fail fast on a dead host.
