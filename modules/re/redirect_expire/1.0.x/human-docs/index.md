# Redirect Expire — manual setup guide

**Redirect Expire** (`redirect_expire`) adds an expiry date to redirects, so
temporary redirects clean up after themselves instead of living forever. It
extends the contrib Redirect module: a redirect can be given a date after which it
stops working, and the module can optionally delete expired redirects on cron so
they do not clutter the redirect table.

This is handy for redirects that are meant to be short-lived — a campaign URL, a
seasonal landing page, a temporary move — where leaving a permanent redirect
behind would just accumulate cruft over time. The module adds a base field to the
redirect entity and uses it to decide whether each redirect is still active.

It has no content or access role of its own and no site-wide settings page — you
set an expiry per redirect on the standard Redirect add/edit form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Redirect
   module it depends on, and enable it.

There is **no dedicated configuration page** for this module. You set an expiry on
each redirect individually, described in "How to use it" below.

## How to use it

1. Create or edit a redirect the usual way, via the Redirect module at
   **Configuration → Search and metadata → URL redirects**
   (`/admin/config/search/redirect`).
2. On the redirect's add/edit form you will find the **expiration** field that
   this module adds. Set the date after which the redirect should stop working.
   Leave it empty for a redirect that should not expire.
3. Once the expiry passes, the redirect no longer resolves — the module checks the
   expiry field when deciding whether a redirect is active.
4. To have expired redirects **removed** automatically (rather than just
   deactivated), enable the module's cron-based deletion; the cleanup then runs on
   your site's normal cron schedule. If you would rather keep expired redirects
   for the record, leave that off and they simply remain inactive.
