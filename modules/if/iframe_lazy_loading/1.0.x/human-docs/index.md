# Iframe Lazy Loading — manual setup guide

**Iframe Lazy Loading** (`iframe_lazy_loading`) makes embedded content load only
when the visitor scrolls near it. It automatically adds the native
`loading="lazy"` attribute to iframes on your site, so videos, maps, and widgets
that sit below the fold aren't fetched until they're about to come into view. The
result is a lighter initial page load and better perceived speed — with no custom
JavaScript involved, since it relies on the browser's built‑in lazy‑loading.

The module applies the attribute to iframes rendered by several common modules,
including the Iframe field module, Video Embed Field, and CKEditor Iframe. (It
carries forward functionality from the now‑deprecated *Native Lazy Loading*
module.) It's a pure performance enhancement with no content or access role of
its own, and it supports Drupal 10 and 11.

Best of all, there's **nothing to configure** — enable it and it does its work
automatically across the site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** — it applies lazy loading
automatically once enabled.

## Where it lives in the admin menu

Iframe Lazy Loading adds no admin page and no settings. Once enabled, it simply
adds `loading="lazy"` to the iframes it recognizes across your site.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. That's it — there's no configuration. Iframes rendered by the supported
   modules now carry `loading="lazy"` and load only as they approach the viewport.
