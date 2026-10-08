# Localize.js — manual setup guide

**Localize.js** (`localizejs`) connects your Drupal site to
**[Localize.js](https://localizejs.com)** (localizejs.com), a hosted,
JavaScript-based translation service. Localize describes itself as a "one line of
code" solution: once its widget is on your pages, it automatically detects the
content on your site, loads it into your Localize dashboard, and gives you a
workflow to get that content translated and deployed — translating the page in the
visitor's browser rather than through Drupal's own translation system.

This module's job is simply to inject the Localize.js widget into every page,
tagged with your **Localize project key**. It also lets Localize manage a
**language switcher block** you can place on your site so visitors can change
language (Localize can even map languages to separate domains, such as
`es.example.com`). It adds its own permission and lives in the Multilingual
package.

Two things are worth understanding before you adopt it. First, this loads
**third-party JavaScript** into your site's origin — the Localize widget runs with
the same privileges as your own scripts and reads the page content in order to
translate it, so you are extending trust to the vendor. Second, your **page
content is sent to and processed by Localize.js**, which is a data-protection
consideration you should account for in your privacy policy. Treat your project
key as configuration you'd rather not leak.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your project key and place the
   language switcher block.

## Where it lives in the admin menu

The settings page is at **Configuration → System → Localize.js**
(`/admin/config/system/localizejs`). The language switcher block is placed from
**Structure → Block layout** (`/admin/structure/block`).
