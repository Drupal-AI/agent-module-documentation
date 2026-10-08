# Configuration

Configuring Styled Google Map has two levels: a **global settings form** where
you enter the Google Maps API key once, and the **per‑map settings** you choose
on each field display or view.

## Step 1 — set the Google Maps API key (global)

1. Go to **Configuration → Web services → Styled Google Map**
   (`/admin/config/services/styled_google_map`). You need the **Administer site
   configuration** permission.
2. Choose the **authentication method**:
   - **API Key** — the normal choice for most sites. Paste your Google Maps
     JavaScript API key into the **API key** field.
   - **Google Maps API for Work** — if you have a Maps‑for‑Work account, pick
     this and enter your **Client ID** instead.
3. Optionally tick any extra **Google libraries** you need loaded globally —
   **drawing**, **geometry**, **localContext**, or **places**. (The
   `visualization` library, used for heatmaps, is always loaded, so you don't
   need to select anything for a heatmap.)
4. Click **Save configuration**.

Saving clears the library caches so the new key takes effect; if a map still
loads an old key, run `drush cr`. A couple of practical notes:

- **No key = grey map.** Without a valid key the Google map renders as a plain
  grey box. This is the number‑one troubleshooting cause.
- The key is a **public browser key**, so lock it down in the Google Cloud
  console by HTTP referrer to your site's domain.

## Step 2a — a single location (field formatter)

Use this to show one entity's location on its page.

1. Add a **Geofield** to your content type (or any fieldable entity) and enter
   coordinates on some content.
2. Go to the bundle's **Manage display**
   (*Structure → Content types → [type] → Manage display*).
3. Set the Geofield's **Format** to **Styled Google Map**.
4. Click the gear icon to open the map settings. The important ones:
   - **Width / height** — the map's CSS size (defaults `450px` / `400px`).
   - **Map type** — Roadmap, Satellite, Hybrid, or Terrain.
   - **Style** — a raw Google Maps **JSON style string** (default `[]`). Paste
     one from Snazzy Maps or Google's styling wizard to brand the map. Invalid
     JSON makes the map grey.
   - **Pin** — a custom marker image plus its width and height.
   - **Zoom** — default (15), maximum (17), and minimum (5) zoom levels.
   - **Gesture handling** — Cooperative (default), Greedy, or None; controls how
     scroll‑zoom behaves inside a long page.
   - **Controls** — individual toggles for zoom, fullscreen, streetview, map
     type, scale, rotate, draggable, and a separate mobile‑draggable option.
   - **Directions** — optionally offer turn‑by‑turn directions to the point.
   - **Popup (info bubble)** — an optional bubble on the marker. You choose when
     it opens (click or mouseover), whether it is open on load, and what fills
     it (a rendered **view mode** of the entity, or plain text), plus extensive
     styling: border colour/width/radius, background, padding, min/max size,
     arrow style and size, shadow, and custom CSS classes.
5. Save the display.

## Step 2b — many locations (Views style)

Use this to plot many entities as markers on one map — a store locator,
directory, or property map.

1. Create a **View** listing entities that have a Geofield.
2. In **Format**, choose **Styled Google Map**.
3. Open the style **settings** and set the **data source** to the Geofield
   (and, optionally, a **pin source** image field). The same appearance, zoom,
   control, and popup options as the formatter are available here, plus the
   multi‑marker extras below.
4. Add the Geofield (and any popup or pin fields) as **fields** on the view so
   the style can read them.
5. Save.

### Multi‑marker extras (Views only)

- **Marker clustering** — groups nearby markers into clusters so a busy map
  stays readable when zoomed out.
- **Spiderfy** — fans out markers that share the exact same coordinates so you
  can click each one.
- **Heatmap** — renders the points as a heat layer instead of pins.
- **Map center** — pin the map to a fixed coordinate instead of auto‑fitting to
  the markers' bounds.
- **Visitor position** — optionally show the visitor's own location.

You can place several independent map views as blocks on a single page.

## Customising further

The map markup is themeable via the `styled_google_map` and
`styled_google_map_directions` templates, and developers can adjust markers or
settings right before render with `hook_styled_google_map_views_style_alter()`.
See the [`agent/`](../../agent/start.md) docs for those hooks and templates.
