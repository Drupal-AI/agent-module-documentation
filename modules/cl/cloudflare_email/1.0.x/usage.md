<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Email sends Drupal's outbound mail through the Cloudflare Email Service REST API instead of local SMTP/sendmail.

It provides a Mail plugin (`Plugin/Mail/CloudflareEmail`) and a Symfony-Mailer transport (`CloudflareApiTransport`) that convert a Drupal message to the Cloudflare payload (`DrupalMessageToEmailConverter`, `CloudflareEmailSerializer`) and POST it to `https://api.cloudflare.com/.../email/sending/send` over HTTPS with a bearer token. The API token is never stored in module config directly — it is resolved through a required Key entity (`key` dependency, `key.repository`), keeping the secret out of exported configuration. A sandbox mode logs instead of sending; a queue worker supports deferred delivery; the client fails with typed exceptions distinguishing transient (429/5xx) from permanent errors. Submodules add delivery analytics (with its own report route/permission) and a Symfony Mailer Lite transport. Configuration is at `/admin/config/system/cloudflare-email` behind `administer cloudflare email` (restricted). The module is marked experimental.

Use it to route transactional and site mail through Cloudflare's email API with the credential held in a Key entity rather than in code or config.
---
Sends Drupal outbound mail via the Cloudflare Email Service REST API, with the token held in a Key entity.
---
- Route all site email through the Cloudflare Email API
- Store the API token in a Key entity (not in config)
- Send transactional email over HTTPS with a bearer token
- Enable sandbox mode to log mail instead of sending
- Queue outbound mail for deferred delivery
- Distinguish transient (429/5xx) from permanent send errors
- Configure the Cloudflare account ID and token key
- Use as the site-wide Mail plugin
- Integrate as a Symfony Mailer transport
- Add delivery analytics via the analytics submodule
- View per-recipient delivered/queued/bounced outcomes in logs
- Send test mail via Drush
- Keep the API secret out of exported configuration
- Handle permanent bounces with a warning log
- Swap mail backends per environment
- Restrict configuration behind "administer cloudflare email"
- Provide a Symfony Mailer Lite transport option
- Report on email delivery from an admin route
