# Configuration

Commerce Braintree has no module settings page of its own — you configure it by
creating a **payment gateway** in Drupal Commerce and filling in its settings.

## Add the payment gateway

1. Log in as a user who can administer Commerce payment gateways.
2. Go to **Commerce → Configuration → Payment → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and choose the **Braintree (Hosted Fields)**
   plugin.
4. Give it a name and configure the settings below, then save and enable it.

## Gateway settings

- **Mode** — **Test** (Braintree sandbox) or **Live**. Always build and test with
  Test mode and sandbox credentials first; switch to Live only when you're ready to
  take real payments.
- **Merchant ID** — your Braintree merchant ID.
- **Public key** — your Braintree public key.
- **Private key** — your Braintree private key. Treat this as a secret — see the
  [Installation](../installation/index.md) page for the DDEV environment-variable
  pattern that keeps it out of version control.
- **Merchant account IDs (per currency)** — to support more than one currency, map
  each Commerce currency to the corresponding Braintree **merchant account ID**.
  This is how multi-currency stores route each payment to the right account.
- **3-D Secure** — enable SCA / 3-D Secure 2 authentication. Typically offered as
  **enabled** (attempt authentication) or **required** (must authenticate). When on,
  a checkout pane runs client-side authentication before the final submit.
- **Display credit card icons** — a toggle to show card-brand icons during
  checkout.

Save the gateway and make sure it's **enabled** so it appears at checkout.

## 3-D Secure at checkout

When 3-D Secure is turned on, the module adds a **Braintree 3DS review** checkout
pane on the checkout **Review** step. It performs the client-side authentication
(especially for vaulted cards) before the order's final submit, satisfying SCA
requirements. This is wired up automatically when you enable 3-D Secure on the
gateway — you don't normally need to place the pane by hand.

## What you can do once it's live

- **Accept cards on-site** via Hosted Fields, with card data tokenized in the
  browser (it never reaches Drupal).
- **Offer PayPal and PayPal Credit** as checkout options through the same gateway.
- **Authorize now, capture later** — leave capture off at checkout, then capture
  from the order's **Payments** tab when you're ready.
- **Void** an authorization before it settles, and **refund** captured payments
  fully or partially (an unsettled transaction is voided automatically instead).
- **Vault** a customer's card or PayPal account for reuse on future orders and, with
  Commerce Recurring, subscription billing.

## Developer hook

Other modules can attach extra data or metadata to the sale request (for example an
order channel or custom fields) by subscribing to the
`commerce_braintree.transaction_data` event. No configuration is needed for this —
it's a code-level extension point.
