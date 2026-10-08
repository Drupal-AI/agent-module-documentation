<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailjet routes Drupal's outbound email through the Mailjet platform and adds an optional marketing suite — contact lists, subscription forms, campaigns, delivery events and statistics — as submodules.

---

The base module registers a `mailjet_mail` mail plugin that sends Drupal's mail through Mailjet's SMTP relay (using the bundled **PHPMailer**), and it talks to the **Mailjet REST API v3** (composer library `mailjet/mailjet-apiv3-php`) to hold your API key and secret, keep a "Drupal contact list" in sync with your site's users, and reconcile user `field_*` values into Mailjet contact properties. You connect the site at `/admin/config/system/mailjet`: enter the **API Key and Secret Key** on the API tab, then tick **"Send emails through Mailjet"** to set `system.mail:interface.default` to `mailjet_mail`. User create/update/delete hooks push contacts to Mailjet immediately, and a cron **queue worker** (`sync_mailjet_contact`) can do the same asynchronously. The seven submodules widen the scope well beyond mail transport, so enable only what you need: **mailjet_list** shows your Mailjet contact lists, **mailjet_subscription** provides front-end newsletter sign-up forms with a double-opt-in confirmation step, **mailjet_campaign** records campaigns, **mailjet_event** receives Mailjet's open/click/bounce/spam/blocked/unsub callbacks and exposes them as Rules events, **mailjet_stats** shows a statistics dashboard, **mailjet_commerce** ties campaigns to Drupal Commerce orders, and **mailjet_trigger_examples** ships example triggered-email Views and Message templates. Requirements are `mailjet/mailjet-apiv3-php ^1.5`, `phpmailer/phpmailer ^6.0.7` and `guzzlehttp/guzzle ^7.0`, with core `^9 || ^10 || ^11`; PHPMailer must be present or install is blocked by a requirements check. Because contact lists carry personal data, syncing subscribers to Mailjet is a data-processing arrangement that needs a lawful basis and a processor agreement, and the API key and secret are live account credentials best supplied from an environment variable or Key entity rather than committed config.

---

- Send Drupal's transactional email through Mailjet.
- Improve deliverability over the local PHP mailer.
- Store the Mailjet API key and secret for the site.
- Sync Drupal users into a Mailjet contact list automatically.
- Map user fields to Mailjet contact properties.
- Sync contacts asynchronously on cron via the queue worker.
- Send a test email to verify the connection.
- Add a front-end newsletter subscription form (block).
- Run a double opt-in confirmation flow for sign-ups.
- Manage which email events Mailjet reports back.
- Receive open, click, bounce, spam, blocked and unsubscribe events.
- Trigger Rules reactions from Mailjet events.
- View Mailjet contact lists from the Drupal admin.
- View a Mailjet statistics dashboard.
- Record campaigns as Drupal entities.
- Tag Commerce orders with the originating campaign.
- Set up triggered marketing emails (abandoned cart, purchase anniversary).
- Segment subscribers by Mailjet list.
- Replace SMTP configuration with a managed relay.
- Send HTML or plain-text mail depending on a setting.
- Keep contact lists clean by honouring unsubscribes.
- Support a marketing team's workflow inside Drupal.
