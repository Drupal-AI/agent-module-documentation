# Domain Short URL — manual setup guide

**Domain Short URL** (`domain_shorturl`) makes the **Short URL** module
domain-aware on multi-domain sites. It is part of the **Domain** ecosystem and
depends on the `shorturl` module, the base `domain` module, and **Domain Redirect**
(`domain_redirect`).

On a single site, a short URL slug like `/blog` is unique site-wide. On a
multi-domain install that is limiting — you may want `/blog` to exist on several
domains, each pointing somewhere different. Domain Short URL adds exactly that. It
gives short-URL nodes a **domain** field and scopes everything by domain: full URLs
are built using the assigned domain's hostname and path prefix, redirects are
stamped with the right domain, visit tracking records the domain, auto-increment
slug counters can run per-domain, and slug uniqueness is validated within a
`(domain, language)` pair rather than globally. The node form filters the domain
selector to the domains a user is assigned (via Domain Access) unless they hold the
**`create shorturl on any domain`** permission.

It is implemented cleanly by decorating Short URL's own manager and slug generator
rather than replacing them, and it has a tight security posture: its only route is
the settings form, slugs resolve to internal short-URL nodes (so there is no
open-redirect surface), and its per-domain queries use bound parameters. Setup is
short — enable it alongside its dependencies, pick your counter scope on the
settings form, and assign a domain when you create a short URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Short URL, Domain, and Domain Redirect.
2. [Configuration](configuration/index.md) — choose the counter scope and assign
   domains to short URLs.

## Where it lives in the admin menu

The settings form is at **Configuration → Domain → Short URL**
(`/admin/config/domain/shorturl`), gated by the **`administer shorturl`**
permission. Day-to-day, you assign a domain on the short-URL node form itself.
