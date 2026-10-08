# Configuration

GLS CsomagPont has no standalone settings screen. You configure it by adding a
shipping method that uses its plugin, and the key thing to supply there is the
Google Maps API key that the pickup‑point map needs.

## Add the GLS CsomagPont shipping method

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Shipping methods** and click **Add
   shipping method**.
3. Give it a name customers will recognise (for example "GLS CsomagPont pickup").
4. Choose the GLS CsomagPont pickup plugin.
5. Configure the standard Commerce shipping‑method fields — the stores it applies
   to, the rate/price, and any conditions.

## Google Maps API key

GLS CsomagPont presents pickup points on an embedded Google map, so the map will
not render until you provide a **Google Maps JavaScript API key**:

1. Create a key in the Google Cloud console with the **Maps JavaScript API**
   enabled — see
   <https://developers.google.com/maps/documentation/javascript/get-api-key>.
2. Enter that key in the GLS shipping method's configuration.

**Restrict the key.** A Google Maps JavaScript key is a *client‑side* key — it is
printed into a script URL and is therefore visible in the browser. Lock it down
in the Google Cloud console by **HTTP referrer (your site's domain)** and by API,
so it can only be used from your store. This is normal for browser Maps keys; the
restriction, not secrecy, is what protects it.

The Google Maps key is the only credential this module uses — GLS's pickup‑point
data feed and map widget are public and need no GLS API key. The module fetches
the pickup catalogue server‑side over HTTPS from GLS's public feed.

## Save

Click **Save** to store the shipping method. The GLS CsomagPont option, with its
map selector, will now appear at checkout for orders that match the method's
conditions.
