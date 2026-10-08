# Configuration

Commerce Payrexx integration is configured as a **payment gateway**, not through
a central settings form. You create one Payrexx gateway per store (or per set of
credentials) and Commerce shows it as a payment option at checkout.

## Add the Payrexx gateway

1. Log in as a user who can administer payment gateways (an administrator by
   default).
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "Payrexx") — this is the internal label.
4. Choose the plugin **Payrexx (Redirect to Payrexx)**.

## Fill in the Payrexx fields

Once you pick the Payrexx plugin, its settings appear:

- **Instance name** — your Payrexx instance. This is the first part of the URL you
  log in at: in `https://instancename.payrexx.com/`, the instance name is
  `instancename`.
- **Secret** — your Payrexx **API secret**. This keys the authenticated calls the
  module makes back to Payrexx (including the transaction re-fetch that confirms
  payment), so it must be correct and kept private. See "Keep your secret safe"
  below.
- **VAT** — the VAT rate to pass to Payrexx, if you use it.
- **Fee** — the fee value to pass to Payrexx, if applicable to your setup.

## Test vs. live mode

Before going live, confirm the gateway is pointed at the correct Payrexx
environment. Run test transactions first, then switch to your live credentials
only when you are ready to take real payments.

## Keep your secret safe

The Payrexx API secret is a credential. Do **not** paste it into files you commit
to version control, and be mindful that payment-gateway settings can be included
in exported configuration. The recommended pattern on this project is to store
the value in an environment variable via DDEV's dotenv command and expose it to
Drupal through a **Key** entity, rather than typing the raw secret into config
that might be exported:

```bash
ddev dotenv set .ddev/.env --payrexx-api-secret=<value>
ddev restart
```

Then reference the value through the Key module where supported. Also make sure
your site runs over **HTTPS** so the redirect and webhook traffic is protected.

## Save and expose at checkout

Click **Save**. Then make sure the gateway is enabled and available in the
checkout flow your store uses, so shoppers see Payrexx as a payment option.

## How payment results are handled (good to know)

When a shopper pays, Payrexx redirects them back to your site and also calls the
module's webhook. The module does **not** trust the data in that webhook at face
value — it re-fetches the transaction from Payrexx's authenticated API (using your
instance name and secret), and the browser return path is confirmed the same way.
(When you first save the gateway, the module also verifies your credentials against
Payrexx with a `SignatureCheck` call.) This means a forged or replayed webhook
cannot mark an order as paid; the authoritative status always comes from Payrexx.
You do not need to configure this
— it is how the module behaves — but it is worth knowing your fulfilment is based
on a verified result.
