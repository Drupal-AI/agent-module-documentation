# Content Redirect to Front — manual setup guide

**Content Redirect to Front** (`content_redirect_to_front`) redirects visitors
away from the canonical page of selected content types — `/node/123` and the like
— straight to your site's front page. It's useful when you build content types
purely to be *used elsewhere* — in blocks, banners, hero sections, sliders — and
you don't want those items to have their own standalone page that visitors or
search crawlers can reach directly. The content itself stays visible wherever
you've placed it; the module only stops the canonical URL from being a real
destination.

It works through an event subscriber that runs early in the request (above
Dynamic Page Cache) and matches the current route against an entity's canonical
route. If that entity type — and, optionally, its specific bundle — is enabled in
the settings, the request is answered with a redirect to the front page for the
current language. The front page itself is never redirected, and the redirect
always targets your own front page, so there's no open-redirect risk.

Two permissions shape the behaviour. **Skip redirecting to front for all
content** lets trusted roles (administrators, editors) bypass the redirect and
still view the canonical page — optionally shown a configurable warning message
explaining why they can see it. **Access content_redirect_to_front settings form**
gates the settings page itself. The module has no dependencies beyond Drupal core
and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** The project is currently seeking a new maintainer, though it is
> covered by Drupal's security advisory policy. Remember to **clear caches** after
> changing redirect settings.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types and
   bundles to redirect, set the skip permission, and optionally add a warning
   message.

## Where it lives in the admin menu

The settings form lives at
`/admin/config/content/content_redirect_to_front_settings`
(`content_redirect_to_front.settings`), reachable by users with the **Access
content_redirect_to_front settings form** permission.
