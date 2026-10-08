# Configuration

Commerce EasyPost is configured on the shipping‑method form — there is no
separate settings page.

## Prerequisites

- Commerce with **Shipping** and **commerce_shipping_label** enabled.
- A shipping‑enabled **store** and a **shipment type**.
- An **EasyPost** account and API key.

## Add the shipping method

1. Go to **Administration → Commerce → Configuration → Shipping methods** and
   click **Add shipping method**.
2. Choose the **EasyPost** plugin.

The plugin's configuration form is organised into a few sections:

### API information

- **API key** — paste your EasyPost API key.
- **Mode** — choose **test** or **production**. Keep separate keys for each and
  don't point a live key at a development site.

### Enabled services

- Tick the **carrier services** you want to present to customers at checkout
  (only enabled services are offered and rated).
- Optionally allow a customer to supply their **own carrier account** per carrier
  (this pairs with the customer carrier‑account checkout pane).

### Customs (for international shipments)

- Toggle whether to send customs info, and set the defaults: **tax id**,
  **description**, **HS tariff number**, **customs signer** and **incoterm**.

### Options

- **Dropoff type**, whether to **include the order number**, a **sender phone**
  number (some carriers require one), optional **insurance**, a **rate
  multiplier**, and **rounding** applied to returned rates.

Save the method. It is now available at checkout for the store; place a test order
to confirm live rates come back for your enabled services.

## What you can do at runtime

Once configured, the method drives the usual EasyPost operations from
authenticated Commerce admin/fulfilment flows: live **rate** lookup at checkout,
**buy** a label for a shipment, **refund/void** a purchased label, show a
**tracking** URL, and **schedule** or **cancel** a carrier pickup. There are no
public endpoints — every privileged action is an authenticated admin operation.

## Security notes

- **The API key is stored in plain configuration.** It lives in the
  shipping‑method configuration as a plain text field (the standard Commerce
  shipping‑gateway pattern) — it is not encrypted or held in a Key entity, so
  anyone with permission to edit shipping methods can read it. Restrict the
  "administer commerce shipping methods" permission to trusted roles, and use
  separate keys for test and production environments.
- **TLS is not weakened.** All traffic uses the official EasyPost SDK over HTTPS;
  the module does not disable certificate verification.
- **Customer data goes to the carrier.** Rating and label purchase send address
  and (where collected) phone details to EasyPost and the carriers, which is
  inherent to live shipping — be aware of it for your privacy notices.
