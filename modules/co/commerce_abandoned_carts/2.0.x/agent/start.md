<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Abandoned Carts — agent index

Cron-driven reminder emails for abandoned Drupal Commerce carts (draft orders). Sends via
Commerce's `commerce.mail_handler`, tracks sent orders in the `commerce_abandoned_carts` DB
table, and is controlled entirely by the `commerce_abandoned_carts.settings` config object.
Depends on `commerce_checkout`. No plugins, no Drush.

- **All settings keys, the config form, permission & route, defaults** →
  [configure/settings.md](configure/settings.md)
- **How sending works: the cron query, test mode, the email template & theme hook** →
  [api/sending.md](api/sending.md)

Key facts:
- Configure at `/admin/commerce/config/abandoned_carts`
  (route `commerce_abandoned_carts.configuration`, permission `administer commerce abandoned carts`).
- **Test mode is ON by default** (`testmode: true`) — no real customer mail until you disable it.
- Sending happens in `commerce_abandoned_carts_cron()`; there is no manual "send now" action.
- Template: `commerce_abandoned_carts_email.html.twig` (theme hook `commerce_abandoned_carts_email`).
