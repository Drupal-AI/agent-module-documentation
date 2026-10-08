# Configure — Commerce order emails with Easy Email

Submodule of `easy_email`. Requires `easy_email`, `commerce_order`, `commerce_price`.
It adds order tokens + declares the order-receipt email. No config UI of its own
(`configure` is null); you configure it through Easy Email templates / overrides.

## What it provides

### 1. `commerce_order` email tokens
Registered via `hook_token_info_alter()` + `hook_tokens()` (rendered by Twig templates via
`hook_theme()`). Use these inside any Easy Email template field:

| Token | Renders |
|---|---|
| `[commerce_order:easy_email_html]` | Whole order, HTML for email |
| `[commerce_order:easy_email_plain]` | Whole order, plain text |
| `[commerce_order:easy_email_order_items_html]` / `_plain` | Order items table |
| `[commerce_order:easy_email_billing_profile_html]` / `_plain` | Billing address |
| `[commerce_order:easy_email_shipping_profile_html]` / `_plain` | Shipping address |
| `[commerce_order:easy_email_payment_method_html]` / `_plain` | Payment method |
| `[commerce_order:easy_email_totals_html]` / `_plain` | Order totals |

### 2. Declared order-receipt email (`emails.yml`)
`commerce.order_receipt` — `label: 'Commerce Order: Order receipt'`, `module: commerce`,
`key: order_receipt`, param `order` (`entity:commerce_order`). This makes Commerce's order
receipt an **override target** for the `easy_email_override` submodule.

## Usage patterns

**A. Override Commerce's receipt (recommended):** enable `easy_email_override`, create an
`easy_email_type` template, then add an override mapping the `commerce.order_receipt` email to
your template (mapping the `order` param). Use the order tokens above in the body. See the
`easy_email_override` docs.

**B. Standalone template:** add an entity-reference field to a `commerce_order` on your
`easy_email_type` template, then use the order tokens in subject/body and send via the
`easy_email.handler` service (see the main easy_email api doc).

## Theming
The order-rendering Twig templates live in `templates/easy-email-commerce-*.html.twig`
(theme hooks like `easy_email_commerce_order_html`). Override them in your theme to restyle the
rendered order, items, addresses, payment, and totals.
