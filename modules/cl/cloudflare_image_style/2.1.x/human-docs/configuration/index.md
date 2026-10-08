# Configuration

This module has no central settings page. Instead it adds two fields to each
**image style's** edit form, so you decide style by style which ones are served
from Cloudflare. This keeps a check on the cost of Cloudflare's resizing service —
only the styles you opt in are sent through it.

## Open an image style

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Click **Edit** on the style you want to serve from the CDN (or add a new one
   first). The edit URL looks like
   `/admin/config/media/image-styles/manage/<style>`.

## The two fields

The module adds these to the image style edit form:

- **Serve from Cloudflare** (Yes / No) — set this to **Yes** to have this style's
  images delivered through Cloudflare's image‑resizing CDN in production. This
  relies on the enterprise Cloudflare Images feature being available on your zone.
  Leave it **No** to keep the style behaving as a normal Drupal image style.
- **Cloudflare Effect** — the effect string that is placed into the Cloudflare
  URL, i.e. the `<effect>` in `/cdn-cgi/image/<effect>/…`. This is where you
  express the resizing/transformation you want Cloudflare to apply (following
  Cloudflare's image‑resizing URL‑format syntax).

## How it behaves after you save

Both values are saved onto the `image.style.<name>` configuration object. When a
style is set to serve from Cloudflare, the module rewrites the rendered image URI
to `/cdn-cgi/image/<effect>/<target>` so the CDN produces the derivative.

On an environment that is **not** behind Cloudflare (local or staging), the very
same URL is handled locally: an inbound path processor pulls the style and file
path out of the request, and a fallback controller regenerates the derivative
through Drupal's normal image pipeline. That fallback is confined to the public
files scheme (`public://`), so it cannot be tricked into reading files elsewhere,
and Drupal's usual image‑derivative token validation still applies.

## Save

Click **Save** on the image style form. Because the fallback regenerates
derivatives in PHP on non‑CDN environments, expect a little more PHP work there —
in production, where Cloudflare serves the images, that cost does not apply.
