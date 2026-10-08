# Configuration

Commerce Rave is configured by adding a Commerce **payment gateway**. It has no
separate settings page, and it stays inactive until you add the gateway and enter
your Rave keys.

## Store your Rave keys safely first

Flutterwave gives you a **public key** and a **secret key**. The secret key in
particular must be protected like a password — **never commit it to Git or paste
it into configuration you export**.

Note that this module stores the keys as plain gateway configuration fields (it
does **not** integrate the [Key](https://www.drupal.org/project/key) module — the
secret key is entered directly in a text field on the gateway form). Protect it by
restricting who holds the *Administer payment gateways* permission and by keeping
your exported payment-gateway configuration out of version control. If you manage
configuration in Git, exclude the gateway config or override the secret at runtime
(for example from an environment variable in `settings.php`) rather than exporting
the raw key.

## Add the payment gateway

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **name** and choose the **Rave** plugin.
4. Choose the **payment flow**:
   - **Standard / iFrame** — the Rave card form is embedded in your checkout.
   - **Hosted Payment Page** — the customer is redirected to Flutterwave's hosted
     page to pay and then returned to your site.
5. Enter your **public key** and **secret key** (use the Key entity for the
   secret rather than pasting it in plain text).
6. Choose the **mode** — **Test** while integrating, **Live** only after you have
   confirmed a full test payment.
7. Save the gateway.

## How completion works (and why it's safe)

When the customer finishes paying, the module calls Rave's API to **verify the
transaction server-side** (`verifyTransaction`) and only completes the Commerce
payment if Rave itself confirms it succeeded. It does not trust the redirect back
to your site, so a shopper cannot fake a "paid" status. Be aware that the module
currently has **no webhook** (it is noted as a to-do in the code) — fulfilment
relies on this verified return flow, so make sure customers actually complete the
redirect back to your site.

## Test before going live

Run at least one full purchase in **Test** mode and confirm the order reaches a
paid/completed state before switching the gateway to **Live**. Serve checkout over
HTTPS.
