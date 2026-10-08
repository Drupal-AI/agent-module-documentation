<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Custom Checkout Message adds a single Commerce checkout pane that displays an admin-authored, token-aware message at a step of the checkout flow.

---

Drupal Commerce checkout flows are built from configurable panes (login, contact info, order summary, payment, and so on), and this module contributes one more: a "Custom checkout message" pane. Each checkout flow can enable the pane, place it on any checkout step, and give it its own message body edited with a rich-text (text_format) widget. The message supports Drupal tokens — including the current `commerce_order` — so it can greet the customer, restate delivery or return terms, surface a promotion, or repeat an important reminder inline in the checkout page. The pane ships disabled by default (`default_step = "_disabled"`), provides no permissions, routes, services, entities, or Drush commands of its own, and stores its message inside the checkout flow config entity. Configuration lives entirely under Commerce's existing checkout-flow admin UI at `/admin/commerce/config/checkout-flows`.

---

- Show a custom message at a chosen step of a Commerce checkout flow.
- Display delivery or fulfilment notes to customers during checkout.
- Restate terms and conditions or return policy at the checkout step before payment.
- Surface a time-limited promotion or discount reminder inside checkout.
- Add a "thank you" or reassurance message on the checkout complete step.
- Greet the customer by name using tokens in the message body.
- Reference the current order (number, total, items) via the `commerce_order` token.
- Add cut-off / shipping-deadline notices ("order before 3pm for same-day dispatch").
- Warn about physical vs. digital delivery expectations before payment.
- Provide support or contact information partway through checkout.
- Show tax or VAT explanations relevant to the order.
- Display a legal or compliance notice on a specific checkout step.
- Run different messages on different checkout flows (e.g. B2B vs. retail).
- Place the same pane on multiple steps by enabling it per step in the flow.
- Format the message with rich text (headings, links, lists) via the text_format editor.
- Preview the configured text as an admin summary on the checkout-flow config screen.
- Toggle the message off quickly by moving the pane back to the `_disabled` region.
- Keep checkout copy in configuration (exportable) rather than in a custom block or template.
- Add a marketing upsell reminder without writing a custom pane plugin.
- Provide multilingual checkout messaging (the message value is translatable in config).
