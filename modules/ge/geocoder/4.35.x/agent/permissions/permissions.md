# Permissions

`geocoder.permissions.yml` defines one permission:

| Permission | Gates |
|---|---|
| `access geocoder api endpoints` | Access to the two GET REST endpoints `/geocoder/api/geocode` and `/geocoder/api/reverse_geocode`. |

Grant this to whichever role needs to call the geocoding endpoints (e.g. authenticated users
using a JS address autocomplete, or `anonymous` for a public store-locator search). Because the
endpoints hit third-party providers (and can incur API cost / rate limits), scope it to the roles
that actually need it rather than granting it broadly.

Configuration pages (`geocoder.settings` and the `geocoder_provider` add/edit/delete/collection
routes) are gated by core's `administer site configuration`, not by this permission — so choosing
providers, their base URLs and their API keys stays an administrator-only operation.
