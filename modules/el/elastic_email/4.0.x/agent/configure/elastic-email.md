<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Elastic Email

## 1. Enable
`drush en elastic_email -y` (pulls in `mailsystem`). The Elastic Email PHP SDK is a Composer
dependency of the module.

## 2. Enter credentials
Go to `/admin/config/system/elastic_email/settings` (permission: `administer site configuration`):
- **API username** → `username`
- **API Key** → `api_key` (account API key from the Elastic Email dashboard)
- **Queue outgoing messages** → `queue_enabled` (deliver on cron via the queue worker)
- **Log message delivery success** → `log_success`
- **Low Credit Threshold (USD)** → `credit_low_threshold`
- **Use a Default Channel / Default Channel** → `use_default_channel` / `default_channel`
- **Use a Specific Reply To / Reply To Email / Name** → `use_reply_to` / `reply_to_email` / `reply_to_name`

Set via drush config instead:
```
drush cset elastic_email.settings api_key 'YOUR_KEY' -y
drush cset elastic_email.settings username 'YOUR_USER' -y
```

## 3. Wire up Mailsystem
The module only sends mail when Mailsystem points at its plugin. At
`/admin/config/system/mailsystem` set the site-wide (or a per-module) **Formatter** and
**Sender** to **Elastic Email** (`elastic_email_mailsystem`).

## 4. Test
Visit `/admin/config/system/elastic_email/test` (only available once settings validate) and send
a probe message; check the dashboard at `/admin/config/system/elastic_email` for credit/account
status. With queueing on, run `drush cron` to flush the queue.

## Programmatic send
```php
\Drupal::service('elastic_email.api')->sendEmail(
  $subject, $from, $reply_to, ['to@example.com'], $channel, $body_html, $body_plain
);
```
