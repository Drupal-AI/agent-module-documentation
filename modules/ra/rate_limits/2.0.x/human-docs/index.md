# Rate Limits — manual setup guide

**Rate Limits** (`rate_limits`) lets you cap how often a given set of routes can be
requested, enforced on the server for every request. When a caller exceeds a limit
the module returns a standards-compliant **HTTP 429 "Too many requests"** response
and stops the request before your code runs. It reuses Drupal core's **Flood**
service for the actual counting, so limits share the site's flood storage and
cleanup.

This is a security / anti-abuse tool. Typical uses include slowing down
credential-stuffing on a login or password-reset route, throttling an expensive
API or search endpoint, protecting a form from rapid automated resubmission, and
curbing scraping of a download route. You can apply a per-IP limit and a
per-authenticated-user limit to the same route, and combine a strict short-window
burst limit with a looser long-window global limit.

There is one important design point to understand before you rely on it: **a route
is only rate-limited if it has been "tagged".** Routes carry tags in their route
options, and a Rate Limit Config entity targets routes by those tags. Until you
both (a) tag the routes you want to protect and (b) create a matching config
entity, the module enforces nothing. Tagging your own routes is a small edit to a
`*.routing.yml` file; tagging another module's routes needs a small route
subscriber (a developer task). Because of this, Rate Limits is aimed at sites with
some developer involvement, not a pure point-and-click install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a Rate Limit Config entity,
   understand the four limit "buckets", tag routes, and the bypass permission.

## Where it lives in the admin menu

The limit entities are managed at **Structure → Rate Limit Config**
(`/admin/structure/rate_limit_config`), gated by the **Administer site
configuration** permission.

## How to use it

At a high level: decide which routes to protect and give them one or more **tags**
(a developer step in routing YAML or a route subscriber); then create a **Rate
Limit Config** entity whose tags match, and set its per-route and global limits.
From then on, every matching request is checked against four limit buckets
(per-route IP, per-route user, global IP, global user) and blocked with a 429 if
any bucket is over its limit. Roles that hold the **Skip rate limit checks**
permission bypass all limits. The full walkthrough is in
[Configuration](configuration/index.md).
