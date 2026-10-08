# Configuration

Magyar Posta has no standalone settings screen. You configure it by adding one or
more shipping methods that use its plugins. Each method carries its own options,
and the map method is where the Google Maps API key is entered.

## Add a Magyar Posta shipping method

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Shipping methods** and click **Add
   shipping method**.
3. Give it a name customers will recognise.
4. Choose one of the three plugins, depending on what you want to offer:
   - **PostaPont (list)** (`pickup_hu_postapont`) — a select list of PostaPont
     points.
   - **PostaPont (map)** (`pickup_hu_postapont_map`) — PostaPont points on a
     Google map (requires the API key below).
   - **Parcel machines** (`pickup_hu_postacsomag`) — Magyar Posta's automated
     lockers.
5. Configure the standard Commerce shipping‑method fields — the stores it applies
   to, the rate/price, and any conditions.

You can add several methods (for example one list method and one map method) if
you want to offer customers more than one style.

## Pickup list refresh interval

Each method has a cron refresh interval controlling how often its cached point
list is re‑downloaded from Magyar Posta's public feeds. Pick an interval that
keeps the list reasonably current — **daily** is a sensible default; the point
lists change rarely. Cron does the refresh, so make sure cron runs regularly on
your site.

## Google Maps API key (map method only)

The **PostaPont (map)** method shows pickup points on an embedded Google map, so
it needs a **Google Maps JavaScript API key**:

1. Create a key in the Google Cloud console with the **Maps JavaScript API**
   enabled — see
   <https://developers.google.com/maps/documentation/javascript/get-api-key>.
2. Enter the key in the **Google Maps JavaScript API key** field on the map
   method's configuration form. It is saved to the module's
   `commerce_shipping_pickup_hupost.settings` config, and the map library is only
   loaded when a key is present (and only on checkout pages).

**Restrict the key.** A Google Maps JavaScript key is a *client‑side* key that is
printed into a script URL and visible in the browser. Lock it down in the Google
Cloud console by **HTTP referrer (your site's domain)** and by API so it can only
be used from your store. For browser Maps keys this restriction, not secrecy, is
what protects the key.

## Save

Click **Save** to store each shipping method. The Magyar Posta options will now
appear at checkout for orders that match each method's conditions. The point data
is fetched from Magyar Posta's public feeds over HTTPS and cached in the module's
`commerce_shipping_pickup_hupost` table; feed errors are logged to the
`commerce_shipping_pickup_hupost` logger channel (**Reports → Recent log
messages**).
