# Configuration

Commerce BOXNOW is configured as a Commerce **shipping method**.

## Add the shipping method

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Shipping methods**
   (`/admin/commerce/config/shipping-methods`).
3. Click **Add shipping method**.
4. Give it a **Name**, and under the plugin/type choose **BoxNow Shipping**.

## Fields to fill in

- **API credentials** — enter the credentials BOX NOW provided so the module can
  authenticate to their API. Treat these as secrets (see below).
- **Pricing** — set the rate charged for locker delivery, following the standard
  Commerce Shipping rate options.
- **Region / availability restrictions** — limit where the method is offered
  (for example, only in countries or regions BOX NOW serves).
- **Conditions** — as with any Commerce shipping method, you can restrict when
  the method appears based on order conditions.

Save the shipping method.

## How customers use it

At checkout, when the BOX NOW method is available, the customer selects a **locker
location** for delivery. The module then communicates with BOX NOW to sync
shipment data and status.

## Storing API credentials securely

The BOX NOW API credentials are secrets and should not be committed to code or
exported in plain text. On DDEV, store them as environment variables:

```bash
ddev dotenv set .ddev/.env --boxnow-api-key='<your-api-key>'
ddev restart
```

Reference the value through a **Key** entity where supported rather than pasting
the raw value into the form, and keep `.ddev/.env` out of version control.

## Data‑handling notes

- The module makes **outbound calls to the BOX NOW API** using your credentials —
  make sure the site runs over **HTTPS**.
- It sends **order and recipient details** (names, addresses — personal data) to
  BOX NOW so parcels can be delivered. Disclose this third‑party data sharing in
  your privacy policy.
