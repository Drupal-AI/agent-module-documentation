# Configuration

Aemet needs two things before it will show forecasts: your AEMET API key, and a
block placed where you want the weather to appear.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Services → Aemet**, or navigate directly to
   `/admin/config/services/aemet`.

## The settings form, field by field

- **API key** — a textarea where you paste the free API key you obtained from
  AEMET's OpenData portal. The module sends this key to AEMET (over HTTPS) with
  every forecast request. To rotate the key later, simply paste a new value here
  and save.

- **Request max-age (cache lifetime)** — how long a fetched forecast is kept in
  Drupal's cache before the module asks AEMET again. The choices are roughly
  **1 hour**, **12 hours**, **1 day**, or **disabled** (no caching). A longer
  lifetime means fewer calls to AEMET — which helps you stay within the API's
  rate limits — at the cost of slightly less fresh data. An hour is a sensible
  starting point for most sites.

Click **Save configuration** to store your changes.

## Place the forecast block

The module provides a **Prediction Hourly** block that shows the hourly forecast
(sky status, temperature, and so on) for one Spanish locality.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region where you want the weather to appear and click **Place block**.
3. Choose the **Prediction Hourly** block from the list.
4. In the block's configuration, set the specific Spanish locality you want the
   forecast for, then save.

The block will now display upcoming hourly weather to visitors, refreshing no
more often than the cache lifetime you chose above.

## If forecasts do not appear

- Double-check the API key is entered correctly and that your AEMET account is
  active — an invalid key means no data comes back.
- After changing the key or cache settings, clear Drupal's caches so stale or
  empty responses are dropped (`drush cr`, or **Configuration → Development →
  Performance → Clear all caches**).
