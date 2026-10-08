# Configuration

Setting up Mapy.com has two parts: entering your **API key and map settings**, and
then **adding the Mapy.com field** to the content that should carry a location.

## 1. Enter your API key and map settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Mapy.com**, or navigate directly to
   `/admin/config/services/mapycom`.
3. Enter your **Mapy.com API key**. The settings form links out to the Mapy.com
   developer portal where you can generate one. Maps, address search and geocoding
   are all drawn through the Mapy.com REST API, so a valid key is required before any
   map will display.
4. **Save** the form. On save the module contacts the Mapy.com Geocoding API to check
   that the key is accepted:
   - A working key is reported as **Configured (verified)** and the module stores the
     list of languages the Geocoding API supports.
   - A rejected key (HTTP 401/403) produces a validation error so you can correct it.
   - If Mapy.com can't be reached, the form still saves but warns you the key could
     not be verified yet.
5. Set the map appearance and behaviour options — base **layers** (basic, outdoor,
   winter, aerial), **marker labels**, **navigation controls**, **zoom** limits and
   auto-zoom — to suit your site.

### How the key is stored

The key you type is saved in the module's configuration object (`mapycom.settings`).
Because the map, the address autocomplete and geocoding all run in the **visitor's
browser**, the module makes the key available to the page so those client-side
scripts can call the Mapy.com API — this is normal and expected for a browser-rendered
map, and Mapy.com keys are intended to be used this way (scope them to your domain in
the Mapy.com developer portal).

If you export your site configuration into version control, the key travels with it
in `mapycom.settings.yml`. If you would rather it not be committed, exclude that
setting from your exported configuration (for example with **Config Ignore** or by
keeping it out of the config-sync directory) and set it per environment on the
settings form.

### A privacy note

Displaying a Mapy.com map causes each visitor's browser to load map tiles and scripts
from Mapy.com, a third-party service. Depending on where your visitors are, you may
need to mention this in your privacy notice and/or gate the maps behind a
cookie-consent mechanism.

## 2. Add the Mapy.com field to your content

1. Go to **Structure → Content types → *(your type)* → Manage fields** and **add a
   field** of the **Mapy.com** type.
2. On **Manage form display**, choose the **Mapy.Com - Map** widget so editors can
   pick the location on a map (and search by address) when creating content.
3. On **Manage display**, choose a formatter:
   - **Mapy.Com - Map** for an interactive map with a marker, or
   - **Mapy.Com - Address** for a compact single-address view.

## 3. Show many locations on one map (optional)

To plot several pieces of content on a single map, build a **View** and set its
**Format** to the **Mapy.Com - Map** Views style, then point it at your Mapy.com
source field (and optionally a field to use as the marker title). AJAX support means
filters update the map dynamically. This is ideal for directories, branch finders, or
any listing that benefits from a map overview.

## Troubleshooting

- **A "service unavailable" placeholder appears instead of a map** — no API key is
  configured yet, or it has not been verified. Enter and save the key on the settings
  form. The **Status report** (`/admin/reports/status`) also flags a missing or
  unverified key.
- **No map appears** — check that your API key is valid and saved, and that it is
  authorised for the services you use in the Mapy.com developer portal.
- **The map does not refresh after an AJAX filter** — clear Drupal's cache
  (`drush cr`) and check the browser's JavaScript console for errors.
