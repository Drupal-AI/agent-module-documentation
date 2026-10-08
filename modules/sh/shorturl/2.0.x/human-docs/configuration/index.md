# Configuration

Short URL works sensibly once enabled, but the settings form lets you shape how new
short links behave, and its permissions let you decide who can do what.

## Open the settings form

Go to **Configuration → Short URL settings** (`/admin/config/shorturl/settings`). You
can adjust:

- **Base36 slug length** — how many characters random slugs use, from 4 to 12.
- **Default redirect status code** — 301 (permanent), 302 (found), or 307 (temporary
  redirect) for the redirects Short URL creates.
- **Destination type** — whether short URLs may point only to external URLs, or to
  both internal and external destinations.
- **QR code format** — the default format returned, PNG or SVG.
- **Visit tracking** — enable or disable counting of visits.
- **Browser cache control** — optionally send a `no-store` header on redirects so that
  browser caching does not skew your visit counts.

## Slug modes

Every short URL uses one of three slug modes, chosen per node and restricted by
permission:

| Mode | Permission needed | Example |
|------|-------------------|---------|
| **Custom** | *Use custom short URL slugs* | `promo` |
| **Base36** | *Use base36 short URL slugs* | `k9m2x7` |
| **Auto-increment** | *Use auto-increment short URL slugs* | `42` |

Because a custom slug lets someone choose exactly what the short link reads as, treat
the custom-slug permission as one you grant to trusted users.

## Permissions

Short URL ships granular permissions so you can hand out just the right amount of
capability: the three slug-mode permissions above, plus permissions for viewing
statistics, accessing the REST API, and administering the module. Set these under
**People → Permissions**.

## The REST API

Every API endpoint requires the **Access Short URL API** permission:

| Endpoint | What it does |
|----------|--------------|
| `GET /api/shorturl/expand/{slug}` | Expand a slug to its destination URL |
| `GET /api/shorturl/stats/{nid}` | Visit statistics for one short URL |
| `GET /api/shorturl/db-stats` | Aggregate database statistics |

## QR codes

QR images are available directly by slug:

- `/api/shorturl/qr/{slug}` — the default format (as set in the settings form)
- `/api/shorturl/qr/{slug}/png` — PNG
- `/api/shorturl/qr/{slug}/svg` — SVG

## Statistics and multi-language

Each short URL node has a statistics dashboard with traffic charts, referrer
analysis, and country-of-origin mapping. Country detection is optional and relies on
the Smart IP module. The module also supports per-translation redirects with
language-neutral fallbacks for multilingual sites.
