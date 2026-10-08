# Configuration

HyperPay is configured as a standard Drupal Commerce payment gateway.

## Add the gateway

1. Log in as a user who can **administer commerce payment gateways**.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** and select the **Hyperpay COPYandPAY Payment** plugin.
   (Optionally add the **Apple Pay** gateway as well.)

## Fields

- **Authorization Bearer token** — the token that authenticates all API calls to
  HyperPay. Keep this confidential (see below).
- **Entity ID** — your OPPWA channel/entity identifier.
- **Server** — the HyperPay endpoint to use (production `oppwa.com` or the EU
  production host). Pick the one your account uses.
- **Allowed cards** — the card brands you accept.
- **Test mode type** — controls the `testMode` parameter sent to HyperPay. Choose
  a test mode while integrating, and set it to **NONE** for live operation.
- **Widget style** — **Card** or **Plain** presentation of the COPYandPAY widget.
- **Reuse of payment methods** (optional) — enable to let customers store and
  reuse a card, and set the **recurring Entity ID** used for server-initiated
  recurring payments.

Save the gateway, then run a full test order before going live.

## Keep the Bearer token secret

The Authorization Bearer token authenticates every API call, so treat it like a
password and keep it out of version control. Store it in an environment variable
and reference it through a **Key** entity where the module supports one:

```bash
ddev dotenv set .ddev/.env --hyperpay-bearer-token=<your-token>
ddev restart
```

If the [Key module](https://www.drupal.org/project/key) is not enabled yet, add it
with `ddev composer require drupal/key && ddev drush en key -y`, then create a Key
that reads the environment variable.

## Why this gateway is safe

You do not configure anything for this, but it is worth knowing: card entry uses
the on-site COPYandPAY widget, and when the shopper returns the module fetches the
real payment status **and amount** directly from HyperPay server-to-server, then
verifies the amount equals the expected order amount **and** that the payment's
order ID matches the returning order before capturing. Any mismatch throws an
error and nothing is captured. Server-initiated (recurring) payments are amount-
checked too. Because status and amount are always fetched server-side and bound to
the order, a forged browser return cannot fraudulently complete a payment — so
beyond keeping the Bearer token confidential, there is nothing extra to harden.
