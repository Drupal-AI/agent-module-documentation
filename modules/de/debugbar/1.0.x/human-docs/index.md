# Debug Bar — manual setup guide

**Debug Bar** (`debugbar`) integrates the well-known
[PHP Debug Bar](https://github.com/maximebf/php-debugbar) library into Drupal,
rendering an on-page bar that shows information about the current request. It's a
developer's inspection tool: at a glance you can see Drupal log messages, POST and
GET variables, site settings, the current route name and its parameters, and any
exceptions that occurred.

The module depends on the **Vendor Stream Wrapper** module and on the
`maximebf/debugbar` Composer package (installed automatically when you require the
module with Composer). It supports a very wide range of Drupal versions (9 through
12). Note its project status: it is **seeking a new maintainer** and marked "no
further development", so evaluate it accordingly before adopting it long-term.

> **Development only — never enable this in production.** The bar deliberately
> exposes internal request details (settings, request variables, exceptions), which
> is exactly what you don't want visible on a live site. Use it on local and
> staging environments and keep it disabled in production.

The nicest part of the setup: there's nothing to configure. Once the module is
enabled, the debug bar simply appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the Debug Bar library), enable the module, and optionally add the Twig pane.

There is **no configuration form** — enable the module and the bar starts
displaying.

## How to use it

After enabling, browse your site as normal and the debug bar renders at the bottom
of the page, with tabs for log messages, GET/POST variables, site settings, the
route, and exceptions. To also inspect Twig rendering, enable the bundled
**Debug Bar Twig** submodule, which adds a Twig pane to the bar. When you're done
debugging, disable the module — especially before deploying anywhere public.
