# Progressive Web App (PWA) — manual setup guide

**Progressive Web App** (`pwa`) makes a Drupal site installable as an app. It
generates the `manifest.json` file that browsers read to decide whether a site
can be "added to the home screen" or installed as a standalone desktop app, and
it links that manifest (plus a matching `theme-color` meta tag) into your pages.
Once it is enabled and filled in, visitors on a phone or desktop can install
your site and launch it from an icon, in its own window, like a native app.

The heart of the module is one admin form where you describe the app: its name
and short name, the URL it should open on, the display mode (a chrome‑less
`standalone` window, `fullscreen`, `minimal-ui`, or a normal `browser` tab), the
theme and background colors, and up to three app icons (512, 192, and 144 px).
If you upload nothing, the module falls back to its own bundled icons, so a valid
manifest is served from the moment you enable it. You can also restrict which
pages carry the manifest link — by default it is added everywhere except admin,
batch, and node‑add pages.

Three optional submodules build on top of the manifest: **pwa_a2hs** adds an
"Add to Home Screen" prompt block, **pwa_extras** adds Apple/iOS‑specific meta
tags, touch icons, and splash screens, and **pwa_service_worker** adds an
experimental service worker for offline caching. The manifest is also
config‑translation aware, so you can localize its fields per language.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the manifest form, field by field,
   and how to control which pages get the manifest link.

## Where it lives in the admin menu

The manifest configuration form sits at **Configuration → Web services →
Progressive Web App → Manifest** (`/admin/config/services/pwa/manifest`) and
requires the **Administer PWA** permission. The generated manifest itself is
served at `/manifest.json`.

## How to use it

Enable the module, open the manifest form, and fill in at least the app name,
short name, and colors; upload your icons if you have them. Grant the **Access
PWA** permission to every role that should receive the manifest link (typically
anonymous and authenticated users) — the link and `theme-color` meta are only
emitted for users who hold that permission. Then load your site on a mobile
browser: the browser should offer to install it. You can confirm the manifest is
being served by visiting `/manifest.json` directly.
