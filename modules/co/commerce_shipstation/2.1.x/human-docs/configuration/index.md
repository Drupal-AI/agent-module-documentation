# Configuration

Setting up ShipStation is a two‑sided job: first configure the connection in
Drupal, then create a matching "Custom Store" in your ShipStation account using
the same credentials.

## Open the settings form

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Shipping → ShipStation**, or navigate
   directly to `/admin/commerce/config/shipstation`.

## Step 1 — configure the connection in Drupal

On the settings form:

- **Endpoint username and password** — create a dedicated username and password
  for the integration. **This must be different from your ShipStation login.**
  ShipStation sends these on every request (as `SS-UserName`/`SS-Password`
  parameters) and the module checks them before returning or updating order data.
  An optional **Alternate Authentication** key (`auth_key`) is also available for
  servers that run PHP via CGI. Save the username and password for the next step.
- **Export order status** — choose which Commerce order status marks an order as
  ready to be exported to ShipStation for fulfillment.
- **Order comments field** — choose which field should be used to push order
  comments to ShipStation.
- **Phone number fields** — configure how billing / shipping phone numbers are
  handled.
- **Product images** — configure whether/how product images are sent.
- **Shipping methods** — choose which shipping methods are made available to
  ShipStation.

Set the options to match your business requirements, then **Save**.

### Keep the credentials secret and the endpoint on HTTPS

The endpoint username/password (and any ShipStation API key) are secrets:

- Store them as secrets rather than in committed configuration. With DDEV, save a
  value into `.ddev/.env` (for example
  `ddev dotenv set .ddev/.env --shipstation-password=<value>`, which becomes the
  `SHIPSTATION_PASSWORD` environment variable), keep `.ddev/.env` out of version
  control, and `ddev restart`. Reference secrets through a **Key** entity (Key
  module) where supported, or via `getenv()` in settings.
- **Serve the endpoint only over HTTPS.** The store credentials and order data
  (customer names and addresses) traverse it in the request.
- **Rotate the credentials** if you suspect they've leaked.

## Step 2 — create the Custom Store in ShipStation

1. Log in to your ShipStation account and add a **Custom Store** selling channel.
2. For the store URL, enter your site's endpoint:
   `https://[your.domain.name]/shipstation/drupal-commerce`.
3. Enter the **username and password** you created in Step 1.
4. Set ShipStation's status codes to match your Drupal order workflow. The
   recommended setup is **"Fulfillment, with validation"** with these states:
   - **Awaiting Payment Status:** `validation`
   - **Awaiting Shipment Status:** `fulfillment`
   - **Shipped Status:** `complete`
   - **Cancelled Status:** `canceled` *(note the single‑l spelling)*
   - **On‑Hold Status:** `null`
5. If you use a custom order workflow, make sure it has a **`fulfill` transition**
   — this is the transition ShipStation calls after an order ships.
6. Click **Connect**. The Custom Store should connect to your Drupal Commerce
   install.

## That's it

ShipStation will now automatically make export requests to your endpoint and
import matching orders. When an order ships, ShipStation marks the order/shipment
complete and saves the tracking number on the shipment.
