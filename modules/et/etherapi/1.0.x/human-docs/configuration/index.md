# Configuration

Setting up EtherAPI is two steps: register it as a Basket payment method, then
enter your etherapi.net credentials on the gateway settings form. **Read the
note at the end before going live.**

## Step 1 — Create the Basket payment point

1. Go to Basket's payment systems settings at **/admin/basket/settings-payment**.
2. Create a payment point and select **EtherAPI** as its service.
3. After saving, you'll see a button/link to open the EtherAPI gateway settings
   (you can also reach them directly at
   `/admin/config/development/etherapi`).

## Step 2 — Open the gateway settings

1. Log in as a user with the **Access EtherAPI settings** permission (this
   permission is marked restricted, so grant it only to trusted administrators).
2. Go to **Configuration → Development → EtherAPI**
   (`/admin/config/development/etherapi`).

## The settings fields

- **API key (per currency)** — the etherapi.net API key for each crypto currency
  you accept. This value is the **shared secret** used to verify the signed
  confirmation callback. Set a strong key for **every** currency you enable (see the
  note below).
- **Receiving wallet address** — the address surfaced to the shopper on the pay
  page, where funds are sent.
- **Default currency** — the currency applied to new payments (defaults to `ETH`).
- **Callback IP allow‑list (`REMOTE_ADDR`)** — a newline‑separated list of IP
  addresses permitted to POST status confirmations. When non‑empty, status POSTs
  from any other IP are rejected. Filling this in is strongly recommended as
  defence in depth.

The module can also operate in a **test mode** while you validate the flow.

## Storing the API key safely

The API key is a payment‑critical secret. Keep the value in an environment variable
rather than pasting it somewhere it might be exported or committed.

With DDEV, save it into the project's dotenv file (never commit `.ddev/.env`) and
restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --etherapi-key=<your-api-key>
ddev restart
```

The flag `--etherapi-key` becomes the environment variable `ETHERAPI_KEY` inside
the web container, which you can reference when configuring the gateway (for example
through a **Key** entity using the env provider) so the raw secret stays out of
exported configuration.

## Important note

The confirmation callback's signature is computed from the payment's fields plus
your API key. Therefore:

- Always set a strong, non‑empty API key for **every** currency you accept.
- Also fill in the **callback IP allow‑list** so only etherapi.net's servers can
  POST confirmations.

## Save and test

Save the settings, then run a test payment (in test mode first) to confirm the pay
page shows the correct amount and address and that a confirmed transaction advances
the Basket order to paid. Only accept real funds once you have set live keys and,
ideally, the IP allow‑list.
