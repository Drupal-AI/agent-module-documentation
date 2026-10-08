# Decoupled Preview Iframe — manual setup guide

**Decoupled Preview Iframe** (`decoupled_preview_iframe`) lets editors preview
content the way their decoupled front end will actually render it. On a headless
site, Drupal's own node page shows raw field output that looks nothing like what
visitors see — the real design lives in a separate front-end application
(Next.js, Nuxt, Astro, or anything else). This module bridges that gap by
embedding an **iframe** on the node view page, pointing at the front end's
preview URL, so authors see the finished design without leaving Drupal.

You tell it a single **preview URL** for your front-end application and which
**content types** should get the iframe treatment. For those bundles, the module
swaps the normal node build for a template that renders the iframe, and a small
JavaScript/CSS library keeps the iframe sized correctly and keeps its route in
sync with the Drupal path. It can also preview unpublished drafts, depending on
how your front end handles draft authentication, and it adjusts core's preview
toolbar so the "back to editing" experience makes sense inside the frame.

Because the Drupal node page on a headless site is really an editorial-only
page, the module can optionally **redirect anonymous visitors** away from it to
a URL you choose, so the public never lands on the bare editorial view.

It is deliberately front-end agnostic and adds no permissions of its own (the
settings form uses the standard *Administer site configuration* permission).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   the preview URL, which content types get the iframe, draft handling, and the
   anonymous redirect.

## Where it lives in the admin menu

The settings form is at **Configuration → Decoupled Preview Iframe → Settings**
(`/admin/config/decoupled_preview_iframe/settings`), gated by the *Administer
site configuration* permission. Until you set a preview URL and choose at least
one content type there, the module does nothing.
