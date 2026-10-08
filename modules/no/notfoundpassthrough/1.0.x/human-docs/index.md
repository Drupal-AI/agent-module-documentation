# Page Not Found Passthrough — manual setup guide

**Page Not Found Passthrough** (`notfoundpassthrough`) catches **404 "page not
found"** errors on your site and tries to find the missing content on one or more
**fallback domains** you configure. If a matching path is found on a fallback host,
the visitor is redirected there; if none of the fallbacks have it, you can send the
visitor to a custom 404 page, show a message, or route them to a site‑search URL.

Its main use is a **gradual migration** onto Drupal from another system (Drupal or
not). Say you've moved your home page to Drupal on `example.com` but the rest still
lives on a legacy site. A URL such as `example.com/department` would now 404. With
`legacy1.example.com` and `legacy2.example.com` configured as fallbacks, the module
tries `legacy1.example.com/department`, then `legacy2.example.com/department`, and
redirects to whichever one resolves — so old URLs keep working while you migrate
content piece by piece. It's the Drupal 8/9/10/11 port of the old *Redirect 404*
module.

It depends on the **Redirect** module and is configured at
`notfoundpassthrough.settings`. One security‑relevant point to know: on a 404 the
module makes a **server‑side request** to your fallback host(s) to check for the
path. Because those hosts are **admin‑configured** (not chosen per request by
visitors), this is not open SSRF — but you should still keep the fallback list to
**trusted hosts** and use **HTTPS**, since the requested path is forwarded to them.

One compatibility note: requests handled by the **Fast 404** module run first and
are handled by Fast 404 on their own, so they won't reach this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Redirect.
2. [Configuration](configuration/index.md) — set the fallback domains, the 404
   handling, and point Drupal's default 404 page at the module.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Search and metadata →
Page Not Found Passthrough (Redirect on 404)**. You also point core's default 404
page at the module in **Configuration → System → Basic site settings**.
