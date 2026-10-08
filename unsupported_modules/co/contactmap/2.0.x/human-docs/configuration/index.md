# Configuration

Contact Map does nothing visible until you complete this one settings form. All the
values below are stored in the `contactmap.settings` configuration object.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Contact Map**, or navigate directly to
   `/admin/config/user-interface/contact-map`.

## Google Map API key

Paste your **Google Maps JavaScript API key** here. Without a valid key the map
cannot render. This is a client‑side key that is exposed to the browser (the way all
embedded Google maps work), so restrict the key in the Google Cloud console to your
site's domains. (Stored as `mapGooglekey`.)

## Phone number

The **contact phone number** shown as a click‑to‑call link. It is **required** and
**validated on save** — it must be an acceptable length and match a numeric/`+`
pattern, so enter it in a clean international‑style format. (Stored as
`mapPhoneNumber`.)

## Address

The **postal / contact address** shown alongside the map when a visitor opens the
widget. (Stored as `mapAddressContact`.)

## Latitude and Longitude

The **map's center coordinates** — the point the Google map centers on and drops its
pin. Enter the latitude and longitude for the location you want to highlight.
(Stored as `mapLatitude` and `mapLongitude`.)

## Theme

The **theme the widget should appear on**. The module only attaches its library and
shows the widget when the site's active theme matches this value — so this doubles
as the on/off switch: point it at your public‑facing theme to show the widget, or a
different theme to hide it. (Stored as `contactmapThemename`.)

## Save

Click **Save configuration**. Load a front‑end page served by the matching theme and
confirm the floating contact pin appears; clicking it should open the map with your
address and click‑to‑call phone number, and visitors can drag the widget around.
