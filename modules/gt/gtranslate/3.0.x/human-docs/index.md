# GTranslate — manual setup guide

**GTranslate** (`gtranslate`) adds a Google‑powered language switcher to your site
that machine‑translates the current page into around 103 languages, right in the
visitor's browser. It's a fast, cheap way to make an otherwise single‑language site
readable in many languages without translating a single string yourself.

It's important to understand what this is — and isn't. GTranslate is **automatic
machine translation by Google**, performed client‑side. It is **not** Drupal's core
Content Translation or interface translation: no translated content is stored in
Drupal, nothing is human‑reviewed, and (on the free plan) the translated pages share
the original URL and are **not** indexed by search engines. Reach for it when you want
cheap "translate this page" coverage across many languages, not when you need
editorial, SEO‑friendly multilingual content.

The whole feature is delivered as a single **block** (called "GTranslate", in the
*Accessibility* category). You place that block in a region, choose which of the ~103
languages to offer, and pick from a dozen widget styles — a floating corner switcher,
a flag dropdown, a globe, a popup with search, plain language names or codes, and
more. A single settings form controls the widget's appearance in detail: flags (2D
SVG or 3D PNG) and their size, a light or dark color scheme, floating position and
open direction, native language names, browser‑language auto‑detection, a custom CSS
selector to render into, and your own custom CSS.

For sites that need search‑engine‑indexable translations, GTranslate's **paid** plans
unlock sub‑directory (`example.com/fr`) or sub‑domain (`fr.example.com`) URL
structures and custom per‑language domains; the free mode covered here uses on‑the‑fly
JavaScript translation only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the full list of
setting keys and defaults — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — placing the block, choosing languages,
   and every setting on the widget form.

## Where it lives in the admin menu

Two places:

- The **settings form** is at **Configuration → Regional and language → GTranslate**
  (`/admin/config/regional/gtranslate`), gated by the **Configure GTranslate**
  (`gtranslate settings`) permission.
- The **GTranslate block** is placed from **Structure → Block layout**
  (`/admin/structure/block`).

## How to use it

Enable the module, place the GTranslate block in a region, choose which languages to
offer and a widget style, and save. Visitors then use the switcher to translate any
page on the fly. The step‑by‑step is in [Configuration](configuration/index.md).
