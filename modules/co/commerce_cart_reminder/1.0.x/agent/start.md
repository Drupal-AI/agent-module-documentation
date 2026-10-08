<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cart Reminder (commerce_cart_reminder) — agent index

Recovers abandoned Drupal Commerce carts by **emailing customers a personalized link back to their cart**.
A cron job finds cart orders whose `changed` timestamp is older than a configurable window, sends each a
reminder email containing a **secret per-order token link**, records the send, and (optionally) deletes very
old carts. Admins can also generate the same secure link from an order to share as a **referral link**.
Package `Commerce`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.0** (version dir `1.0.x`).

## Dependencies

- Drupal modules: **`commerce_cart`** and **`token`** (both required, from `.info.yml`). Pulls in Drupal
  Commerce order/cart entities. No third-party PHP libraries.
- Config entry point: `configure: commerce_cart_reminder.settings`.

## What it provides (from source)

- **Cron engine** — `hook_cron` (`.module`) calls the service: `deleteOldCartOrders()`,
  `cleanupOrphanedReminders()`, then `processCartReminders()`. Only runs when config `active` is TRUE.
- **Service** `commerce_cart_reminder.service` (`Service/CartReminderService`) — finds abandoned cart orders
  (entity query on `cart = TRUE` + `changed <= now - reminder_time`, excluding orders already in the
  `commerce_cart_reminder` table), builds and sends the reminder mail, generates the secure link, purges old
  carts, and cleans orphaned reminder rows. Injects `config.factory`, `plugin.manager.mail`, `renderer`,
  `commerce_cart.cart_provider`, `database`, `logger.factory`, `private_key`, `entity_type.manager`.
- **Token link** — `generateCartLink()` builds
  `hash('sha256', order_id . private_key . order_created_time)` and appends it to the
  `commerce_cart_reminder.continue_cart` route. Site private key = the shared secret, so the token is not
  guessable from the order id alone.
- **Controller** `Controller/CartReminderController` — three actions:
  - `continueCart($order, $token)` → `/cart/reminder/{order}/continue/{token}`: validates state=`draft` and
    token, then assigns/merges the abandoned order's items into the current user's cart and redirects to the
    cart page.
  - `addItemsToCartFromReferral($order, $token)` → `/cart/{order}/refer/{token}`: same token, adds the order's
    items into the clicker's own cart (referral / reorder flow).
  - `showGenerateCartUrl($order)` → `/admin/commerce/order/{order}/reminder-popup` (permission-gated modal):
    renders the generated link for an admin to copy.
- **Bulk action** `Plugin/Action/CartReminder` (action id `commerce_cart_reminder`, `type: commerce_order`) —
  batch "Send cart reminder" on the carts view; gated by `access('administer commerce cart reminders')` and by
  the `enable_bulk_send_reminders` config flag. `config/install/system.action.commerce_cart_reminder.yml`.
- **Settings form** `Form/CartReminderSettingsForm` at `/admin/config/commerce/cart-reminder/settings` —
  timing, subject, rich-text body + tokens, CC/BCC, test mode, bulk toggles, delete window; validates emails
  and enforces delete window ≥ ~3× reminder window; marks embedded files permanent/temporary.
- **Mail hook** `hook_mail` (`.module`) key `reminder` — sets subject/body, optional CC/BCC headers, and
  `Content-Type: text/html`.
- **UI wiring** — `hook_form_alter` hides the bulk action off the carts view; `hook_entity_view_alter` adds a
  "Create a Cart Referral Link" AJAX modal button to the order canonical page.
- **Permission** `administer commerce cart reminders` (`.permissions.yml`). **DB table**
  `commerce_cart_reminder` (id, order_id, created — `.install`) tracks which orders were reminded.
  **Config schema** via `config/install/commerce_cart_reminder.settings.yml`.

## Solution docs

- **Reminder engine, cron, settings form, config keys, DB table** → [config/settings.md](config/settings.md)
- **Routes, token scheme, continue/referral controllers, bulk action, mail** →
  [routes/cart-links.md](routes/cart-links.md)
