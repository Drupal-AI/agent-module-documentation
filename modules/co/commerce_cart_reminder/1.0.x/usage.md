<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recovers abandoned Drupal Commerce carts by emailing customers a personalized, token-secured link that restores their cart, with cron automation, bulk sending, test mode, and auto-cleanup of stale carts.

---

Commerce Cart Reminder targets lost sales from abandoned carts. On each cron run (when enabled) it finds cart orders that have been idle longer than a configurable window, and emails the customer a reminder built from an admin-controlled rich-text template with `[user:name]`, `[user:mail]`, and a secure `[cart:link]` token. Clicking that link validates a per-order token (a SHA-256 hash of the order id, the site private key, and the order creation time) and restores the cart into the visitor's session — assigning the order if they have no cart, or merging its items if they do — then redirects to the cart page. A tracking table records which orders were reminded so each is emailed only once. The module also deletes very old cart orders during cron to keep the database tidy, cleans up orphaned tracking rows, offers CC/BCC monitoring copies, a test mode that diverts all mail to one address, a bulk "Send cart reminder" action on the Commerce carts view, and an admin-generated referral link (the same token URL) that pre-fills any clicker's cart with an order's items for reorders and promotions. It depends on Commerce Cart and Token, adds the `administer commerce cart reminders` permission, and runs on Drupal 10 and 11.

---

- Automatically email customers who leave items in their cart without checking out.
- Send the reminder a configurable number of hours after the cart goes idle (`reminder_time`).
- Personalize the subject and rich-text body with `[user:name]`, `[user:mail]`, and `[cart:link]` tokens.
- Give each cart a secure, token-signed restore link that works on any browser or device.
- Restore an abandoned cart into a logged-in or anonymous visitor's session in one click.
- Merge an abandoned cart's items into a visitor's existing cart instead of overwriting it.
- Track reminded orders in a database table so each cart is only reminded once.
- Optionally resend reminders in bulk to carts that already received one.
- Send reminders in bulk from the Commerce carts view via the "Send cart reminder" action.
- Divert all reminder mail to a single test address with test mode before going live.
- Copy every reminder to an admin address via CC and/or BCC for monitoring.
- Automatically delete stale cart orders after a configurable window (`delete_cart_time`, `0` disables).
- Enforce that the delete window is safely longer than the reminder window at config-save time.
- Generate a shareable secure referral link from any order's detail page.
- Let a referral link pre-fill any clicker's cart with that order's items for reorders or bundles.
- Run entirely from Drupal cron — no queue or external scheduler required.
- Manage everything from one settings form at `/admin/config/commerce/cart-reminder/settings`.
- Restrict configuration and bulk sending to the `administer commerce cart reminders` permission.
- Send HTML emails rendered through a chosen text format.
- Keep the reminder tracking table clean by purging rows for orders that no longer exist.
