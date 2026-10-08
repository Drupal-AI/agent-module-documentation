# Open Y Google Translate — manual setup guide

**Open Y Google Translate** (`openy_gtranslate`) places the **Google Translate**
widget on your site as a block, packaged for the Open Y / YMCA Website Services
distribution but usable anywhere. It is a single block plugin
(`OpenYGTranslateBlock`) with no dependencies, routes, permissions, or settings
form — you place it through normal Block layout and control where it shows with the
usual visibility conditions.

Machine translation in the browser is the pragmatic answer for organisations that
must serve many languages but cannot fund translating any of them. For a YMCA or a
similar community organisation serving a multilingual population, the realistic
alternative is often no translation at all — and a rough automatic translation of
opening hours and programme information is worth more than an English-only page.

Three things are worth stating plainly, because they are true of the Google
Translate widget itself rather than of this module:

- **Machine translation is not site translation.** Nothing is reviewed, terminology
  is not controlled, and translated pages are not indexed as translations. Pages
  carrying legal, medical, or safety information deserve human translation
  regardless — an unreviewed automatic rendering of them is a genuine risk.
- **It is a third-party script.** The widget loads from Google and sends page
  content there. On an EU-facing site that belongs in your privacy notice and
  behind cookie consent (which a consent manager such as
  [Usercentrics](https://www.drupal.org/project/usercentrics) or a consent-mode
  module can arrange).
- **Drupal's own multilingual system is unaffected.** This is a display-layer
  overlay, not content translation, and the two coexist happily: use real
  translations where they matter and the widget as a fallback elsewhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form**. Setup is entirely a matter of placing the
block, described in "How to use it" below.

## Where it lives in the admin menu

Open Y Google Translate adds no configuration page. You place its block from
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place the **Open Y Google Translate**
   block in a region — a header region is common, so it appears site-wide.
3. Use the block's **visibility conditions** to restrict it if you want — for
   example, show it only on certain pages, or hide it on pages that already have
   proper human translations.
4. If your site faces EU visitors, add the widget to your privacy notice and gate
   it behind cookie consent, since it loads a Google script and sends page content
   to Google.
