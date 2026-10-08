# Lazy Iframe — manual setup guide

**Lazy Iframe** (`lazy_iframe`) adds the `loading="lazy"` attribute to every
`<iframe>` on your site, so embedded content — videos, maps, and other third‑party
embeds — is only fetched by the browser as it approaches the viewport. That
shortens initial page load, saves bandwidth, and can improve Core Web Vitals
scores.

The module is deliberately tiny and requires **no configuration**. Once enabled, it
automatically adds `loading="lazy"` to all iframes on the site — unless an iframe
already carries a `loading` attribute, in which case it is left alone. It has no
dependencies beyond Drupal core, and no content or access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it works automatically the
moment it is enabled.

## Where it lives in the admin menu

Lazy Iframe adds no admin page and no settings form. There is nothing to click
after enabling it.

## How to use it

There is nothing to do beyond enabling the module. From then on, iframes rendered
on your pages gain `loading="lazy"` automatically. It pairs well with other
performance modules — for example an image lazy‑loading module — if you want to
defer images as well as iframes.
