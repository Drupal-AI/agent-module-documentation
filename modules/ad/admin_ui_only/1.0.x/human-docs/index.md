# Admin UI Only — manual setup guide

**Admin UI Only** (`admin_ui_only`) locks a Drupal site's themed front end down to
administration pages only. It is built for **decoupled / headless** sites — where
Drupal is used purely as an API or CMS backend (serving JSON:API or GraphQL) and
the public-facing site is a separate application. In that setup there is no reason
for Drupal to serve its own themed front-end pages to visitors, and this module
stops it from doing so.

Under the hood it registers a request-event subscriber that inspects each incoming
request. If the requested route is not an admin route and is not on a configurable
allow-list ("whitelist"), the request is denied with either a **403** or a **404**
(you choose which). The admin UI and your allowed API routes stay reachable;
everything else on the front end is blocked. The module requires **PHP 8.0** and
supports Drupal 9, 10, and 11.

This is a **security-positive hardening** feature — it reduces the front-end
attack and exposure surface of a headless backend. Treat it as a complement to,
not a replacement for, proper per-route access control: it narrows what is
reachable, but each API endpoint still needs its own access rules. The most
important part of setting it up is getting the allow-list right, so that
everything that must stay public (your API routes, the login page, and so on)
remains reachable while nothing sensitive is accidentally left open.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the allowed routes and choose the
   denial response code.

## Where it lives in the admin menu

The module adds a settings form where you define the allowed routes and the error
code returned for blocked requests. Configure it carefully before relying on it —
see [Configuration](configuration/index.md).

## How to use it

Once enabled and configured, the lockdown is automatic: every front-end request to
a non-admin, non-whitelisted route is denied. Test it by requesting a normal
front-end page as an anonymous visitor (you should get your chosen 403 or 404) and
then confirming your API endpoints and the login page still respond normally.
