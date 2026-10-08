# Configuration

Leaflet MapTiler is configured at **`/admin/config/leaflet_maptiler`**. The
essential step is entering your MapTiler API key; the rest tunes which layers your
maps use.

## First, get a MapTiler API key

Create an account at [maptiler.com](https://www.maptiler.com/) and generate an
**API key** from your account. You will paste this into the Drupal settings form.

## The settings

On the MapTiler settings page:

- **MapTiler API Key** — your API key generated from MapTiler. This is required;
  without it, MapTiler tiles will not load.
- **MapTiler layers** — the default layers provided by MapTiler. **The first
  layer is used as the base layer of all maps.** (Custom layers are not yet
  supported.)
- **Geocoder external library** — the module uses the external
  `leaflet-control-geocoder` library to retrieve geocoding information when a
  visitor clicks a marker; this setting governs that integration.

Save the form, then use MapTiler by selecting it when you format a field
(Geofield) or a View as a Leaflet map.

## Handle the API token as a secret

The MapTiler token is a credential that authorises tile requests against your
MapTiler account, so treat it accordingly:

- The **Leaflet MapTiler Token** submodule manages the token used for the
  in‑content map token; keep that value protected.
- Prefer storing the key in an environment variable with DDEV's dotenv command
  (for example `ddev dotenv set .ddev/.env --maptiler-key=<value>`, then
  `ddev restart`) and referencing it through a **Key** entity where the workflow
  allows, rather than committing the raw key to exported configuration. Never
  commit `.ddev/.env`.
- Where MapTiler supports it, restrict the key to your own domain(s) so a token
  visible in page source cannot be reused elsewhere on your account.

## Understand the third‑party request

Map tiles are fetched **from MapTiler by the visitor's browser** — every map view
is an outbound request to a third party. Factor that into your privacy notice if
relevant.

## Save

Click **Save configuration**, then load a page with a MapTiler‑styled Leaflet map
and confirm the tiles render.
