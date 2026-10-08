# Configuration

The module has one settings page, and its most important job is holding your
**Google Maps API key** — until that is set, no map will render anywhere the field
is used.

## Open the settings form

1. First make sure your account has the right permission. Go to **People →
   Permissions** and grant **Administer GMap Polygon Field** to the roles that
   should manage this module. (Note: this permission is declared as
   *non-restricted*, so grant it deliberately — treat it as an administrative
   permission even though Drupal does not flag it as security-sensitive.)
2. Go to **Configuration → Content authoring → GMap Polygon Field**
   (`/admin/config/content/gmap_polygon_field`).

## Google Maps API key

Enter a valid **Google Maps API key** with the **Maps JavaScript API** and the
**Drawing** library enabled in the Google Cloud console. This is the single
required setting — the drawing widget and the display formatter both rely on it.

A practical safety tip: in the Google Cloud console, **restrict the key to your
site's domain(s)** (an HTTP referrer restriction) so it cannot be reused on other
sites. The key is emitted into the page for the browser to use, so a domain
restriction is your main protection against abuse and unexpected billing.

## Polygon appearance

The form also lets you tune how drawn polygons look on the map:

- **Stroke color** — the colour of the polygon's outline.
- **Opacity** — how transparent the filled area is.
- **Weight** — the thickness of the outline.

These are cosmetic defaults applied when the map renders the shape; adjust them so
the drawn areas read clearly against your map style.

## Save

Click **Save configuration**. With the key in place, add a **GMap polygon** field
to a content type and the drawing widget will render on the edit form. You can also
confirm everything works on the bundled example page at
`/examples/gmap_polygon_field`.
