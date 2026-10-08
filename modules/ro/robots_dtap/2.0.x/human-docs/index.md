# Robots DTAP — manual setup guide

**Robots DTAP** (`robots_dtap`) keeps your non-production environments out of
search engines. On a typical DTAP setup — **D**evelopment, **T**est,
**A**cceptance, **P**roduction — you never want Google indexing your staging or
acceptance copies, because that leaks pre-launch content and creates
duplicate-content problems. This module solves that by adding a
`<meta name="robots" content="noindex, nofollow">` tag to **every page**, on every
environment *except* the ones you've recognised as production.

The clever part is that it decides based on the current **HTTP host**, not on
per-environment settings files. You list your production domain(s) once, in a
single admin form, and the module compares the incoming request's host against that
list on each page. If the host is one of your production domains, nothing is added
and the site indexes normally. If it isn't (and the list is non-empty), the
noindex/nofollow meta tag goes into the page head. Because the decision is
host-based, the **same configuration export works across all your environments** —
you don't have to override anything in `settings.php` per environment.

One scope note: this module works purely at the **meta-tag** level. It does not
create or manage a physical `robots.txt` file — if that's what you need, look at a
robots.txt-focused module instead. Robots DTAP is deliberately small and additive:
it only ever *adds* a meta tag, and never exposes data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — list your production domains so
   everything else is treated as non-production.

## Where it lives in the admin menu

Robots DTAP adds a single settings form under **Configuration → System → Robots
DTAP** (`/admin/config/system/robots_dtap/settings`), gated by the **access
administration pages** permission. That form is the only thing you need to touch —
see the [Configuration](configuration/index.md) guide.
