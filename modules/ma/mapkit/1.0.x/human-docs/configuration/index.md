# Configuration

Mapkit itself has no big settings form — it's a framework. Its one admin page
lists the map providers you've installed and links out to each provider's own
configuration. The real work is choosing a provider, granting the right
permissions, and then putting maps onto fields or Views.

## The provider listing page

Go to **Configuration → Web services → Mapkit**
(`/admin/config/services/mapkit`). This page shows every installed map provider
and links to each one's configuration form. If it's empty, you haven't enabled a
provider yet — enable one (e.g. `mapkit_gmap`) and it will appear here, ready to
configure (typically an API key). See that provider's own guide for the key
details.

## Permissions

Mapkit defines two administrative permissions — grant them only to trusted roles
at **People → Permissions** (`/admin/people/permissions`):

- **Administer mapkit providers** — reach the provider listing and each provider's
  configuration (including API keys). This gates the page above.
- **Administer mapkit markers** — manage marker configuration (the MarkerSet
  config entities that group marker styles).

There are no anonymous or content-mutating endpoints; Mapkit ships no provider or
API key itself.

## Putting maps to work

Once a provider is configured, you use Mapkit through Drupal's normal building
blocks:

- **Field formatter** — on a geo-capable field's **Manage display**, choose the
  **Mapkit map** (`mapkit_map`) formatter to render a location (geofield,
  address, or geolocation field) as a map. A geo-parser widens this formatter to
  any field type it can read coordinates from.
- **Views** — build a map display with the **Mapkit location row** plugin, style
  a View as a **Mapkit map**, and add **proximity** distance fields, a distance
  **filter** (search within X of a point), and a location **argument** for
  contextual proximity.
- **Search API proximity** — index a location with Mapkit's Search API location
  data type for scalable proximity search.
- **Form inputs** — add a location **autocomplete** or plain **textfield** input,
  and a "use my location" **geolocation link**, to forms. Autocomplete relies on
  the installed provider supporting it (for example Google Places via
  `mapkit_gmap`).
- **Markers** — group marker styles in a **MarkerSet** config entity (guarded by
  *Administer mapkit markers*).

There's nothing to "save" on Mapkit's own page — configuration happens on each
provider's form, on your fields' Manage display, and in your Views.
