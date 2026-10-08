# Configuration

Leaflet Mapbox is configured at **Configuration → Web Services → Leaflet
MapBox**. Here you define one or more Mapbox map styles; each becomes a selectable
option when you build Leaflet maps.

## First, create a map in Mapbox

Before configuring Drupal, you need something to point at:

1. Create an account at [mapbox.com](https://www.mapbox.com/).
2. Build a map in Mapbox Studio and press **Publish** to save it.
3. Note its **Style URL** (Mapbox Studio shows this on the style's share/details
   panel).
4. Copy your **access token** from your Mapbox account.

## Fill in the settings form

On the Leaflet MapBox settings page:

- **Label** — a name for this map style, so you can recognise it later in the map
  dropdowns.
- **API version** — the Mapbox API version to use. **API 4 is recommended.**
- **Style URL** — paste the Style URL you copied from mapbox.com.
- **Access token** — paste your Mapbox access token.
- **Zoom level** and **description** — set an initial zoom and a short
  description, then save.

Once saved, your new Mapbox style is available to choose when you create Leaflet
Views and field formatters.

## Handle the access token carefully

A Mapbox access token is **public by necessity** — the visitor's browser uses it
to fetch tiles, so it ends up in your page source. That does not make it
harmless:

- **Scope the token with URL restrictions at Mapbox.** Restrict it to your own
  domain(s) so that, even though it is visible, it cannot be reused on someone
  else's site against your account. An unrestricted token found in page source can
  be used by anyone.
- If you would rather not hard‑code the token in exported configuration, store it
  in an environment variable with DDEV's dotenv command (for example
  `ddev dotenv set .ddev/.env --mapbox-token=<value>`, then `ddev restart`) and
  reference it through a **Key** entity where the workflow allows. Never commit
  `.ddev/.env`.

## Understand the cost and the third‑party request

- **Billing is per map load** above Mapbox's free tier. A map on a busy page is a
  recurring cost — size it before launch.
- Tiles are fetched **from Mapbox by the visitor's browser**, so every map view is
  a request to a third party. Factor that into your privacy notice if relevant.

## Save

Click **Save configuration**, then load a page with a Leaflet map set to your
Mapbox style and confirm the branded tiles render.
