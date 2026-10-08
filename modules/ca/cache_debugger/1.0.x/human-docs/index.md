# Cache Debugger — manual setup guide

**Cache Debugger** (`cache_debugger`) is a development tool that turns on Drupal's
**render cache debugging** from the admin UI, so you can inspect caching behaviour without
hand‑editing `services.yml`. Once enabled, Drupal appends cache metadata — cache
**contexts**, **tags**, and related information — to each rendered element in the page's
HTML output. Visit any page and you can read, straight from the markup, why an element is
(or isn't) being cached, which is exactly what you need when troubleshooting caching
issues and improving cacheability.

The way it works is worth understanding: enabling render cache debugging makes the module
create a copy of `default.services.yml` as `services.yml` with `debug: true` set; turning
it off removes that `services.yml` file again. So the module is really a convenient switch
over the same setting you would otherwise edit by hand.

**This module is for development environments only.** Render cache debugging carries a
significant performance cost and adds debug output to the page markup, so it should never
be enabled on a production site. Access to the toggle is gated by the **Administer cache
debugger configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the on/off toggle for render cache debugging.

## Where it lives in the admin menu

The module's configuration page is at **Configuration → Development → Cache Debugger**
(`/admin/config/development/cache-debugger`), gated by the **Administer cache debugger
configuration** permission.

## How to use it

Enable the module, open its configuration page, and switch render cache debugging on. Then
visit any page on the site and view the HTML output — you will see cache contexts, tags,
and other cache metadata appended to each rendered element. Switch it back off (which
removes the generated `services.yml`) when you are finished.
