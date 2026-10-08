# Configuration

## Prerequisites

Before the redirect can do anything useful:

1. **Configure Smart IP.** Go to `/admin/config/people/smart_ip` and choose the
   main geolocation data source (a local GeoIP database or a web service such as
   MaxMind GeoIP2 Precision). Set Smart IP's **roles to geolocate** — only
   visitors whose role is in that list are ever redirected.
2. Make sure **Redirect**, **Locale**, and **Path alias** are enabled (they are
   installed as dependencies).

## Open the settings form

1. Log in as a user with the **access smart IP locale redirect settings**
   permission.
2. Go to **Configuration → Search and metadata → Smart IP Locale Redirect**
   (`/admin/config/search/smart_ip_locale_redirect`).

## The settings

**Country → language mappings.** For each country code (lowercase ISO code) pick
the site language a visitor from that country should be sent to. This is the core
of the module: an unmapped country is simply not redirected. You can add mappings
here and delete an existing one from the same admin screen.

**Cookie settings.** Control the `smart_ip_hl` cookie that remembers a visitor's
resolved language so they are not re-geolocated on every request:

- **Duration** — how long the cookie lives, in seconds (default **432000**, i.e.
  five days).
- **Path** — the cookie path (default `/`).
- **Domain** — the cookie domain, useful if you serve several subdomains.

**Excluded user-agents.** A list of regular-expression patterns, one per line. Any
user-agent matching a pattern is never redirected — add crawlers such as
`Googlebot` and `bingbot`, and any uptime monitors, so they always see a stable,
un-redirected site.

## How the redirect decides

Even with mappings in place, the module intentionally leaves many requests alone.
It only redirects `GET`/`HEAD` requests hitting the front controller, and it
automatically skips:

- admin routes and the node edit form,
- maintenance mode,
- file requests under `/sites/default/files/`,
- any excluded user-agents,
- visitors whose role is not in Smart IP's "roles to geolocate" list.

Page cache is disabled only while a page is negotiating; once the visitor is on the
correct language prefix the subscriber returns early and normal caching resumes.

## Switching language afterwards

Because the `smart_ip_hl` cookie keeps steering the visitor to its stored language,
you **cannot** change the language just by editing the URL. To switch, either use
the site's **language switcher** or append `update_hl=LANGCODE` to the path in the
address bar — that query parameter rewrites the cookie to the language you name.

## A note on trusted proxies and accuracy

For the country lookup to be correct, Drupal must receive the real client IP, so
configure trusted-proxy settings if you run behind a load balancer or CDN. Bear in
mind IP geolocation is a heuristic that VPNs, proxies, and mobile carriers will
defeat, which is exactly why the switch-back mechanisms above matter. The redirect
target is always your own host with the langcode and path appended, so it cannot be
pointed at an external site.
