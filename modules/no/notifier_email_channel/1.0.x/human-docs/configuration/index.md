# Configuration

The email channel delivers through **Symfony Mailer**, so most of its behaviour
follows your site's existing mail configuration rather than a settings screen of
its own. There is little to configure specific to this module — the work is in
making sure Drupal can send mail and that your mail credentials are handled
safely.

## Delivery uses your site's mail transport

Notifications sent through this channel go out with the same mail transport your
Drupal site already uses for email. If ordinary Drupal email works, the email
channel has what it needs. If you route mail through an external provider (SMTP
relay, a mail API), that provider's connection details — host, username,
password, or API key — are the credentials that matter here.

## Store mail credentials as secrets — never commit them

1. Keep any SMTP/mail‑API credential in an **environment variable** set with
   DDEV's dotenv helper, so it stays out of version control:

   ```bash
   ddev dotenv set .ddev/.env --mail-password=<value>
   ddev restart
   ```

   The flag `--mail-password` becomes the environment variable `MAIL_PASSWORD`.
   Do **not** commit `.ddev/.env`.

2. Reference the variable at runtime — via a
   [Key](https://www.drupal.org/project/key) entity backed by the environment
   provider where the mail module supports one, or `getenv('MAIL_PASSWORD')` from
   `settings.php` otherwise.

## A few practical points

- Use a **secure (TLS)** connection to your mail provider so credentials and
  message content are not sent in the clear.
- Sending email means outbound requests leave your server — make sure egress to
  your mail host is allowed.
- Notification emails carry **user data** (recipient addresses and content); be
  deliberate about what each notification includes.
