# Configuration

Foxpost has no standalone settings screen. You configure it by adding a shipping
method that uses its plugin, and the only Foxpost‑specific option is how often the
pickup‑point list is refreshed.

## Add the Foxpost shipping method

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Shipping methods** and click **Add
   shipping method**.
3. Give it a name customers will recognise (for example "Foxpost parcel machine").
4. Choose the plugin **Pickup shipping – Foxpost** (`pickup_hu_foxpost`).
5. Configure the standard Commerce shipping‑method fields as usual — the stores
   it applies to, the rate/price, and any conditions.

## Pickup list refresh frequency

The one setting unique to this provider controls how the cached list of Foxpost
pickup points is kept up to date:

- **Pickup list refresh frequency** — choose **Disabled**, **Hourly**, **Daily**,
  or **Weekly**. On each cron run the module checks whether the interval has
  elapsed and, if so, re‑downloads Foxpost's public catalogue and updates its
  cached list. **Daily** or **Weekly** is plenty for most stores — the machine
  list changes rarely. Choose **Disabled** to freeze the current list and never
  refresh it automatically.

Even with refresh disabled, the module will populate the list once on demand the
first time it finds the cache empty, so pickup points still appear.

## Save

Click **Save** to store the shipping method. The Foxpost option will now appear
at checkout for orders that match the method's conditions. The pickup catalogue
is fetched from Foxpost's public CDN over HTTPS; there are no API keys or carrier
credentials to enter for this provider.

## Where the data lives

The cached pickup points are stored in the module's own
`commerce_shipping_pickup_foxpost` database table. If a fetch ever fails, the
module logs to the `commerce_shipping_pickup_foxpost` logger channel (see
**Reports → Recent log messages**) and simply returns an empty list until the
next successful refresh.
