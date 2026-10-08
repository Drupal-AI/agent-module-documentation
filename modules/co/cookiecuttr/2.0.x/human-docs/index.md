# CookieCuttr — manual setup guide

**CookieCuttr** (`cookiecuttr`) shows an EU cookie‑law consent notice on your site,
driven by the **CookieCuttr jQuery plugin**. It helps site owners comply with the EU
Directive on Privacy and Electronic Communications (the "Cookie law") by presenting
visitors with information about cookies and an opportunity to give or withhold
consent. All of the plugin's options — wording, colors, position, accept/decline
buttons, a reset link, and whether scripts are blocked until consent — are exposed
through a single Drupal settings form.

Under the hood the module attaches the CookieCuttr library on every page and passes
your settings to the front end via `drupalSettings`, so the notice renders
site‑wide. It is a purely presentational consent widget: one admin settings route,
no mutating or anonymous endpoints. It depends on the **js_cookie** library module
(which stores the visitor's consent choice), and administration is gated by the
**`administer cookiecuttr`** permission.

The module does need configuration to be useful — at minimum you enter your
cookie‑policy text and the link to your policy page. As with any consent notice,
remember that a banner only helps with compliance if the scripts that set cookies
actually respect the visitor's choice; use the module's script‑blocking option and
pair it with your analytics setup accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its `js_cookie` dependency.
2. [Configuration](configuration/index.md) — enter your notice text, links,
   buttons, and appearance.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → User interface → CookieCuttr**
(`/admin/config/user-interface/cookiecuttr`).
