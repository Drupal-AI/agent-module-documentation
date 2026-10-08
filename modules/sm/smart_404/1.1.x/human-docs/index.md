# Smart 404 — manual setup guide

**Smart 404** (`smart_404`) closes the gap between "there are 404 errors on my
site" and "I've fixed them." It automatically logs every 404 (page not found)
response, aggregates the hits per path, and shows them in a clean admin overview
where you can create a redirect for a broken URL with a single click — no server
logs, no analytics dashboards, no command line required.

The Redirect module (`redirect`) does the actual redirecting once you know a URL
is broken; Smart 404's job is to help you *discover* the broken URLs in the first
place. It installs Redirect automatically as a hard dependency, so you get a
complete solution out of the box. Every 404 is captured by an event subscriber
and stored against a normalised path (lowercased, trailing slash stripped, query
string removed), so `/Over-Ons/` and `/over-ons` count as one entry rather than
bloating the table with duplicates. The overview shows each path's hit count,
when it was first and last seen, where the referring traffic came from, and
whether the visitor looked like a bot.

Smart 404 is privacy-conscious by design: it stores **no IP addresses**, calls
**no external services**, keeps external referers as domain-only, and discards
raw user-agent strings the moment it has categorised them as bot / browser /
unknown. It works with zero configuration, but it also offers configurable
retention (cron-based cleanup by age and by maximum record count), glob-based
ignore patterns for known false-positives, and bot-handling options — see the
[Configuration](configuration/index.md) page. It optionally cooperates with the
**Search 404** module so that 404s are still logged even when Search 404 replaces
the error page with search results or a redirect.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A note on what the log contains:** the 404 log records the **URLs people
> actually requested**, which naturally includes whatever visitors — and bots and
> attackers — probe for (things like `/wp-admin/` or `*.php`). Treat the log as
> potentially noisy and attacker-supplied, and grant its permissions only to
> trusted administrators. The redirects you create from it are, of course,
> admin-configured and trusted.

## Contents

1. [Installation](installation/index.md) — install with Composer (Redirect comes
   along automatically), enable it, and grant the permissions.
2. [Configuration](configuration/index.md) — retention, ignore patterns, bot
   handling, and the permissions that gate the overview.

## How to use it

Once enabled, Smart 404 starts logging quietly in the background. Open the **404
overview** — a filterable, paginated table of the paths that returned 404 — to
see what's breaking. From there you can select one or more paths and use the bulk
actions to **create redirects**, **ignore** a path, or **delete** the record. When
you create a redirect, the form is pre-filled with the source path and a suggested
destination: Smart 404's suggestion engine searches your existing path aliases for
a close match (ranked by similarity) and offers the best candidate. There is also
a bulk redirect form so you can select many 404 paths and create all their
redirects from one confirmation page, editing each destination inline. Each path
carries a status — **New**, **Ignored** or **Resolved** — and resolved paths link
to the redirect that fixed them.
