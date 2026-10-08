# Configuration

Commerce National Bank of Greece (Redirect) is configured as a **Commerce payment
gateway**. There is no separate global settings page.

## Store your credentials securely

Your NBG / GlobalPayments credentials (including the app key used to sign
callbacks) are secrets — never hard‑code or commit them. With DDEV, keep each value
in an environment variable and load it through a Key entity:

```bash
ddev dotenv set .ddev/.env --nbg-app-key=<value>
ddev restart
```

Install the Key module if it isn't enabled, then reference the variable from a Key
entity so the credential never lives in exported configuration.

## Add the NBG payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **National Bank of Greece (Redirect)** plugin.
3. Enter your NBG credentials (reference the Key entities above).
4. Choose **Test** mode while validating, or **Live** for real transactions.
5. Save. Only trusted roles should be able to administer payment gateways.

## How the payment flow works

This is an **offsite** gateway. At checkout the shopper is redirected to NBG's
GlobalPayments hosted page — supporting cards, Google Pay, Apple Pay and 3‑D Secure
— and returned to your site once payment is confirmed. The module then completes
the order.

## How the return is secured

The return URL is a public route (it has to be, because the shopper arrives without
a session), but that does **not** make it forgeable. Before completing the order,
the controller verifies the `X-GP-Signature` header — a SHA‑512 hash computed over
the minified payload combined with your app key — and rejects the request on any
mismatch. In other words the callback is **signature-authenticated**: an attacker
who does not know your app key cannot forge a "paid" notification. This is the
correct pattern for a redirect gateway, and it depends on your app key being set
correctly and kept secret (hence the Key entity above).

## Note on security-advisory coverage

This project is **not** covered by Drupal's security advisory policy. Keep it
updated, run in **test** mode first, and confirm that completed orders match genuine
NBG transactions before going live.
