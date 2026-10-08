# Generic HTTP Purger — manual setup guide

**Generic HTTP Purger** (`purge_purger_http`) is an add‑on for the **Purge**
framework that clears an external cache — a Varnish server, an nginx reverse proxy,
a CDN edge, or any in‑house caching layer — by firing HTTP requests at it whenever
Drupal invalidates content. It is deliberately generic: every part of the request
(method, scheme, host, port, path, headers, and body) is configurable, and the
values are token‑aware, so you can shape the request to match whatever API your
cache expects without writing any code.

It gives you two flavors of "purger" to choose from. The **HTTP purger** sends one
request per invalidation (for example, one request per changed URL), while the
**Bundled HTTP purger** sends a single request covering a whole batch of
invalidations at once — useful for cutting request volume against a CDN that
accepts many tags in one call. Both are multi‑instance, so you can run several at
once — say, one for Varnish and one for a CDN.

Because the request fields understand Purge's tokens, you can template them per
invalidation: put `[invalidation:expression]` into a header to send the exact cache
tag being cleared, or embed an `[invalidations:…]` token in a JSON body for a
bundled API call. A built‑in diagnostic check warns you on Purge's status page if a
purger is missing a required field or has a mismatched scheme and port.

This module has **no admin page of its own** — you add and edit purger instances
through the Purge UI. It depends on the **Purge** and **Purge Tokens** modules. The
bundled **Generic HTTP Tags Header** submodule adds a `Purge-Cache-Tags` response
header so a tag‑aware proxy can invalidate by tag.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, note the Purge
   dependencies, and enable the optional tags‑header submodule.
2. [Configuration](configuration/index.md) — add a purger through the Purge UI and
   fill in every request field.

## Where it lives in the admin menu

You manage purgers through Purge at **Configuration → Development → Performance →
Purge** (`/admin/config/development/performance/purge`). This module adds its
purger types there; it has no separate settings link. The status of your purgers
(including this module's diagnostic check) also appears on that Purge page.

## How to use it

1. Make sure Purge is set up with a queue and processors (that is Purge's own job).
2. On the Purge page, click **Add purger** and choose **HTTP purger** or **Bundled
   HTTP purger**.
3. Edit the new instance and fill in the request details — host, port, method,
   path, headers, and any body — using tokens where the request needs to vary per
   invalidation. See [Configuration](configuration/index.md) for every field.
4. Save. From then on, when Drupal invalidates content, Purge drains its queue and
   this purger sends the matching HTTP requests to your cache.
