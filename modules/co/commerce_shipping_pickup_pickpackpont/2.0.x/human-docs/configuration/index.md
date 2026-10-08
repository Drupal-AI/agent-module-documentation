# Configuration

Pick Pack Pont has no standalone settings screen. You configure it by adding a
shipping method that uses its plugin, then filling in that method's options.

## Add the Pick Pack Pont shipping method

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Shipping methods** and click **Add
   shipping method**.
3. Give it a name customers will recognise (for example "Pick Pack Pont pickup").
4. Choose the plugin **Pickup shipping – Pick Pack Pont**
   (`pickup_hu_pickpackpont`).
5. Configure the standard Commerce shipping‑method fields as usual — the stores
   it applies to and any conditions.

## The rate fields

The only options specific to the pickup plugin are the rate fields it inherits
from the pickup framework:

- **Rate label** (required) — shown to customers when they select the rate.
- **Rate description** (optional) — extra detail about the rate.
- **Rate amount** (required) — the shipping price and currency. The price is
  taken from this configuration on the server; it is never read from the
  customer's browser.

There are no Pick Pack Pont‑specific credentials to enter. The point picker is a
public map widget loaded in the customer's browser from Pick Pack Pont's own
site (`https://online.sprinter.hu/terkep/#/`) over HTTPS — there is no API key,
token, or account identifier for this provider.

## Save

Click **Save** to store the shipping method. The Pick Pack Pont option, with its
embedded point selector, will now appear at checkout for orders that match the
method's conditions.
