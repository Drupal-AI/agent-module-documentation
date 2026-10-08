# Multilingual Google Web Page Language Translator — manual setup guide

**Multilingual Google Web Page Language Translator**
(`multilingual_google_web_translator`) adds a **Google Website Translate widget** to
your site as a block. Visitors pick a language from a dropdown and Google's
**client‑side** widget translates the current page, right in their browser, into the
chosen language. It is a quick way to make your content readable in many languages
without building real Drupal translations.

Reach for it when full editorial translation is not feasible and browser‑side
machine translation is "good enough" for accessibility and reach. You install the
module, place the block (a header region is ideal so it appears everywhere), choose
which languages to offer in the dropdown, and visitors do the rest.

It is important to understand the trade‑offs so you can set expectations. The
translation is done by Google's client‑side widget, which means **your page content
is processed by Google's service** — a privacy and data consideration you should
disclose to visitors. The quality is machine‑level, and this is a **display
convenience**, not genuine multilingual content: there are no translated URLs, no
SEO benefit, and no editorial control over the wording. It has no access‑control
role. Notably, because it relies on Google's client‑side widget, it does **not**
require a Google Translate API key or any server‑side credential.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the languages to offer and
   place the translator block.

## Where it lives in the admin menu

The module's settings form is at route
`multilingual_google_web_translator.settings`, under **Configuration** (reachable
via the module's *Configure* link on the Extend page). The translator block is
placed from **Structure → Block layout** (`/admin/structure/block`).
