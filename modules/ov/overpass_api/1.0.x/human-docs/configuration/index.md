# Configuration

Overpass API has a small settings form that controls which Overpass endpoint it
talks to and how it handles slow or failing responses. The defaults work against
the public Overpass instance, but for anything beyond light use you'll want to
review them.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → Overpass API**, or navigate directly to
   `/admin/config/system/overpass-api`.

## Settings

- **Overpass API endpoint** — the base URL the client sends queries to. It
  defaults to the public instance at `http://overpass-api.de/api/`, which is slow
  and frequently overloaded. For active or production use, point this at a more
  robust and stable instance — a hosted alternative or, ideally, your own Overpass
  instance. (See the OpenStreetMap wiki for instructions on running your own.)
- **Timeouts** — how long the client waits on the endpoint before giving up. Tune
  these to balance patience with the public API's instability against not hanging
  your own requests for too long.
- **Other options** — the form exposes additional options governing the client's
  behavior. The module already retries queries and handles common Overpass failure
  modes (429 Too Many Requests, 500/504 gateway timeouts, memory overflow) to keep
  behavior stable on the Drupal side; these options let you adjust that handling.

Save the form to apply your changes. The `overpass_api` service will use the new
endpoint and timeouts on its next query.

## Tip: run your own instance for real workloads

The public Overpass endpoint is fine for occasional queries but not for a busy
site. If you rely on Overpass data, running or subscribing to a dedicated instance
and setting it here is the single biggest improvement to reliability.
