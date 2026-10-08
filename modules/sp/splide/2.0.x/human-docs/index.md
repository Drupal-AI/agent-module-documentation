# Splide — manual setup guide

**Splide** (`splide`) brings the vanilla‑JavaScript **Splide** slider/carousel library
into Drupal — no jQuery required. You build reusable slider presets called **optionsets**
(stored as configuration), then point a field formatter, a Views style, or a text‑filter
shortcode at one to render images, media, paragraphs, or view results as a carousel,
slideshow, or gallery. It's built on **Blazy**, so slide images can lazy‑load for better
performance on image‑heavy pages.

An optionset bundles all the Splide.js options — slide/loop/fade type, items per page,
gap, autoplay and interval, arrows, pagination, drag, responsive breakpoints, a visual
skin, and a group (for pairing a main slider with a thumbnail navigation slider). Because
the slider behaviour lives in the optionset rather than on each formatter, you configure a
carousel once and reuse it across many fields and views. To render content you pick one of
the field formatters (`splide_image`, `splide_media`, `splide_file`, `splide_text`,
`splide_entityreference`, `splide_paragraphs_media`, `splide_paragraphs_vanilla`), the
**Splide Slider** Views style, or the `[splide]` text‑filter shortcode — each just selects
an optionset by name.

Splide needs the external **Splide JS library** (v4+) placed under `/libraries`, plus the
**Blazy** module. Two submodules extend it: **Splide UI** provides the admin interface for
creating and editing optionsets (and the `administer splide` permission), and **Splide X**
ships ready‑made example optionsets, image styles, a demo View, and an extra skin so you
can learn from working setups. Developers can add custom skins via the `@SplideSkin`
plugin type and tune rendering with several alter hooks.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Splide JS library,
   enable it, and add the Splide UI / Splide X submodules.

## How to use it

The main module provides the engine; the **Splide UI** submodule gives you the admin
screens. The usual workflow:

1. **Create an optionset.** With Splide UI enabled, go to **Configuration → Media →
   Splide** (`/admin/config/media/splide`). Click **Add**, give it a label, and set the
   Splide options — type (slide / loop / fade), items per page, autoplay and interval,
   arrows, pagination, drag, a skin (default, classic, fullwidth, seagreen, split…), and
   any responsive breakpoints. You can also **Duplicate** an existing optionset as a
   starting point. (This requires the `administer splide` permission.)
2. **Render content through it.** Choose one of these:
   - **A field formatter** — on a bundle's *Manage display*, set a multi‑value image,
     media, file, entity‑reference or paragraphs field to the matching Splide formatter
     (e.g. **Splide Image** for an image field), then pick your optionset in the
     formatter settings.
   - **The Views style** — add a Views display and choose **Format → Splide Slider**, then
     select the optionset and map fields to the slide image/caption.
   - **The text filter** — enable the **Splide** filter on a text format and author a
     `[splide]` shortcode in body content (see the module's `FILTER_TIPS.txt` for the exact
     syntax).
3. Because the behaviour comes from the optionset, change the slider everywhere at once by
   editing the optionset — the formatters and views just reference it.

### The module's own CSS toggles

A small settings form (in the Splide UI submodule, at `/admin/config/media/splide/ui`)
controls whether the module's component CSS and the Splide library's own CSS are loaded,
and whether Splide assets load site‑wide. Most sites can leave these at their defaults.

### Thumbnail navigation and skins

Set an optionset's **group** (main / nav / thumbnail) to pair a main slider with a
thumbnail navigation slider (Splide's asNavFor). Pick a **skin** per optionset for a
prebuilt visual theme, or register your own skin with the `@SplideSkin` plugin type.
