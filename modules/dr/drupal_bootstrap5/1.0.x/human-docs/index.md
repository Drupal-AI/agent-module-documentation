# Drupal Bootstrap 5 — manual setup guide

**Drupal Bootstrap 5** (`drupal_bootstrap5`) is a small helper module that loads
the Bootstrap 5 CSS and JavaScript on every page of your site, so any theme can
use Bootstrap 5 grid classes, components, and utilities without you having to
import the framework by hand in your theme.

The problem it solves is a familiar one: getting Bootstrap into a custom or
contrib theme can be fiddly. Instead of wiring the CSS/JS into your theme's
libraries yourself, you enable this module and the assets are attached globally.
The Bootstrap files are served **locally** (no external CDN), which is friendlier
for privacy and content‑security policies.

There is **no configuration UI** — enabling the module is the entire setup. You
still have to write your own markup using Bootstrap 5 class names to actually see
any effect. A couple of things are worth knowing: because it loads Bootstrap
site‑wide, it can clash with themes that already bundle their own Bootstrap
(enable only one source), and the bundled Bootstrap version is fixed at whatever
shipped with this release — check the project's update status and audit for known
front‑end CVEs before relying on it in production. For a production site, a
maintained Bootstrap base theme such as Bootstrap Barrio is often a better fit;
this module shines for quick prototypes and admin tools that just need Bootstrap
utility classes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a pure asset loader
with no settings form, routes, or permissions.

## Where it lives in the admin menu

Drupal Bootstrap 5 adds no admin page. Once enabled, the Bootstrap 5 library is
attached to every page automatically; the rest is up to your theme's markup.
