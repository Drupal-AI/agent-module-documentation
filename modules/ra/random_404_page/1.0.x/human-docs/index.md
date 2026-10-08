# Random 404 page — manual setup guide

**Random 404 page** (`random_404_page`) lets you configure *several* "page not
found" (404) and "access denied" (403) pages and serves one of them at random
each time an error is raised. Drupal core only ever lets you pick a single 404
page and a single 403 page; this module removes that limit so you can rotate
across a pool of curated error pages.

The way it works is simple and unobtrusive. It does not add a new settings
screen of its own. Instead it takes over core's **Basic site settings** form:
where core normally shows one "Default 404 page" field and one "Default 403 page"
field, this module replaces them with two text areas where you list one path per
line. At runtime an event subscriber picks a path at random from the relevant
list and serves it through the very same access-checked mechanism core uses for a
single custom error page — so nothing you couldn't already show is exposed, and
the correct 404/403 HTTP status is preserved.

Because it reuses core's machinery, there is no extra permission to grant and no
external service involved. Leave a list empty and the module simply falls back to
core's normal behavior for that error type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how to enter your pool of 404 and
   403 paths on the site-information form.

## Where it lives in the admin menu

There is no dedicated settings page. You configure everything on the standard
**Configuration → System → Basic site settings** form
(`/admin/config/system/site-information`), which the module extends with two
"pages" text areas once it is enabled.
