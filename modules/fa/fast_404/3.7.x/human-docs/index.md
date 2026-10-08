# Fast 404 — manual setup guide

**Fast 404** (machine name `fast404`) serves cheap, low‑memory "not found"
responses for requests that Drupal would otherwise handle through its full
bootstrap. When a bot scans your site for `/wp-login.php`, `/xmlrpc.php`, or a
thousand missing `.jpg` files, each of those normally spins up all of Drupal just
to return a 404. Fast 404 intercepts those requests early and returns a tiny
static HTML page instead — using well under a couple of megabytes of RAM — which
dramatically cuts CPU, memory, and database load on busy sites under heavy 404
traffic.

Note the naming: the Drupal.org project and directory are `fast_404`, but the
module's machine name is **`fast404`** — so you enable it with
`drush en fast404`.

It works by registering a single event subscriber that runs two checks on each
request. The **extension check** matches the path against a list of file
extensions (txt, png, css, js, exe, asp, and so on) and returns an immediate 404
if there is no real file on disk. The optional **path check** goes further,
confirming that a dynamic Drupal path actually exists before letting the request
continue. Responses can be upgraded to `410 Gone`, sent with a FastCGI status
header, or replaced with your own custom (even per‑language) HTML page.

Fast 404 has **no admin UI, no config entity, and no permissions**. Everything is
configured through `$settings['fast404_*']` keys in `settings.php`. Just enabling
the module activates the extension check with safe defaults; every other behavior
is opt‑in.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the three install models and every
   `fast404_*` setting, explained in plain language.

## Where it lives in the admin menu

Nowhere — Fast 404 has no admin page. All configuration is done by editing
`settings.php` (see [Configuration](configuration/index.md)).

## How to use it

For most sites, enabling the module is enough: the extension check starts
rejecting requests for missing static files immediately. If you want the more
aggressive dynamic‑path checking, custom error pages, `410 Gone` responses, or
whitelisting for CDN/asset paths, add the relevant `$settings['fast404_*']` keys
to `settings.php`. Command‑line (Drush/CLI) requests are never blocked, and real
static files that exist on disk are served by your web server before Drupal is
ever reached.
