# Configuration

Configuration is a single settings form: your Google Maps API key, an optional
region, and the Google JS libraries you want loaded.

## Open the settings form

Go to **Configuration → Web services → Mapkit → Providers → Google Maps**
(`/admin/config/services/mapkit/providers/gmap`), reachable from Mapkit's provider
listing at `/admin/config/services/mapkit`. You need the **Administer mapkit
providers** permission (provided by the base Mapkit module).

## The settings

- **API key** — your Google Maps **JavaScript** API key. This is the credential
  used to load the Maps JS API in the browser. See the security note below.
- **Region** — an optional region code (for example `US`, `GB`) that biases map
  and geocoding results toward that country.
- **Libraries** — tick the optional Google JS libraries you need. Each adds
  capability (and page weight), so enable only what you use:
  - **Places** — address/location **autocomplete**. Enable this if you want
    Mapkit's autocomplete location inputs to work with Google.
  - **Drawing** — tools for drawing polygons, circles, and markers.
  - **Geometry** — scalar geographic calculations (distances, areas).
  - **Visualization** — heatmaps and similar overlays.

When you save, the module rebuilds the Google Maps loader URL from these settings
(key, region, the selected libraries, async loading, and its init callback) and
clears the asset library cache so the new URL takes effect right away.

## Protect the API key

The Google Maps **JS API key is a client-side key** — it is rendered into the
page markup by design so the browser can load Google Maps. It is therefore **not**
a server secret, but an unrestricted browser key can be copied from your pages and
abused, running up your Google bill. Two precautions:

- **Restrict the key by HTTP referrer** in the Google Cloud console, allowing only
  your own domain(s). This is the primary protection for a browser key. Also
  restrict it to just the APIs you use (Maps JavaScript API, and Places if
  enabled).
- **Keep it out of version control.** Store it in an environment variable and set
  the config from there. With DDEV:

  ```bash
  ddev dotenv set .ddev/.env --google-maps-api-key=YOUR_KEY_HERE
  ddev restart
  ```

  That exposes it as `GOOGLE_MAPS_API_KEY` in the container (keep `.ddev/.env` out
  of version control); reference it from `settings.php` via
  `getenv('GOOGLE_MAPS_API_KEY')` to override the stored value.

Loading Google Maps sends visitor requests to Google and is billed against your
Google account — a privacy and cost consideration for high-traffic pages.

## Save

Click **Save**. The library cache clears automatically, so the new key, region,
and library selection apply on the next page load. To rotate the key later, just
update it here and save again.
