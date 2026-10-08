<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site settings, promotional messaging & analytics

Beyond the payment gateway, the module ships an admin settings form plus several ways to advertise
Affirm's monthly-payment plan across the storefront. All messaging widgets render Affirm's own HTML
elements and rely on `affirm.js` being present (attached via `commerce_affirm/affirm`).

## Site settings form

Route `commerce_affirm.settings` → `/admin/commerce/config/affirm` (`Form/Settings`, a `ConfigFormBase`,
menu link under the Commerce payment config, guarded by `_permission: access commerce administration
pages`). Stores config object `commerce_affirm.settings` (schema in
`config/schema/commerce_affirm.schema.yml`):

| key | default | effect |
|-----|---------|--------|
| `analytics` | FALSE | Injects Affirm's tracking JS on all **non-admin** pages (`hook_page_attachments`) and enables the checkout-completion analytics pane |
| `monthly_payment_on_add_to_cart` | FALSE | Adds monthly-payment messaging to Add to Cart forms on product displays rendered in the `default` view mode |
| `link_payments_remote_id` | FALSE | Turns an Affirm payment's Remote ID in the order Payments tab into a link to that charge in the Affirm dashboard |

## Which gateway config the messaging uses

The messaging widgets need `publicKey` / `locale` / `countryCode` / `scriptUrl`, which live on the
**gateway plugin**, not the settings config. `commerce_affirm_get_gateway()` loads the first
`affirm_redirect` payment gateway (access check off) to source them. If no Affirm gateway exists, the
messaging/analytics attachments are skipped.

## Promotional widgets

- **Banner block** `commerce_affirm_banner_block` (`Plugin/Block/Banner`) — renders the
  `commerce_affirm_banner_image` theme hook at a chosen size from a fixed list (e.g. `468x60`,
  `728x90`, `300x250`, …). Config: `banner_size`.
- **Site Modal block** `commerce_affirm_site_modal_block` (`Plugin/Block/SiteModal`) — renders a
  "Learn more" style Affirm site modal; config `page_type` (from `commerce_affirm_get_page_types()`:
  category/product/cart/payment/homepage/landing/search/banner) and `link_text`.
- **Field formatter** `commerce_affirm_messaging` (`Plugin/Field/FieldFormatter/AffirmFormatter`) for
  `commerce_price` fields — renders the monthly-payment message using the price of the product variation
  or the order total, in minor units. Setting: `page_type`.
- **Views area handler** `commerce_affirm_monthly_payment_messaging`
  (`Plugin/views/area/MonthlyPaymentMessaging`) — renders the monthly-payment message for the order or
  product-variation resolved from the View's numeric argument; only renders when a valid order/variation
  is found. Setting: `page_type`.
- **Add to Cart injection** — `commerce_affirm_form_commerce_order_item_add_to_cart_form_alter()` adds
  the `commerce_affirm_monthly_payment_message` element to the add-to-cart form when
  `monthly_payment_on_add_to_cart` is on and the product is shown in the `default` view mode.

## Theme hooks & templates (`hook_theme` in `.module`)

- `commerce_affirm_banner_image` → `templates/commerce-affirm-banner-image.html.twig` (vars `width`,
  `banner_size`).
- `commerce_affirm_monthly_payment_message` → `templates/commerce-affirm-monthly-payment-message.html.twig`
  (vars `page_type`, `number`, `variation`).
- `commerce_affirm_site_modal` → `templates/commerce-affirm-site-modal.html.twig`
  (vars `link_text`, `page_type`).

`commerce_affirm_preprocess()` attaches `publicKey`/`locale`/`countryCode`/`scriptUrl` +
`commerce_affirm/affirm` to the monthly-payment and site-modal templates.

## Checkout completion analytics

Checkout pane `affirm_checkout_completion_analytics`
(`Plugin/Commerce/CheckoutPane/CheckoutCompletionAnalytics`, default step `complete`). When
`analytics` is enabled and it has not already fired for the order (order data flag
`commerce_affirm_analytics_sent`), it emits `drupalSettings.commerceAffirmAnalytics` (order id, currency,
minor-unit total, store name, payment-method label, and per-item price/product-id/quantity) and attaches
`commerce_affirm/affirm-checkout-analytics`. `js/commerce_affirm_checkout_complete.js` then calls
`affirm.analytics.trackOrderConfirmed(...)`. The flag is set so it fires once per order.

`hook_page_attachments` (with `analytics` on, non-admin routes) additionally sets a
`commerce_affirm_session_id` cookie (`uniqid`) and passes it as `sessionId` for the general tracking
library.
