# Configuration

Prelinker's configuration is a list of resource-hint entries you create and manage
under **Configuration → System → Prelinker** (`/admin/config/system/prelinker`).
Because the admin routes require a permission named `administer` that core does not
define, you will typically manage these as **user 1** — see
[Installation](../installation/index.md) for the details.

## Add a preconnect

A **preconnect** tells the browser to open a connection to a host early. Create a
preconnect entry for each third-party origin your pages rely on — a font provider,
an image CDN, an analytics endpoint, a payment provider — giving it the host you
want the browser to connect to ahead of time. Each preconnect is stored as its own
**configuration entity**, so you can list, edit, and export them individually
between environments.

## Add a preload

A **preload** tells the browser to fetch a specific file early. Create a preload
entry pointing at the resource (for example a critical stylesheet or a hero image)
that the page will need during rendering. On Drupal 11, preload link elements
support the **`fetchpriority`** attribute — set it to `high`, `low`, or `auto` to
hint how the browser should prioritise the fetch relative to everything else.

## Restrict when a hint applies (visibility conditions)

Each entry supports Drupal's **condition plugin system**, the same mechanism
blocks use for visibility. Use it to control when an entry is active — for example
preloading a banner image **only on the home page**, or limiting a hint to certain
paths, roles, or request contexts. This keeps hints off pages that do not benefit
from them.

## Choose the delivery mechanism

Prelinker can emit hints two ways, and this is a setting:

- **`Link:` response header** — the more powerful option. Over HTTP/2 or HTTP/3 a
  header can reach the browser before the HTML body arrives, and an intermediary
  (proxy or CDN) can act on it. Requires an HTTP/2-capable server to see the full
  benefit.
- **`<link>` element in the `<head>`** — the hint is written into the page markup.
  Simpler and works everywhere, but arrives no earlier than the head of the
  document.

## Keep the list short

Resource hints are a budget, not a bonus. Every preconnect holds a connection open
and every preload competes for bandwidth with the resources that decide when the
page becomes usable. Aim for a handful of high-value hints — roughly four or five
— rather than adding one for every host; too many is a performance regression, not
an improvement. It is worth auditing your list against a Lighthouse or WebPageTest
run to confirm each hint is earning its place.
