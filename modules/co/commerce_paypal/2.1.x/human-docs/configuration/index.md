# Configuration

You configure Commerce PayPal by adding a **payment gateway** in Drupal Commerce
and choosing one of the PayPal products. There is no separate settings page for the
gateways — they use Commerce's own payment-gateway forms. This page walks through
adding a gateway, then covers the settings specific to each PayPal product.

## Add a PayPal gateway

1. Log in as a user with the **Administer commerce payment gateway** permission.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** and choose a **Plugin** — one of the PayPal products (see
   the [main guide](../index.md#the-paypal-products-gateways-it-provides)). For a
   new store, choose **PayPal Checkout**.
4. Set **Mode** to **Test** for now, so you can trial it against PayPal's Sandbox
   before going live.
5. Enter the credentials for the mode you chose (below), set the product-specific
   options, and **Save**.

Always test in **Test / Sandbox** mode first with your PayPal Sandbox credentials.
When everything works, edit the gateway, switch **Mode** to **Live**, and replace
the credentials with your live ones.

## PayPal Checkout (recommended)

The modern gateway. Key settings:

- **Client ID** and **Secret** — the REST app credentials from your PayPal
  developer account (Sandbox pair for Test mode, live pair for Live mode).
- **Intent** — whether to **Capture** the money immediately at checkout, or only
  **Authorize** it and capture later from the order's Payments tab.
- **Payment solution** — Smart Payment Buttons (the default), optionally with
  custom card fields so shoppers can pay by card without leaving your site.
- **Enable on cart** — show a "Pay with PayPal" button on the cart page as well as
  at checkout.
- **Funding / card restrictions** — hide specific funding sources (Venmo, Pay
  Later, card, etc.) or specific card brands from the buttons.
- **Button style** — layout, color, shape, and label of the Smart Payment Buttons,
  to match your storefront.
- **Shipping preference** — whether to take the shipping address from PayPal or use
  the order's address, and whether to update the customer's billing/shipping
  profiles from what PayPal returns.
- **Webhook ID** and **request logging** — set a PayPal webhook ID to receive
  asynchronous payment updates, and optionally log webhook requests for debugging.
- **Credit-card icons** — show card-brand icons next to the PayPal option at
  checkout.

## Fastlane by PayPal

A branded card form that accelerates guest checkout. It also uses a **Client ID**
and **Secret**, an **Intent**, optional **allowed card brands**, profile-update
options, a **Webhook ID**, and styling for the card form.

## Legacy gateways

Keep these only for stores that already rely on them:

- **PayPal Express Checkout** — uses **API username**, **API password**, and
  **Signature** (the classic NVP/SOAP credentials), plus shipping-prompt and
  solution-type options.
- **PayPal Payflow** — uses **Partner**, **Vendor**, **User**, and **Password** for
  a Payflow merchant account.
- **PayPal Payflow Link** — the same Payflow credentials plus transaction-type,
  redirect mode, optional **reference transactions** (for recurring-style charges),
  customer-email, and request/response **logging** options; it can present an
  embedded (iframe) hosted checkout.

## Managing payments

Once a gateway is live, you handle the money from each order's **Payments** tab in
Commerce — capture an authorized payment, refund a captured one, or void it — using
the standard Commerce order admin. No PayPal-specific screen is needed for
day-to-day operations.

## PayPal Credit / Pay Later messaging

The module adds one extra settings screen, at
`/admin/commerce/config/payment/paypal-credit`, for the PayPal Credit / Pay Later
**messaging** shown to shoppers. There is also a messaging block and a Views area
you can place to promote Pay Later options in your storefront.

## A note on testing

Creating and editing a gateway works offline — the config entity (plugin, mode,
credentials) saves without contacting PayPal. But actually *processing* a payment
(creating, capturing, or refunding) calls PayPal's REST API and needs valid
credentials and outbound network access. Use Sandbox credentials to run a genuine
end-to-end test before switching to Live.
