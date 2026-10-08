# Page Not Found Redirect — manual setup guide

**Page Not Found Redirect** (`pagenotfound_redirect`) replaces Drupal's plain "Page not
found" message with a friendly, branded **404 page** you control. Instead of a dead end,
a visitor who hits a non‑existent URL (or a deleted node) sees a custom title, a message
you've written, and a set of helpful **link buttons** guiding them back to key parts of
your site — the homepage, search, popular sections, and so on.

The module works by exposing its own 404 page at **`/friendly-404`**; you then point
Drupal's site‑wide 404 handler at that path to switch it on. The page still returns a
proper **HTTP 404** status code (so search engines and tools treat it correctly) and is
served uncached so edits appear immediately. A small built‑in **logger** also records
every broken‑URL hit to its own log channel, which is handy for spotting the mistyped or
expired URLs your visitors run into most.

The title, message and link buttons are all edited from a single settings form. Note
that these values are entered by an administrator, so this form should be limited to
**trusted administrators**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — set the title, message and link buttons,
   and point Drupal's 404 handler at `/friendly-404`.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Page Not Found Redirect**
(`/admin/config/system/pagenotfound-redirect`, route `pagenotfound_redirect.settings`),
available to users with **Administer site configuration**. The public page it produces
lives at `/friendly-404`. See [Configuration](configuration/index.md) for how to activate
it.
