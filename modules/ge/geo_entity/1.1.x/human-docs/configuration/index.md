# Configuration

Geo Entity is configured like any custom content entity: you define **bundles**
("geo types"), add fields and displays to them, wire up a reuse library on your
reference fields, and manage permissions. Geocoding providers are configured
through the Geocoder and Leaflet modules.

## Geo types (bundles)

Manage bundles at **Structure → Geo types** (`/admin/structure/geo_types`). Adding
or editing a geo type presents exactly three inputs:

- **Bundle label** — the human-readable name.
- **Machine name (id)** — the bundle's machine id.
- **Default entity label** — a **Token** template used to build each geo's label
  automatically. For example
  `[geo_entity:postal_address:locality], [geo_entity:postal_address:country_code]`.

### How the token label works

Every time a geo entity is saved, the module runs the bundle's label token through
the Token module and stores the plain-text result as the entity's label. Because of
this, the label field's own widget is hidden on the edit form — the label is
auto-managed for any bundle that sets a token. This keeps titles consistent and
saves editors from typing them.

The concrete **address** and **area** bundles (with their `location` geofield,
postal address, geo-file, and other fields) are installed by the
**geo_entity_address** and **geo_entity_area** submodules — not by the base module.

## Fields and displays

Add fields, arrange the form, and configure the view display through the normal
**Field UI** on each geo type's edit page, just like a content type. The base
module ships **full** and **embed** view modes and an **inline** form mode ready to
use.

## The reuse library (Entity Browser)

This is what makes Geo Entity a "location library." The module ships a preconfigured
**Entity Browser** (`geo_entity_library`) and a Views-based picker. To let editors
reuse a stored location from another entity:

1. On the host entity, add an **entity reference** field that targets Geo entities.
2. On that field's form display, choose the **Entity Browser (Entity Reference)**
   widget and select the **geo_entity_library** browser.

The browser gives editors a searchable popup of existing geos; when the reference
field is limited to certain bundles, the browser automatically hides the tabs for
bundles it doesn't target. One stored location can then be referenced across many
host entities.

## Geocoding and map providers

Geo Entity ships pointed at **OpenStreetMap** tiles (through Leaflet) and the
**OSM/Nominatim** geocoder. Both are ordinary Leaflet and Geocoder configuration, so
to switch to a commercial provider, reconfigure the Geocoder providers at
**Configuration → System → Geocoder**
(`/admin/config/system/geocoder/geocoder-provider`). The address submodule's
autocomplete and the area submodule's file geocoders use whatever providers are
configured there.

## Permissions

Geo Entity defines an ownership-aware set of permissions (People → Permissions):

| Permission | Notes |
|------------|-------|
| **Administer geo** | Full access to all geo entities (bypasses the checks below). Restricted. |
| **Administer geo types** | Manage geo bundles. Restricted. |
| **Access geo overview** | The geo listing/overview page. |
| **Create geo** | Create geo entities. |
| **View geo** | View geo entities. |
| **Edit any geo** / **Edit own geo** | Edit any location, or only ones the user authored. |
| **Delete any geo** / **Delete own geo** | Delete any location, or only ones the user authored. |

The "own" variants use ownership — a geo is owned by whoever created it — so you can
give editors *edit own / delete own* while trusted staff get *edit any*.

> **Default view access.** On install, **View geo** is granted to both the anonymous
> and authenticated roles, so stored locations are public by default (matching core
> Media's behaviour). If any of your locations are sensitive, revoke *View geo* from
> the anonymous role after install.

## Optional REST resource

The module ships an optional REST resource config (`rest.resource.entity.geo_entity`)
if you want to expose geo entities over REST — enable and configure it through the
REST/RESTful Web Services tooling as usual.
