Easy Email Commerce bridges Easy Email and Drupal Commerce, adding order-aware email tokens and declaring the Commerce order-receipt email so you can send Commerce order emails from Easy Email templates.

---

Easy Email Commerce is a thin integration submodule (depends on `easy_email`, `commerce_order`, and `commerce_price`). It registers a set of new `commerce_order` tokens — `[commerce_order:easy_email_html]`, `[commerce_order:easy_email_plain]`, plus order-items, billing-profile, shipping-profile, payment-method, and totals variants in both HTML and plain-text — each rendered from a Twig template designed to look right inside an email. It implements `hook_token_info_alter()`, `hook_tokens()`, and `hook_theme()` to provide those tokens and their templates. It also declares a `commerce.order_receipt` email (via an `emails.yml` plugin, `key: order_receipt`, param `order` of type `entity:commerce_order`) that the `easy_email_override` submodule can use to replace Commerce's built-in order receipt with an Easy Email template. Typical use: add an entity-reference field to an order on an Easy Email template (or use the override system), then drop the order tokens into the HTML/plain body to render the order summary, line items, addresses, payment method, and totals. It defines no entities, permissions, routes, or services of its own — it is purely tokens plus the declared receipt email.

---

- Send a Commerce order confirmation / receipt as an HTML email via an Easy Email template.
- Render a full order summary in an email with `[commerce_order:easy_email_html]`.
- Render the order in plain text with `[commerce_order:easy_email_plain]`.
- Insert just the order items table with the order-items HTML/plain tokens.
- Show the billing address in an email with the billing-profile token.
- Show the shipping address in an email with the shipping-profile token.
- Display the payment method used with the payment-method token.
- Show order totals (subtotal, adjustments, total) with the totals token.
- Override Commerce's built-in order receipt with an Easy Email template (with easy_email_override).
- Attach an order-derived PDF or file to a receipt email using Easy Email attachments + order tokens.
- Build a fully branded HTML order confirmation instead of Commerce's default receipt.
- Reference an order via an entity-reference field on the template and address the email to its owner.
- Produce both an HTML and a matching plain-text body for order emails.
- Send different order emails per order state/workflow using separate templates.
- Customize the order-rendering Twig templates by overriding the module's email theme hooks.
- Reuse the declared `order_receipt` email definition as an override target in code.
