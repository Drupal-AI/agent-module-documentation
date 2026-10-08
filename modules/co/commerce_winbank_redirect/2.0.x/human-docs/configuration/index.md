# Configuration

Commerce Winbank is configured as a Drupal Commerce payment gateway. You enter
the merchant credentials Piraeus Bank issued and register the callback URLs with
the bank.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, name it (for example "Winbank"), and choose
   **Winbank** as the plugin.

## Gateway settings

Enter the Winbank merchant credentials from Piraeus Bank. These identify your
acquiring account and provide the secret used to build and verify the payment
hash (the exact field labels are described in the module's README). You will also
choose whether the gateway runs in **test** or **production** mode and whether it
is enabled.

When a customer pays, they are redirected to Winbank's hosted page. When the bank
posts the result back, the controller recomputes the **HMAC‑SHA256 `HashKey`**
from the returned values and your transaction ticket and only records a payment if
the hash matches — so a forged callback is rejected.

## Register the callback URLs with the bank

Winbank needs to know where to send the customer and the result. Register the
callback / return URLs for your site with Piraeus Bank as described in the
module's README so the bank can communicate with your Commerce site correctly.

## Handle the credentials safely

Your Winbank merchant credentials (and the hashing secret) are sensitive. Never
commit them to code. On DDEV, store secret values in environment variables and
reference them through a **Key** entity where the field allows, rather than
pasting them into exported configuration:

```bash
ddev dotenv set .ddev/.env --winbank-secret=<value>
ddev restart
```

Always serve the site over **HTTPS**.

## Save and test

Click **Save**, then place a test transaction end to end — redirect to Winbank,
payment, and the verified return — and confirm the Commerce payment records
correctly before switching to production credentials.
