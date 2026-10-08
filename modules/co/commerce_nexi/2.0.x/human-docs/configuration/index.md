# Configuration

Commerce Nexi is configured as a **Commerce payment gateway**. There is no separate
global settings page.

## Store your MAC secret securely

The Nexi MAC secret is a credential used to sign requests — never hard‑code or
commit it. With DDEV, keep it in an environment variable and load it through a Key
entity:

```bash
ddev dotenv set .ddev/.env --nexi-mac-secret=<value>
ddev restart
```

Install the Key module if it isn't enabled, then reference the variable from a Key
entity so the secret never lives in exported configuration.

## Add the Nexi payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Nexi** plugin.
3. Fill in the fields:
   - **Merchant alias** — your Nexi merchant identifier.
   - **MAC secret** — the secret used to sign requests (reference the Key entity
     above).
   - **Mode** — **Test** while validating, or **Live** for real transactions.
4. Save. Only trusted roles should be able to administer payment gateways.

For the Nexi credit-card payment method to work at checkout, make sure the checkout
flow uses the Nexi payment method type; the module wires this in with a checkout-form
event subscriber and an inline payment-method-add form.

## How the payment flow works (and why it's safe)

This is an **offsite** gateway. At checkout the module assembles a request to the
Nexi hosted page and signs it with a computed MAC, then redirects the shopper. Nexi
returns the browser to `/nexi-checkout/{order}/return` (or `/cancel`). Those return
and cancel routes are publicly reachable because the shopper arrives without a
session — but that does **not** make them forgeable. The controller is only a thin
redirect layer; the actual payment confirmation is done by the gateway's return
handler, which **re-fetches the payment from Nexi's API and verifies it server-side**
before creating or updating the Commerce payment. No client-supplied amount is
honoured. A verified notification also dispatches an event that other code can react
to.

Back-office staff can refresh a payment's remote status from Nexi using the remote
payment-status update form.

## Note on security-advisory coverage

This project is **not** covered by Drupal's security advisory policy. Keep it
updated, run in **test** mode first, and confirm that completed orders match genuine
Nexi transactions before going live.
