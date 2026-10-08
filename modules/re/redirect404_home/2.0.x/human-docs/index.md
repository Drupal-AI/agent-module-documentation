# Redirect 404 to Home Page — manual setup guide

**Redirect 404 to Home Page** (`redirect404_home`) changes what happens when a visitor
requests a page that does not exist. Instead of showing Drupal's normal "Page not found"
screen, it answers the request with an HTTP redirect (you choose 301, 302, 303, or 307)
and can optionally flash a message such as "That page has moved." The idea is a
"no dead ends" policy for small or SEO-focused sites where every URL should resolve to
something rather than a 404.

The module works by overriding the controller of core's `system.404` route, so it needs
no per-path rules — it catches every missing page in one place. It has no dependencies,
no permissions of its own (it reuses the core *Administer site configuration*
permission), and no Drush commands. Everything is driven by a single settings form with
three options.

> **Important caveat.** As shipped in the 2.0.x line, the redirect target is the
> `system.404` route itself — the very route the module has overridden — which on
> Drupal 11 produces an **infinite redirect loop** to `/system/404` rather than a
> redirect to the front page the name implies. Treat "redirects to the home page" as the
> *intended* behavior and verify what actually happens on your version before relying on
> it in production. The [Configuration](configuration/index.md) page documents this in
> detail.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the three settings, how to let core fall
   through to `system.404`, and the redirect-loop caveat.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Redirect 404 to Home
Page** (`/admin/config/search/redirect404_home`), gated by the **Administer site
configuration** permission.
