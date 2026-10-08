<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Email lets you define, through the admin UI, extra emails that Drupal Commerce sends in response to store events (order placed, order paid, an order workflow transition, checkout registration, etc.), with token-replaced subject/body, recipient rules, conditions, and optional queued sending.

---

Each email is a `commerce_email` config entity (managed at `/admin/commerce/config/emails`) that ties an **email event** plugin to a message. The `commerce_email_event` plugin type (manager `plugin.manager.commerce_email_event`, base `EmailEventBase`) maps each business event to a Symfony event name — shipped plugins include `order_placed` (`commerce_order.place.post_transition`), `order_paid` (`commerce_order.order.paid`), `checkout_register`, `checkout_completion_register`, a derived `order_transition:*` per order-workflow transition, and (with Commerce Recurring) `commerce_recurring_payment_declined`. An `EmailSubscriber` listens on kernel request, registers a listener for every event referenced by a plugin, and when one fires it loads all enabled emails for that event, checks each email's inline **conditions** (`applies()`), and sends. Recipients are set per email: a `from`, a `toType` of `email` (a literal/token address in `to`) or `role` (all users with `toRole`), plus optional `cc`, `bcc`, and `replyTo`. Subject and body support **token** replacement (`[commerce_order:*]`, etc.) via the `commerce.mail_handler`. Sending is immediate by default or, if `queue` is on, deferred to the `commerce_email_queue` queue (an Advanced Queue `commerce_email` queue when the `advancedqueue` module is present, otherwise core Queue on cron). Optionally `logToEntity` records each send to the order via Commerce Log, and there is a per-email **Test email** form. The module adds one permission, `administer commerce_email`, no Drush commands, and a `commerce-email.html.twig` wrapper template.

---

- Send an order-confirmation email to the customer when an order is placed (`order_placed`).
- Send a "payment received" receipt when an order is paid (`order_paid`).
- Notify a store admin/role whenever any order is placed, using `toType: role`.
- Email the warehouse/fulfillment team when an order transitions to "fulfillment" (an `order_transition:*` event).
- Send a shipped notification on the order's "ship" workflow transition.
- Send a cancellation email when an order transitions to "canceled".
- Welcome a newly registered customer created during checkout (`checkout_register` / `checkout_completion_register`).
- BCC an accounting inbox on every order-paid email for record keeping.
- Add a Reply-To of your support address so customer replies route to the help desk.
- Use tokens (`[commerce_order:order-number]`, `[commerce_order:total-price]`) to personalize subject and body.
- Gate an email with a condition so it only sends for orders over a threshold or for a specific store.
- Restrict a promotional follow-up email to a particular order type via conditions.
- Queue high-volume emails so they send on cron via Advanced Queue instead of blocking checkout.
- Send emails immediately (queue off) for time-critical confirmations.
- Log each send to the order timeline (`logToEntity`) so staff can see which emails went out.
- Send a "payment declined" dunning email for recurring subscriptions (with Commerce Recurring).
- Duplicate an existing email definition to quickly create a variant for another event.
- Test an email's rendering and delivery with the built-in Test email form before going live.
- Send a copy of the order to a dropshipper/vendor CC address on placement.
- Configure multiple emails for the same event (e.g. one to the customer, one to admin) that all fire together.
- Localize/override the message per order type by combining event + conditions.
- Manage all store notification emails as exportable config for repeatable deployments.
- Send an internal alert to a role when an order is refunded via its workflow transition.
- Add a customer-facing "your order is complete" email on the order's completion transition.
- Route different emails to different roles (e.g. managers vs. warehouse) for the same event using separate email entities.
