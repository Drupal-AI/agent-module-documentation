# Configuration

Setting up TEVIS is a two-step job: first register a TEVIS server so Drupal knows
how to reach your reservation backend, then place the block that shows
availability. Both require the `administer tevis` permission.

## Create a TEVIS server

1. Go to **Configuration → Web services → TEVIS**
   (`/admin/config/services/tevis`). This is the server collection list.
2. Add a new server and fill in its details:
   - **API endpoint** — the URL of your VOIS|TEVIS reservation API.
   - **API key** — the credential TEVIS issued for API access. It is stored on
     the server configuration entity.
   - **Connect timeout** and **request timeout** — how long the client waits
     when opening a connection and when waiting for a response. Tune these if
     your TEVIS instance is slow to answer; the defaults are a reasonable
     starting point.
3. Save the server. It appears in the list, where you can later edit, enable,
   disable or delete it. The enable/disable links are protected by CSRF tokens,
   so they only work from within the admin UI.

You can register more than one server — for example a test endpoint and a
production endpoint — and enable whichever you need.

## Place the availability block

Once a server exists, TEVIS provides a **block** that displays the next
appointment availabilities per location. Add it through the normal block layout
(**Structure → Block layout**): place the TEVIS availability block into a region,
configure which availabilities it should show, and save. Visitors then see the
upcoming slots and can move into the booking process.

## How the data is fetched

Behind the scenes, TEVIS reads availability from your server and **caches** the
results, so the same slot lookups are not re-requested on every page load. When
you change a server's configuration the cached availability is refreshed. The
HTTP client is built from Drupal core's standard client factory with normal TLS
verification in place, so traffic to your TEVIS endpoint uses secure defaults.
