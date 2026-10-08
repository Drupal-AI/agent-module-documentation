<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elastic Email routes Drupal's outgoing mail through the Elastic Email HTTP API instead of local sendmail.

---

It ships a Mail plugin (`elastic_email_mailsystem`) that hands each message to the Elastic Email PHP SDK using an account API key, so it must be wired up through the Mailsystem module as the site (or per-module) formatter/sender. A settings form at `/admin/config/system/elastic_email/settings` stores the API username, API key, an optional default channel, a reply-to override, a low-credit threshold, and toggles for queueing outgoing messages and logging delivery success. When queueing is enabled, messages are pushed to a queue and delivered by the `ElasticEmailProcessQueue` queue worker on cron rather than synchronously.

A dashboard controller renders account/credit status and lets an administrator view already-sent messages by message id; a "Test Email" form (only reachable when valid settings exist) sends a probe message. All routes are gated by `administer site configuration`. The API key is stored in module config in clear text, so treat exported config as sensitive. There are no anonymous or mutating endpoints and TLS is handled by the SDK's default HTTP client.

---
- Install and enable the module together with its Mailsystem dependency.
- Obtain an Elastic Email account API key and API username.
- Open `/admin/config/system/elastic_email/settings` and paste the API key.
- Set the Mailsystem sender/formatter to Elastic Email site-wide.
- Route a single module's mail through Elastic Email via Mailsystem overrides.
- Configure a default Elastic Email channel name for outgoing mail.
- Set a specific reply-to address and reply-to display name.
- Enable "Queue outgoing messages" so mail is sent on cron.
- Process the outgoing mail queue by running cron.
- Enable "Log message delivery success" for auditing sent mail.
- Set a low-credit (USD) threshold to warn admins when funds run low.
- View the Elastic Email dashboard for account and credit status.
- Send a test email to confirm credentials work.
- Look up a previously sent message by its Elastic Email message id.
- View the rendered content of a sent message.
- Send a transactional email programmatically via the `elastic_email.api` service.
- Fetch account info or channel statistics through the manager service.
- Rotate the API key by updating the settings form.
- Restrict Elastic Email admin access via the `administer site configuration` permission.
- Debug delivery failures via Drupal logs after a failed send.
- Use sub-account/channel reporting to segment sending statistics.
