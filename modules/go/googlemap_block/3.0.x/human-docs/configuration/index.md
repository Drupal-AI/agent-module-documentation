# Configuration

Setup has three parts: add your Google Maps API key, define one or more locations,
and place the map block.

## Get and restrict a Google Maps API key

1. In the [Google Cloud console](https://console.cloud.google.com/), enable the
   **Maps JavaScript API** (and any related APIs you need) and create an **API
   key**.
2. **Restrict the key** — by HTTP referrer (your site's domains) and by API. Maps
   keys are used in client-side requests and are therefore visible in the browser,
   so referrer restrictions are your main defence against someone else running up
   your bill.

## Store the key as a secret

Keep the key value in an environment variable rather than committing it. With DDEV:

```bash
ddev dotenv set .ddev/.env --google-maps-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--google-maps-api-key` becomes the environment variable
`GOOGLE_MAPS_API_KEY` inside the container. Do not commit `.ddev/.env`.

## Enter the key on the settings form

1. Go to **Structure → Googlemap → Settings**
   (`/admin/structure/gmap-location/settings`).
2. Enter your Google Maps API key and any global map defaults the form offers.
3. Save.

## Add locations

Go to **Structure → Googlemap** (`/admin/structure/gmap-location`) and add each
location you want to show, giving it a name/address and map options (such as zoom
and markers).

## Place the map block

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. Click **Place block** in the region where the map should appear.
3. Choose the GoogleMap block, configure its options (including which location it
   shows), and save.

## A note on data flow

The map is rendered by Google's Maps service, so map tiles and geodata are loaded
from Google (client-side, over HTTPS). Because the key travels in browser requests,
the referrer/API restrictions above are what keep it from being abused.
