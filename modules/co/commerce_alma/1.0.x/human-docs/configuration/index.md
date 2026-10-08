# Configuration

You configure Commerce Alma by adding it as a **payment gateway** in Drupal
Commerce, entering your Alma API key, and choosing the fee plan and mode.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a name (for example "Alma — pay in installments") and choose the
   **Alma** plugin provided by this module.

## Key fields

- **Mode: Test or Live** — start in **Test** while you integrate; switch to
  **Live** only after verifying the full flow. Use the matching Alma credentials
  for each environment.
- **API key** — your Alma merchant API key. Reference the Key entity you created in
  [Installation](../installation/index.md) rather than pasting the raw value.
- **Fee plan** — each gateway defines the installment fee plan it offers. Choose
  the plan you want to present to customers. If you want to offer several plans,
  add several Alma gateways.

Save the gateway. Alma now appears as a payment option at checkout.

## How the payment flow behaves

- The customer is redirected off‑site to Alma to arrange the installment payment,
  then returned to your store.
- In‑progress payments are **authorized**; paid payments are **captured**.
- The module confirms outcomes by **fetching the payment from Alma's API** and
  updates the order only when Alma's authoritative remote state is *paid* — it does
  not trust the browser return or an IPN payload's claimed status.
- A **cron job** revisits authorized payments to capture them, so keep cron running
  reliably.

## Test before going live

With the gateway in **Test** mode, place an order, complete the Alma redirect, and
confirm the payment authorizes and then captures (after cron) based on Alma's
authoritative state. Because this is a beta release, review the behaviour for your
version before switching to **Live**.
