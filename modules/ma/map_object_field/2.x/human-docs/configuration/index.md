# Configuration

Setup has two parts: a one-time site-wide **Google Maps API key**, then a
per-field configuration of the widget (drawing) and formatter (display).

## 1. Set the Google Maps API key

1. Get a **Google Maps JavaScript API key** from the
   [Google Cloud console](https://developers.google.com/maps/documentation/javascript/get-api-key).
2. Go to **Configuration → Map Object Field**
   (`/admin/config/map-object-field`).
3. Enter the key and save.

### Restrict and protect the key

The Google Maps **JavaScript API key is a client-side key** — it is emitted into
the page so the browser can load the map. That's expected and it is not a secret
"server" key, but an unrestricted browser key can be lifted from your pages and
used elsewhere, running up your quota and bill. Two precautions matter:

- **Add HTTP referrer restrictions in the Google Cloud console**, whitelisting
  only your own domain(s) so the key won't work on other sites. The module's own
  documentation stresses adding your domains to the key's allow-list.
- **Keep the value out of version control.** Rather than pasting the key straight
  into configuration that gets exported, store it in an environment variable and
  feed it in. With DDEV:

  ```bash
  ddev dotenv set .ddev/.env --google-maps-api-key=YOUR_KEY_HERE
  ddev restart
  ```

  That exposes it as `GOOGLE_MAPS_API_KEY` inside the container (keep
  `.ddev/.env` out of version control), which you can reference from
  `settings.php` via `getenv('GOOGLE_MAPS_API_KEY')` and use to override the
  module's setting.

Loading Google Maps also sends visitor requests to Google, which is a third-party
/ privacy consideration worth noting in your privacy policy.

## 2. Add the field

1. On a content type, go to **Manage fields** and add a new field of type **Map
   Object Field** (under Field types).
2. Give it a label and save.

## 3. Configure the widget (what editors can draw)

On the bundle's **Manage form display**, open the field's widget settings. Here
you control the drawing experience:

- **Shape types available** — choose which of circles, lines, polygons,
  polylines, markers, and rectangles editors may draw.
- **Number of objects** — limit how many shapes an editor can add to the field.

Editors drawing shapes can also give each shape a **title** and **description**
(shown in an info window on click) and set its **fill and stroke colours**.

## 4. Configure the formatter (how the map displays)

On the bundle's **Manage display**, open the field's formatter settings. Here you
set the **width and height** of the map rendered on the page. Saved shapes appear
on that map, each showing its title and description in an info window when a
visitor clicks it.

## Save

Save each form as you go. Once the API key is set and the field is configured,
editors can draw and store map geometry, and it renders on the front end.
