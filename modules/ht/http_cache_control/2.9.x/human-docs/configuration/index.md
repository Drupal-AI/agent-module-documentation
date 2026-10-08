# Configuration

HTTP Cache Control does not add an admin page of its own. Instead it adds extra
fields to Drupal's core **Performance** page.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Performance**
   (`/admin/config/development/performance`).

The familiar core caching options are still there; the module's fields are added
below and around them, grouped into the sections described here. All values are
saved into a single config object (`http_cache_control.settings`), so they can be
exported and deployed like any other configuration. Changes take effect on the
next response — clear caches with `drush cr` if needed.

## Browser vs shared cache

Core's own **Page cache maximum age** is relabelled **Browser cache maximum
age** — this is the `max-age` browsers use. Alongside it:

- **Shared cache max age** — the `s-maxage` directive, the lifetime that proxies
  and CDNs use. This is the key setting: set it long (say a day, or even a year)
  while keeping the browser max-age short (a few minutes), so the edge does the
  heavy lifting and visitors still get fresh pages.

## Per-status-code lifetimes

You can give error and redirect responses their own shared-cache lifetime instead
of the default:

- **404 (Not Found)** — cache missing-page responses at the proxy for a chosen
  period to blunt floods of requests to bad URLs.
- **301 (Permanent Redirect)** — cache permanent redirects at the edge for a long
  time.
- **302 (Temporary Redirect)** — cache temporary redirects for a short time.

## Revalidation directives

- **stale-while-revalidate** — let a CDN keep serving a slightly stale page while
  it fetches a fresh copy in the background (seconds).
- **stale-if-error** — let a CDN keep serving cached pages when Drupal returns an
  error, so an outage or deploy doesn't take the site down (seconds).
- **must-revalidate** — force caches never to serve stale objects.
- **no-cache** — require revalidation on every request.
- **no-store** — forbid caching entirely (available, but not recommended).

## Vary

- **Vary** — append request header names (for example `Accept-Language`) to the
  `Vary` header so cached responses vary per header. `Cookie` is added
  automatically unless you set `omit_vary_cookie` in `settings.php`.

## Surrogate-Control

Aimed specifically at surrogate proxies (Edge Side Includes):

- **Surrogate max-age** — emits `Surrogate-Control: max-age=N`.
- **Surrogate no-store** — emits `Surrogate-Control: no-store` to keep surrogate
  proxies from caching a response.

## Targeted Cache-Control (per-CDN headers)

This section lets you emit vendor-specific headers that a CDN honours *without*
affecting browser caching — following the RFC 9213 style. Each entry produces one
`{prefix}-Cache-Control` header, where the prefix is something like **CDN**,
**Akamai**, **Cloudflare-CDN**, or any custom value. For each targeted header you
can set:

- **Visibility** — `public` or `private`.
- **max-age** — the edge lifetime in seconds.
- **no-cache**, **must-revalidate**, **no-store**, **no-transform**,
  **proxy-revalidate** — individual directives to add.

For example, a CDN entry might emit `CDN-Cache-Control: public, max-age=3600`.

## Expert mode

The max-age fields normally offer a dropdown of preset values. Tick **Expert
mode** to turn those into free numeric inputs so you can enter any number of
seconds. (This toggle is a UI convenience and isn't stored itself — the form
automatically switches a field to a numeric input whenever its saved value isn't
one of the presets.)

## A note on when directives apply

The module only layers these directives onto **cacheable** responses. An
authenticated or dynamic page that is already marked `no-cache, private` is left
untouched, and `s-maxage` is only added when it is greater than zero, differs from
the response's own max-age, and isn't already present. This is why the settings
mostly matter for anonymous, cacheable traffic served through a proxy or CDN.
