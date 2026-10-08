# Routing Access Check Headers — manual setup guide

**Routing Access Check Headers** (`routing_access_check_headers`) is a **developer
module**. It adds a new route access check, `_routing_access_check_headers`, that
validates an incoming request's **HTTP headers** against a named profile before the
route is allowed. The typical use is protecting internal or "public but not really
public" endpoints — XHR/JSON APIs, headless front‑end calls, or iframe embeds —
that should only be reached in a particular request *shape* and never called
directly from an external source.

It ships with plugin‑based profiles: an `xhr` profile (allows programmatic
requests carrying `X-Requested-With`) and an `iframe` profile, and you can write
your own profile plugin to validate custom headers, the `Origin` header, or the
`Referer` header. The check is **fail‑closed**: a missing or unknown profile
returns forbidden, mirroring core's own CSRF header access check.

**There is no UI and it does nothing on its own** — it only takes effect once you
attach the requirement to a route (in a route definition), so it is used from
code, not from the admin screens.

The security caveat is essential and the module's own documentation is blunt about
it: **HTTP request headers are supplied by the client and can be spoofed or
omitted.** Header validation makes it *harder* for an external actor to hit an
endpoint — it is not a safe security measure on its own. Treat it as
**defense‑in‑depth** and combine it with real protections: authentication, CSRF
tokens (it composes with core's `_csrf_token` check), and/or rate limiting.
Header checks are only trustworthy for values set by a component you control, such
as a trusted reverse proxy — never rely on them alone to keep a route safe.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module is used from route definitions and
custom code, as described below.

## How to use it

1. Add the requirement to a route in a module's `*.routing.yml`, naming a profile:

   ```yaml
   my_module.api_endpoint:
     path: '/api/example'
     defaults:
       _controller: '\Drupal\my_module\Controller\ExampleController::handle'
     methods: [GET]
     requirements:
       _routing_access_check_headers: 'xhr'
   ```

2. Use a built‑in profile (`xhr` or `iframe`) or create your own profile plugin in
   your module's `Plugin/RoutingAccessCheckHeadersProfile` namespace to validate
   custom headers, `Origin`, or `Referer`.
3. For routes that accept state‑changing requests (for example POST), also add
   Drupal's CSRF check alongside the header profile:

   ```yaml
   requirements:
     _routing_access_check_headers: 'my_profile_id'
     _csrf_token: 'TRUE'
   ```

See the sibling `agent/` docs and the module's project page for the full profile
plugin attribute reference.
