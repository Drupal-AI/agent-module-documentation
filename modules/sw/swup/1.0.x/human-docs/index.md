# Swup — manual setup guide

**Swup** (`swup`) integrates the [Swup.js](https://swup.js.org) library with
Drupal to give your site smooth, app-like page transitions. Instead of the
browser fully reloading on every click, Swup swaps the page content in via AJAX
and animates the change, so navigation feels instant and polished — a
Single-Page-Application feel on top of an otherwise traditional, server-rendered
Drupal site. It also caches visited pages so back/forward navigation is
immediate.

Swup is built as **progressive enhancement**: it layers onto your existing site
without architectural changes, uses pure vanilla JavaScript (no jQuery, roughly
a 10KB core), and gracefully falls back to normal navigation on older browsers.
It is Drupal-aware out of the box — admin pages, edit forms, and AJAX operations
are automatically excluded so transitions never interfere with the back end. The
content Swup loads still comes from ordinary, access-respecting page requests, so
the module has no effect on content permissions or access control.

The module works the moment you enable it: on any non-admin page Swup loads
automatically from a public CDN and internal links start transitioning. For more
control there is an optional **UI submodule** (`swup_ui`) that adds a settings
form where you choose the CDN provider, turn individual Swup plugins on or off,
restrict Swup to specific themes, and fine-tune which paths it applies to. For
production you can also install the library locally instead of using the CDN.
Note this is an early **alpha** release (1.0.0-alpha1). It supports Drupal 9.5,
10, and 11, and modern browsers (Chrome 61+, Firefox 60+, Safari 11+, Edge 79+).

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally add the UI submodule or a local copy of the library.
2. [Configuration](configuration/index.md) — the `swup_ui` settings form, where
   you pick the CDN provider, enable plugins, and scope where Swup runs.

## How to use it

After enabling, visit any non-admin page and click internal links — the content
swaps in with a transition instead of a full reload. Nothing else is required
for the basic effect. Because Swup fetches its JavaScript from a public CDN
(unpkg or jsDelivr) by default, that is an external request from the visitor's
browser; if you would rather serve the library from your own site, install it
locally as described in [Installation](installation/index.md). To customise
behaviour, enable the `swup_ui` submodule and open its settings form — see
[Configuration](configuration/index.md).
