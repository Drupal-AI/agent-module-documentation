<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Stock Notifications — agent index

Adds a **"notify me when back in stock"** feature to Drupal Commerce. When a product variation is
out of stock, `hook_form_alter` replaces the Add-to-cart button with a disabled "Out of stock" button
and injects an email field; the shopper submits their address to be emailed when the variation is
restocked. Requests are stored as `commerce_stock_notification` content entities. `hook_cron` scans
them on every run: variations that are back in stock get queued and mailed (queue worker), and old
already-sent records get purged after a configurable interval.

Depends on `commerce:commerce`, `commerce:commerce_cart`, `commerce:commerce_product`,
`commerce_stock:commerce_stock`, `commerce_stock:commerce_stock_field`, and `token:token`.
Version **1.0.x** (dev, 8.x-1.x branch), core `^8.8 || ^9 || ^10 || ^11`, PHP 7.0+. No Drush commands,
no JS, no libraries. Sponsored by Studio Present.

- **Cron → queue → mail send flow, entity fields, and the purge cycle** → [notify-flow.md](notify-flow.md)

## How subscribing works

There is no standalone subscribe route. `commerce_stock_notifications_form_alter()`
(`*.module`) targets any form whose id contains both `add` and `cart` (the Commerce add-to-cart form),
resolves the selected/default product variation, and if `commerce_stock_notifications_check_stock()`
returns false:
- Builds the `commerce_stock_notifications` **Commerce inline form** (`Plugin/Commerce/InlineForm/Notification.php`)
  into `$form['commerce_stock_notifications']`, passing `variation_id` via plugin configuration.
- Sets the add-to-cart submit button to `t('Out of stock')` and `#disabled = TRUE`.

`commerce_stock_notifications_check_stock(ProductVariationInterface $variation)` uses
`commerce_stock.service_manager` — returns true if the variation is flagged always-in-stock, or if the
stock level ≥ minimum required (1, or the variation's `minimum_order_quantity` when
`commerce_product_limits` is installed).

`commerce_stock_notifications_module_implements_alter()` reorders this module's `form_alter` to run
last so the button/inline-form changes stick.

### Inline form (`Notification`)
- `buildInlineForm()` — a fieldset titled with the configured `oos_message`, a required `notify_email`
  textfield defaulting to the current user's account email, and a "Notify me" submit whose submit
  handler is a no-op (`preventParentSubmit`) with `#limit_validation_errors` scoped to the inline form,
  so it does not trigger the add-to-cart handler.
- `validateInlineForm()` — requires the `create commerce stock notification` permission, validates the
  address with the `email.validator` service, and rejects duplicates
  (`email == X AND product_id == variation AND sent_time IS NULL`) with the configured
  `duplicate_message`.
- `submitInlineForm()` — creates a `commerce_stock_notification` entity (`user_id` = current user,
  `product_id` = variation id, `submit_time` = request time, `email` = submitted value) and shows the
  configured `success_message`.

Submission runs through the add-to-cart form (Drupal Form API), so the standard form-token flow
applies. The email field is a textfield prefilled with the current user's account email.

## Routes / entry points (`*.routing.yml`)

- `entity.commerce_stock_notification.edit_form` — `/admin/structure/commerce_stock_notification`,
  `_entity_list` of the entity (admin subscription list). Access: `administer commerce stock
  notifications`. (Route id is misleading — it renders the list, via `StockNotificationListBuilder`.)
- `commerce_stock_notifications.admin_config_form` — `/admin/commerce/config/stock/stock-notifications`,
  renders `Form\AdminConfigForm`. Access: `administer commerce stock notifications`. Menu link under
  `commerce.configuration`.
- `commerce_stock_notifications.unsubscribe` —
  `/user/{user}/stock-notifications/unsubscribe/{notification_id}`, `Controller\StockNotificationController::unsubscribe`.
  Access route requirement: `access content`. The controller then loads the notification and calls
  `$notification->access('delete')` before deleting — deletion is authorized by the entity access
  handler (owner or admin), then redirects to the user's subscriptions view.
- Entity `links`: collection + delete-form + delete-multiple-form under
  `/admin/structure/commerce_stock_notification/…` (AdminHtmlRouteProvider).
- View `list_of_subscribed_products` (config install) adds page `user/%user/stock_notifications`
  ("Stock notification subscriptions" account tab) listing the current user's own requests with an
  Unsubscribe link per row.

## Permissions (`*.permissions.yml`)

- `create commerce stock notification` — gates the inline subscribe form (checked in
  `validateInlineForm`). Grant to `anonymous` to let anonymous shoppers subscribe (README's documented
  anonymous use case); anonymous subscribers cannot self-unsubscribe.
- `administer commerce stock notifications` — the entity `admin_permission`; gates the admin list,
  config form, entity settings, and entity `view` operation.

## Entity: `commerce_stock_notification`

Content entity (`src/Entity/StockNotification.php`), base table `commerce_stock_notification`,
implements `EntityOwnerInterface`. Handlers: `StockNotificationListBuilder`, `StockNotificationViewsData`,
`StockNotificationAccessControlHandler`, `AdminHtmlRouteProvider`, core `ContentEntityDeleteForm`.
Base fields: `user_id` (owner, entity ref user), `email` (string, required), `product_id` (entity ref
**commerce_product_variation** despite the name, required), `submit_time` (created), `sent_time`
(timestamp, null until mailed). `getEmail()/setEmail()` accessors.

Access handler (`checkAccess`): `view` = admin permission; `delete` = admin permission OR
(non-anonymous AND current uid == owner uid); default (create/update) = allowed (create is separately
gated by the `create commerce stock notification` permission in the form).

## Configuration (`commerce_stock_notifications.config`)

Simple config edited by `AdminConfigForm`; schema in `config/schema/`. Keys (all Token-enabled for
`user` + `commerce_product_variation`): `email_subject`, `email_body`, `oos_message` (on-form prompt),
`success_message`, `duplicate_message`, `purge_interval` (days sent records are kept; validated > 0,
default 30). Defaults live in `AdminConfigForm::getDefaults()`; `getValuesFromConfig()` merges stored
values over defaults. `update_9001` renamed the old `…adminconfig` object to `…config`.

## Key facts

- Sends are **not immediate** — they happen on the next cron run after the variation is back in stock;
  see [notify-flow.md](notify-flow.md).
- `hook_mail` key `commerce_stock_notifications.notify` sends `text/html`, from = `system.site` mail,
  subject/body from the token-replaced config, recipient = the stored subscriber email.
- Two cron queues: `commerce_stock_notifications` (notify, 120s) and
  `commerce_stock_notifications_cleanup` (purge, 240s).
- Recommended companion: Swift Mailer (for HTML email). `token` is a hard dependency.
- Data collected: subscriber email addresses (PII) stored per subscription; purge only removes records
  whose notification has already been sent, after `purge_interval` days.
