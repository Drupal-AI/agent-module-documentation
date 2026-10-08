# Disable UI — manual setup guide

**Disable UI** (`disable_ui`) is built for **headless / decoupled** Drupal sites,
where Drupal serves an API and a separate front-end application renders the actual
site. On such a site you usually don't want ordinary authenticated users — the app's
logged-in consumers — to be able to browse Drupal's own themed HTML pages; only
admins and developers should reach the UI. This module makes that happen by adding a
new permission, **Access UI routes**, and requiring it on every non-API HTML route.

It works by adding an extra access requirement to routes as they are built. Any route
it considers an HTML page gets a `_disable_ui` requirement that only users with the
`access ui route` permission can satisfy. Routes it recognises as API routes are left
alone — a route counts as an API route when its `_format` requirement starts with
`api_` or ends with `json`, which covers core's RESTful Web Services and JSON:API. A
handful of essential routes are also left open by default so the site keeps working:
user login and logout, password reset, the CSRF token endpoints, the CSS and JS asset
routes, and the menu linkset route.

The design is deliberately **safe and additive**: the new requirement is *ANDed* with
each route's existing access rules, so Disable UI can only make a route *more*
restrictive — it can never loosen or bypass an access control you already have. That
makes it a low-risk thing to add to a decoupled backend.

It needs nothing but Drupal core and supports Drupal 8.7.7 through 11. Note the
project is **minimally maintained**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. Setup
is two things: grant the **Access UI routes** permission to the right roles, and, if
you have custom HTML pages that must stay public, add them to the exclusions. Both are
described below.

## How to use it

**1. Grant the permission.** After enabling, go to **People → Permissions**
(`/admin/people/permissions`) and give **Access UI routes** (`access ui route`) to
every role that must reach themed HTML pages — administrators, developers, and any
editor role that legitimately needs the Drupal UI. Ordinary decoupled API consumers
do **not** need it; that's the whole point. Revoking the permission (or uninstalling
the module) rolls the change back.

**2. Keep the login form reachable.** The default exclusions already leave login,
logout, and password reset open, so admins can still sign in and locked-out users can
still recover — you don't need to do anything for those.

**3. Handle any custom HTML endpoints.** If you have a custom route that must stay
publicly reachable, you have two options:

- If it's actually an **API** endpoint, give its route an appropriate `_format`
  requirement (starting with `api_` or ending in `json`) so Disable UI recognises it
  as an API route and leaves it alone.
- If it's a genuine **HTML page** that should stay public, exclude it in code by
  implementing `hook_disable_ui_route_exclusions()`, which returns an array of route
  machine names to leave unrestricted:

```php
function mymodule_disable_ui_route_exclusions(): array {
  return ['mymodule.public_page', 'mymodule.webhook'];
}
```

A useful sanity check after enabling: confirm that anonymous API clients are
unaffected, that admins can still reach the UI, and that any custom controller with no
`_format` (which is treated as HTML, and therefore restricted) is either excluded or
given a proper format.
