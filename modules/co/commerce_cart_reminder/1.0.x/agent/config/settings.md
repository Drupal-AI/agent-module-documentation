<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reminder engine, cron, settings & storage

## Config object `commerce_cart_reminder.settings`

Defaults from `config/install/commerce_cart_reminder.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `active` | `false` | Master switch. Cron does nothing until TRUE. |
| `reminder_time` | `24` | Hours of cart inactivity (`changed`) before a reminder is sent. |
| `delete_cart_time` | `72` | Hours after which stale cart orders are deleted (`0` disables). |
| `email_subject` | `Complete your purchase!` | Reminder subject. |
| `email_body` | HTML template | Body; supports `[user:name]`, `[user:mail]`, `[cart:link]`. |
| `email_body_format` | `basic_html` | Text format the body is rendered through. |
| `bcc_active` / `bcc_email` | `false` / `''` | Optional BCC recipient. |
| `cc_active` / `cc_email` | (unset) / — | Optional CC recipient (form-managed). |
| `testmode` / `testmode_email` | `false` / `''` | Divert ALL reminders to one test address. |
| `enable_bulk_send_reminders` | `false` | Expose the bulk "Send cart reminder" action. |
| `resend_reminders` | `false` | In bulk mode, also target orders already reminded. |

## Settings form `Form/CartReminderSettingsForm`

Route `commerce_cart_reminder.settings` (`/admin/config/commerce/cart-reminder/settings`), permission
`administer commerce cart reminders`. Extends `ConfigFormBase`.

- Body is a `text_format` element; tokens are simple `str_replace` placeholders (not the Token API render).
- `validateForm()`: requires `delete_cart_time` to be `0` or ≥ `max(48, reminder_time + 24)` so carts are not
  deleted before their reminder window; validates CC/BCC/test emails via `email.validator` (CC/BCC accept a
  comma-separated list, test mode a single address).
- `submitForm()`: diffs `data-entity-uuid="…"` references in the old vs new body and flips embedded files
  between permanent/temporary (`extractFileIdsFromText()`), then saves config.

## Cron path (`hook_cron` → `CartReminderService`)

`commerce_cart_reminder_cron()` runs three steps every cron:

1. **`deleteOldCartOrders()`** — if `active` and `delete_cart_time` > 0, entity-query `cart = TRUE` and
   `changed < now - delete_cart_time`, then `storage->delete()` those orders.
2. **`cleanupOrphanedReminders()`** — removes `commerce_cart_reminder` rows whose `order_id` is no longer a
   valid cart order (keeps the tracking table from growing).
3. **`processCartReminders()`** — returns immediately unless `active`. Entity-query `cart = TRUE` and
   `changed <= now - reminder_time`, **excluding** order ids already present in the `commerce_cart_reminder`
   table (`NOT IN`), so each cart is reminded once. For each order calls
   `sendCartReminderEmailForOrder($order, $testmode_email)`.

All entity queries use `accessCheck(FALSE)` (system/cron context).

## `sendCartReminderEmailForOrder()`

- Resolves recipient: if the order has a customer uid, loads the user's email + display name; otherwise falls
  back to the order email and the billing profile's given/family name. Bails silently if no email.
- Builds the link with `generateCartLink()`, substitutes the three tokens into the body, renders the body via
  `renderer->renderPlain()` using `email_body_format`.
- Sends through `plugin.manager.mail` (key `reminder`); adds CC/BCC params when enabled; `testmode` overrides
  the recipient with `testmode_email` (and logs the rendered body at debug level).
- Inserts a row into `commerce_cart_reminder` (`order_id`, `created = time()`) to mark the send.

## Storage `commerce_cart_reminder` (`.install`)

`hook_schema` table: `id` (serial PK), `order_id` (int, indexed), `created` (int timestamp). Pure
send-tracking ledger — no tokens or PII stored.
