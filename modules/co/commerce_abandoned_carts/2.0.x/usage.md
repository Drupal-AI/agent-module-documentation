<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Abandoned Carts automatically emails customers who left a Drupal Commerce cart (a draft order) without completing checkout, reminding them to finish their purchase.

---

The module works entirely from `hook_cron()`. On each cron run it queries `commerce_order` for **draft** orders that have line items, have a customer email set (`mail`), were last changed more than *timeout* minutes ago but no longer than *history limit* minutes ago, and have not already been notified (tracked in the module's own `commerce_abandoned_carts` database table, keyed by `order_id`). It then sends a reminder email through Drupal Commerce's `commerce.mail_handler` service, rendered with the `commerce_abandoned_carts_email` theme hook (override the `commerce_abandoned_carts_email.html.twig` template to customise the message). All behaviour is controlled by the `commerce_abandoned_carts.settings` config object, editable at *Commerce → Configuration → Abandoned carts* (`/admin/commerce/config/abandoned_carts`, permission `administer commerce abandoned carts`): send timeout, history limit, batch limit (max mails per cron run), from name/email, subject, a customer-service phone number for the template, optional BCC, and **test mode**. Test mode is **on by default** and redirects every message to a single test address without marking orders as sent, so nothing reaches real customers until you turn it off. When the Commerce Recurring module is present, recurring subscription draft orders are excluded. There is no plugin type, no Drush command, and no queue (batching is a simple per-run cap).

---

- Recover lost revenue by reminding shoppers who abandoned a cart to complete checkout.
- Send a follow-up email a configurable number of minutes after a cart goes idle.
- Limit how far back the module looks for abandoned carts (history limit) to avoid old carts.
- Cap the number of reminder emails sent per cron run (batch limit) for performance.
- Safely dry-run the feature in test mode, routing all mail to one test inbox.
- Customise the reminder subject line from the settings form.
- Set a dedicated From name and From address for reminder emails.
- Include a customer-service phone number in the email for shoppers who had checkout trouble.
- BCC an internal monitoring mailbox on every reminder for oversight.
- Override the email body by copying `commerce_abandoned_carts_email.html.twig` into your theme.
- Fall back to the store's (or site's) email address as the sender when none is configured.
- Localise the reminder to the customer's preferred language automatically.
- Trigger sends on a schedule by relying on Drupal cron (e.g. hourly via a real cron job).
- Exclude subscription/recurring draft orders when Commerce Recurring is installed.
- Track which orders were already notified so customers are not emailed twice.
- Gate access to the configuration form with the `administer commerce abandoned carts` permission.
- Tune the "abandoned" threshold per store policy (e.g. 1 day, 3 days).
- Re-send test emails repeatedly while tuning the template (test mode never marks as sent).
- Integrate cart recovery without writing custom code or adding a marketing SaaS.
- Use the phone-number field to reduce support friction for stuck buyers.
- Monitor send volume via the module's cron log message ("Sent N abandoned cart emails.").
- Combine with a real mail transport (SMTP/Symfony Mailer) for reliable delivery.
