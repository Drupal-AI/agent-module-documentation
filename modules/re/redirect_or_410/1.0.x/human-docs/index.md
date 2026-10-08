# Redirect or 410 — manual setup guide

**Redirect or 410** (`redirect_or_410`) extends the popular
[Redirect](https://www.drupal.org/project/redirect) module with one extra
outcome for an old URL: an **HTTP 410 Gone** response. A redirect says "the
content moved, here is where it went"; a 410 says "this content is gone for
good and is not coming back." Search engines treat the two very differently —
a 410 is de‑indexed faster and more decisively than a plain 404 — so being able
to mark a URL as permanently gone is a useful SEO and URL‑hygiene tool.

The module does not replace Redirect or add a separate workflow. Instead it adds
**410 Gone** as another status option inside the places you already manage
redirects: the Redirect add/edit form and, if you use the **Redirect 404**
submodule that ships with Redirect, the 404 report. When you review a missing
URL you can now decide between three things — redirect it to a replacement,
leave it as a 404, or mark it 410 Gone.

It also includes a **fast 410** option. When enabled, a gone URL returns a
lightweight 410 response with a short configurable message instead of rendering
a full themed Drupal page — handy for bots, crawlers, and high‑volume gone URLs.
When disabled, the site's normal not‑found page is rendered but sent with an HTTP
410 status, so visitors still see your themed error page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect.
2. [Configuration](configuration/index.md) — where the 410 option appears and how
   the fast‑410 behavior works.

## Where it lives in the admin menu

Redirect or 410 adds no admin page of its own. Everything happens inside the
Redirect module's existing screens under **Configuration → Search and metadata →
URL redirects** (`/admin/config/search/redirect`) — the redirect add/edit form
and, when enabled, the Redirect 404 report.
