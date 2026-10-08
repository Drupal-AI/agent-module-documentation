# EDW Health check monitoring — manual setup guide

**EDW Health check monitoring** (`edw_healthcheck`) exposes your Drupal site's
status — its core, module, and theme versions and update state — as **JSON at a
single endpoint**, so an external monitoring system can poll it. It is built for
the fleet problem: an organisation running many Drupal sites needs to know,
centrally, which ones are behind on security updates, and asking each site's update
report by hand does not scale. Point a dashboard at every site's endpoint, poll it
nightly, and you get one list of what needs patching.

The endpoint lives at `/edw_healthcheck/{type}`. It draws its version data from
core's **Update** module and is protected by core's **Basic Auth** module — those
are its two dependencies. Access is deliberately *not* open: the route requires an
**EDW healthcheck access** permission and accepts HTTP basic auth (or a session
cookie), so a monitoring system authenticates as a dedicated account rather than
the data being public.

That protection matters, and it is the main thing to get right when you run a
module like this. The payload is essentially a reconnaissance document: an exact
list of installed modules with exact versions is precisely what an attacker wants,
because it turns "try known Drupal exploits" into "look up the advisories for these
versions". A site that exposes this anonymously has published its own vulnerability
inventory. Two practical rules follow (see "How to use it").

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Update / Basic Auth dependencies.

There is **no settings form** for this module. Setup is entirely about creating the
monitoring account and granting it the access permission, described in "How to use
it" below.

## Where it lives in the admin menu

The module adds no admin settings page. Its permission is granted at **People →
Permissions** (`/admin/people/permissions`), and its data is served from the
endpoint `/edw_healthcheck/{type}` (not a page you browse to interactively — a
monitoring system requests it).

## How to use it

1. Create a **dedicated user account** for your monitoring system.
2. Create a role for it and grant that role **only** the **EDW healthcheck
   access** permission at **People → Permissions** — nothing else. Assign the role
   to the monitoring account. Keep its credentials wherever your monitoring system
   stores secrets, not in a shared password.
3. Point your monitoring system at `/edw_healthcheck/{type}` and have it
   authenticate with HTTP basic auth as that account. It receives the status as
   JSON.

> **Serve it over TLS.** HTTP basic auth sends the password on every poll, so the
> endpoint must be reached over HTTPS. This is easy to overlook on an internal
> monitoring path nobody thinks of as public — but the credentials (and the
> version inventory) travel on every request, so TLS is not optional here.
