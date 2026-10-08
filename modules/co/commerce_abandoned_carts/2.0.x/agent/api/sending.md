<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How reminders are sent (cron, query, template)

All sending logic is in `commerce_abandoned_carts_cron()` (`commerce_abandoned_carts.module`).
There is no service, no Drush command, and no "send now" UI — it runs on `hook_cron()`.

## Selection query

Selects from `commerce_order` (LEFT JOIN the module's `commerce_abandoned_carts` table, JOIN
`commerce_order_item`) rows where:

- `o.mail` is not empty (customer reached the email step of checkout),
- `a.status IS NULL` (no reminder recorded yet for this order),
- `o.changed <= now - timeout*60` (idle at least *timeout* minutes),
- `o.changed >= now - history_limit*60` (not older than *history limit* minutes),
- `o.state = 'draft'` (still a cart, not placed).

If **Commerce Recurring** is enabled, order items of type `recurring_product_variation` are
excluded. Results are grouped by order and ordered oldest-first; at most `batch_limit` mails
are sent per run.

## Sending

For each selected order the module builds a render array with the `commerce_abandoned_carts_email`
theme hook and calls `\Drupal::service('commerce.mail_handler')->sendMail($recipient, $subject, $body, $params)`.
Sender resolution: `from_email`/`from_name` if set, else the order's store email/name, else
the site email. Recipient is the customer's `mail` — **unless test mode is on**, in which case
it is `testmode_email`. The email is rendered in the customer's preferred language (or the site
default for anonymous customers).

## Test mode vs live

- `testmode = true` (default): every mail goes to `testmode_email`; the order is **not**
  written to the `commerce_abandoned_carts` table, so the same carts are re-sent every run
  (useful for template tuning). If `testmode` is on but `testmode_email` is empty, cron
  aborts with a log notice.
- `testmode = false`: mail goes to the customer, and a row is `MERGE`d into
  `commerce_abandoned_carts` (`status = 1`, `timestamp = now`) so it is never re-sent.

Each run logs `Sent @num abandoned cart emails.`

## Theme hooks / template

```php
// hook_theme()
'commerce_abandoned_carts_email' => [
  'variables' => ['order' => NULL, 'order_number' => NULL, 'site_name' => NULL, 'phone' => NULL],
],
```

Override the message by copying `templates/commerce_abandoned_carts_email.html.twig` from the
module into your theme and editing it (then `drush cr`). Available variables: `order`,
`order_number`, `site_name`, `phone`.
