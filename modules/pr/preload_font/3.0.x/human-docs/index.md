# Preload Font — manual setup guide

**Preload Font** (`preload_font`) emits `<link rel="preload">` tags for your site's
web fonts, so the browser starts fetching them at the very beginning of the page
load instead of waiting until it has parsed the CSS that references them. The
payoff is fewer font-related layout shifts and less of the "flash of unstyled
text" (FOUT) that hurts both the look of a page and its Core Web Vitals score.

Web fonts are discovered late by design: the browser parses the HTML, requests the
CSS, parses it, finds a `@font-face` rule, finds that the rule applies to text on
the page, and only *then* requests the font file — several round trips into the
load, by which point the text has already painted in a fallback font. A preload
hint moves that request to the top of the document, which is the standard fix.
Normally adding one means editing a theme; this module puts it in configuration
instead.

Three details decide whether a font preload actually helps rather than hurting,
and the configuration page is built around them — read the
[Configuration](configuration/index.md) guide before adding fonts:

- Fonts must be preloaded with **`crossorigin`**, even when they are same-origin,
  or the browser fetches the file **twice**.
- Preload only the **specific weights and subsets** that appear above the fold —
  preloading a whole nine-weight family front-loads bandwidth ahead of the CSS and
  images that decide when the page is usable.
- `font-display: swap` is a **separate, complementary** setting: the preload makes
  the font arrive sooner, while `font-display` decides what the visitor sees until
  it does.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — tell the module which font files to
   preload, and how.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Preload Font**
(`/admin/config/user-interface/preload-font`), behind the **Administer site
configuration** permission.
